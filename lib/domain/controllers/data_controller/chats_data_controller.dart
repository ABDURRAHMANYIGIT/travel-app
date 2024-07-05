import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/enums/pusher_event_enum.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/models/chat_object.dart';
import '../../helpers/shared_preference.dart';
import '../../repositories/index.dart';
import 'auth_controller.dart';

class ChatsDataController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final AuthController _authController = Get.find();
  final RxList<ChatObject> _chats = RxList.empty();
  List<ChatObject> get chats => _chats;
  late WebSocketChannel _channel;
  final RxnString _socketID = RxnString();
  final Rxn<dynamic> _websocketDecodedMessage = Rxn<dynamic>();
  final RxnString _newWebSocketEvent = RxnString('');
  final RxList<Map<String, dynamic>> _messagesPairedWithChats = RxList.empty();
  List<Map<String, dynamic>> get messagesPairedWithChats =>
      _messagesPairedWithChats;
  final Rxn<PusherEvent> _pusherEvent = Rxn<PusherEvent>();
  PusherEvent? get pusherEvent => _pusherEvent.value;
  final RxBool _isConnectionEstablised = RxBool(false);
  final RxBool _subscriptionSucceeded = RxBool(false);

  @override
  void onInit() async {
    await getChats();
    await setController();
    super.onInit();
  }

  Future<void> connectToWebSocket() async {
    _channel = IOWebSocketChannel.connect(
      'ws://192.168.1.192:8080/app/ilo4mdncakc00e5urotd?protocol=7&client=js&version=8.4.0-rc2&flash=false',
    );
  }

  Future<void> subscribeToChannels() async {
    if (_socketID.value != null) {
      for (var chat in _chats) {
        await _databaseServices.broadcastAuthentication(
            channelName: 'private-chat_${chat.id}', socketID: _socketID.value!);

        final String? broadcastToken =
            await SharedPreference().getBroadcastToken();

        _channel.sink.add(
          jsonEncode(
            <String, dynamic>{
              'event': 'pusher:subscribe',
              'data': <String, dynamic>{
                'channel': 'private-chat_${chat.id}',
                'auth': broadcastToken
              }
            },
          ),
        );
      }
    }
  }

  void _handleWebSocketEvent(String? event) {
    if (event != null) {
      _pusherEvent.value = PusherEventExtension.fromString(event);
    }
  }

  Future<void> _handleSocketIDEvent(String? callback) async {
    if (callback != null) {
      await subscribeToChannels();
    }
  }

  void _handlePusherEvent(PusherEvent? event) {
    log('Pusher Event Handler Tetiklendi');
    if (event != null) {
      switch (event) {
        case PusherEvent.CONNECTION_ESTABLISHED:
          connectionEstablished();
          break;
        case PusherEvent.SUBSCRIPTION_SUCCEEDED:
          subscriptionSucceeded();
          break;
        case PusherEvent.MESSAGE_SENT:
          //messageSentOrReceived();
          break;
        case PusherEvent.MESSAGE_RECEIVED:
          // messageReceived();
          break;
      }
    }
  }

  void subscriptionSucceeded() {
    _subscriptionSucceeded.value = true;
    log(_websocketDecodedMessage.value?.toString() ?? 'No message');
  }

  void connectionEstablished() {
    _isConnectionEstablised.value = true;
    if (_websocketDecodedMessage.value?['data'] != null) {
      final dynamic data = _websocketDecodedMessage.value['data'] as dynamic;
      final dynamic dataMap = jsonDecode(data as String);
      _socketID.value = dataMap['socket_id'] as String;
      update();
    }
  }

  void listenToWebSocket() {
    _channel.stream.listen(
      (dynamic message) async {
        log('Received message: $message');
        // Check if the message contains the string 'ping'
        if (message.toString().contains('ping')) {
          // If it does, send a response with the string 'pong'
          _channel.sink.add(json.encode(
            {"event": "pusher:pong"},
          ));
        } else {
          final dynamic decodedMessage = await jsonDecode(message as String);
          _websocketDecodedMessage.value = decodedMessage;
          if (_websocketDecodedMessage.value['event'] != null) {
            if (!_isConnectionEstablised.value ||
                !_subscriptionSucceeded.value) {
              _newWebSocketEvent.value =
                  _websocketDecodedMessage.value['event'] as String;
            }

            if (_websocketDecodedMessage.value['event'] ==
                r'App\Events\MessageSent') {
              messageSentOrReceived();
            }
          }
        }
      },
      onError: (dynamic error) {
        log('Error received: $error');
      },
      onDone: () {
        log('WebSocket connection closed');
      },
      cancelOnError: false,
    );
  }

  Future<void> setController() async {
    await connectToWebSocket();
    ever(_newWebSocketEvent, _handleWebSocketEvent);
    ever(_pusherEvent, _handlePusherEvent);
    ever(_socketID, _handleSocketIDEvent);
    initializeChatAndMessagePairing();
    listenToWebSocket();
  }

  Future<void> initializeChatAndMessagePairing() async {
    for (var chat in _chats) {
      _messagesPairedWithChats.add({'chat': chat, 'messages': []});
    }
    update();
  }

  Future<void> getChats() async {
    _chats.value = await _databaseServices.getAllChats();
    update();
  }

  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId}) async {
    final newChat = await _databaseServices.createNewChat(
        userOneId: userOneId, userTwoId: userTwoId);
    if (newChat != null) {
      _messagesPairedWithChats.add({'chat': newChat, 'messages': []});
      await getChats();
      update();
    }
    return newChat;
  }

  Future<bool> sendMessage(
      {required String message, required int receiverId}) async {
    var result = false;

    if (_socketID.value != null) {
      result = await _databaseServices.sendMessage(
          message: message, receiverId: receiverId, socketId: _socketID.value!);

      if (result) {
        final targetChatIndex = _messagesPairedWithChats.indexWhere((element) =>
            element['chat'].userOneId == receiverId ||
            element['chat'].userTwoId == receiverId);

        if (targetChatIndex != -1) {
          // Chat found, update its messages
          if (_authController.getAuthUser?.id != null) {
            final newMessage = MessageObject()
              ..content = message
              ..idFrom = _authController.getAuthUser!.id
              ..idTo = receiverId;
            _messagesPairedWithChats[targetChatIndex]['messages']
                .add(newMessage);
            _messagesPairedWithChats.refresh();
          }
        } else {
          // Chat not found
          log('CHAT NOT FOUND');
        }
      }
      update();
    }
    return result;
  }

  void messageSentOrReceived() async {
    final MessageObject _newMessage = getChatMessageFromSocket();

    final targetChatIndex = _messagesPairedWithChats
        .indexWhere((element) => element['chat'].id == _newMessage.chatId);

    _messagesPairedWithChats[targetChatIndex]['messages'].add(_newMessage);
    _messagesPairedWithChats.refresh();

    update();
  }

  MessageObject getChatMessageFromSocket() {
    final Map<String, dynamic> _wsMessage =
        _websocketDecodedMessage.value as Map<String, dynamic>;
    final Map<String, dynamic> _newMessageData =
        jsonDecode(_wsMessage['data'] as String) as Map<String, dynamic>;
    final Map<String, dynamic> _newMessageJSON =
        _newMessageData['message'] as Map<String, dynamic>;

    final MessageObject chatMessage = MessageObject.fromJson(_newMessageJSON);

    return chatMessage;
  }
}
