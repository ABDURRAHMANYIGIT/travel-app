import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/enums/pusher_event_enum.dart';
import '../../../data/models/chat_message.dart';
import '../../../data/models/chat_object.dart';
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
  final RxList<Map<Map<String, ChatObject>, Map<String, List<MessageObject>>>>
      _messagesPairedWithChats = RxList.empty();
  final Rxn<PusherEvent> _pusherEvent = Rxn<PusherEvent>();
  PusherEvent? get pusherEvent => _pusherEvent.value;

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
        _databaseServices.broadcastAuthentication(
            channelName: 'chat_${chat.id}', socketID: _socketID.value!);
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
    if (event != null) {
      switch (event) {
        case PusherEvent.CONNECTION_ESTABLISHED:
          connectionEstablished();
          break;
        case PusherEvent.SUBSCRIPTION_SUCCEEDED:
          subscriptionSucceeded();
          break;
        case PusherEvent.MESSAGE_SENT:
          // messageSentOrReceived();
          break;
        case PusherEvent.MESSAGE_RECEIVED:
          // messageReceived();
          break;
      }
    }
  }

  void subscriptionSucceeded() {
    log(_websocketDecodedMessage.toString());
  }

  void connectionEstablished() {
    if (_websocketDecodedMessage.value['data'] != null) {
      final dynamic data = _websocketDecodedMessage.value['data'] as dynamic;
      final dynamic dataMap = jsonDecode(data as String);
      _socketID.value = dataMap['socket_id'] as String;
      update();
    }
  }

  void listenToWebSocket() {
    _channel.stream.listen(
      (dynamic message) {
        log('Received message: $message');
        final dynamic decodedMessage = jsonDecode(message as String);
        _websocketDecodedMessage.value = decodedMessage;
        if (decodedMessage['event'] != null) {
          _newWebSocketEvent.value = decodedMessage['event'] as String?;
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
    listenToWebSocket();
  }

  Future<void> getChats() async {
    _chats.value = await _databaseServices.getAllChats();
    update();
  }

  Future<ChatObject?> createNewChat(
      {required int userOneId, required int userTwoId}) async {
    final newChat = await _databaseServices.createNewChat(
        userOneId: userOneId, userTwoId: userTwoId);
    await getChats();
    update();
    return newChat;
  }

  Future<bool> sendMessage(
      {required String message, required int receiverId}) async {
    final result = await _databaseServices.sendMessage(
        message: message, receiverId: receiverId);
    if (result) {
      final targetChat = _chats.where((chat) =>
          chat.userOneId == receiverId || chat.userTwoId == receiverId);
      _messagesPairedWithChats.add(element)
    }
    return result;
  }
}
