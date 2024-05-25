abstract class AnalyticsEvent {
  String getEventName();

  Map<String, dynamic> toMap() => <String, dynamic>{};
}

class LogoutAnalyticsEvent extends AnalyticsEvent {
  @override
  String getEventName() => 'logout';
}

class BirthDayAnalyticsEvent extends AnalyticsEvent {
  BirthDayAnalyticsEvent({required this.age});
  int age;

  @override
  String getEventName() => 'birthday';

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user_age': age};
  }
}

class DialogCancelButtonAnalyticsEvent extends AnalyticsEvent {
  DialogCancelButtonAnalyticsEvent({required this.dialogName});
  String dialogName;

  @override
  String getEventName() => '$dialogName Dialog Cancel Button Click';
}

class DialogConfirmButtonAnalyticsEvent extends AnalyticsEvent {
  DialogConfirmButtonAnalyticsEvent({required this.dialogName});
  String dialogName;

  @override
  String getEventName() => '$dialogName Dialog Confirm Button Click';
}

class ButtonClickAnalyticsEvent extends AnalyticsEvent {
  ButtonClickAnalyticsEvent({required this.buttonName});
  String buttonName;

  @override
  String getEventName() => '$buttonName Button Click';
}

class DarkModeSwitchAnalyticsEvent extends AnalyticsEvent {
  DarkModeSwitchAnalyticsEvent({required this.darkMode});
  String darkMode;

  @override
  String getEventName() => 'Dark Mode Switch is clicked';

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'dark_mode': darkMode};
  }
}
