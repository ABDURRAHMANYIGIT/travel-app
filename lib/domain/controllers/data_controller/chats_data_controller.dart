import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/enums/pusher_event_enum.dart';
import '../../../data/models/chat_object.dart';
import '../../repositories/index.dart';
import 'auth_controller.dart';

class ChatsDataController extends GetxController {
  final DatabaseServices _databaseServices = DatabaseServices();
  final AuthController _authController = Get.find();
  final RxList<ChatObject> _chats = RxList.empty();
  List<ChatObject> get chats => _chats;
  late WebSocketChannel _channel;

  final Rxn<PusherEvent> _pusherEvent = Rxn<PusherEvent>();
  PusherEvent? get pusherEvent => _pusherEvent.value;

  @override
  void onInit() async {
    await connectToWebSocket();
    await getChats();
    await subscribeToChannels();
    super.onInit();
  }

  Future<void> connectToWebSocket() async {
    _channel = IOWebSocketChannel.connect(
      'ws://192.168.1.192:8080/app/jcio9ydxgamot62cpxxn?protocol=7&client=js&version=8.4.0-rc2&flash=false',
    );
  }

  Future<void> subscribeToChannels() async {
    for (var chat in _chats) {
      _channel.sink.add(
        jsonEncode(
          <String, dynamic>{
            'event': 'pusher:subscribe',
            'data': <String, dynamic>{
              'channel': 'private-chat_${chat.id}',
            }
          },
        ),
      );
    }
  }

  void listenToWebSocket() {
    _channel.stream.listen(
      (dynamic message) {
        log('Received message: $message');
        // final dynamic decodedMessage = jsonDecode(message as String);
        // _websocketDecodedMessage.value = decodedMessage;
        // if (decodedMessage['event'] != null) {
        //   _newWebSocketEvent.value = decodedMessage['event'] as String?;
        // }
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
}
