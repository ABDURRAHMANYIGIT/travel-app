enum PusherEvent {
  CONNECTION_ESTABLISHED,
  SUBSCRIPTION_SUCCEEDED,
  MESSAGE_SENT,
  MESSAGE_RECEIVED,
}

extension PusherEventExtension on PusherEvent {
  String get event {
    switch (this) {
      case PusherEvent.CONNECTION_ESTABLISHED:
        return 'pusher:connection_established';
      case PusherEvent.SUBSCRIPTION_SUCCEEDED:
        return 'pusher_internal:subscription_succeeded';
      case PusherEvent.MESSAGE_SENT:
        return r'App\\Events\\MessageSent';
      case PusherEvent.MESSAGE_RECEIVED:
        return r'App\\Events\\MessageRecieved';
    }
  }

  static PusherEvent? fromString(String s) {
    switch (s) {
      case 'pusher:connection_established':
        return PusherEvent.CONNECTION_ESTABLISHED;
      case 'pusher_internal:subscription_succeeded':
        return PusherEvent.SUBSCRIPTION_SUCCEEDED;
      case r'App\Events\MessageSent':
        return PusherEvent.MESSAGE_SENT;
      case r'App\Events\MessageRecieved':
        return PusherEvent.MESSAGE_RECEIVED;
    }
    return null;
  }
}
