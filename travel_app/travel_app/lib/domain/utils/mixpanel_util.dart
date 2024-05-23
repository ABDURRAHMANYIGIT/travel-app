import 'dart:developer';

import 'package:mixpanel_flutter/mixpanel_flutter.dart';

import '../../resources/config/app_info.dart';
import '../helpers/shared_preference.dart';

class MixpanelHelper {
  MixpanelHelper() {
    init();
  }
  Mixpanel? mixpanel;

  Future<void> init() async {
    mixpanel = Mixpanel(AppInfo.mixpanelId);
    mixpanel =
        await Mixpanel.init(AppInfo.mixpanelId, trackAutomaticEvents: true);
    log('[MIXPANEL HELPER] - init');
  }

  void track(String event, {Map<String, dynamic>? properties}) {
    mixpanel?.track(event, properties: properties);
    log('[MIXPANEL HELPER] - track - $event');
  }

  void timeEvent(String event) {
    mixpanel?.timeEvent(
      event,
    );
    log('[MIXPANEL HELPER] - timeEvent - $event');
  }

  void logout() {
    track('Logout User');
    // mixpanel?.reset();
    log('[MIXPANEL HELPER] - reset');
  }

  void registerSuperPropertiesOnce({required Map<String, dynamic> properties}) {
    mixpanel?.registerSuperPropertiesOnce(properties);
    log('[MIXPANEL HELPER] - registerSuperPropertiesOnce - $properties');
  }

  void setAlias() {
    mixpanel?.alias('new_id', 'existing_id');
    log('[MIXPANEL HELPER] - setAlias - ');
  }

  //User properties
  Future<void> identifyUser() async {
    final String? id = await SharedPreference().getUserId();
    if (id != null) {
      mixpanel?.identify(id);
    }
    log('MixpanelUtil - setUserId : $id');
  }

  Future<void> setUserEmail({
    required String userId,
    required String email,
  }) async {
    mixpanel?.identify(userId);
    mixpanel?.getPeople().set(r'$email', email);
    log('[MIXPANEL HELPER] - setUserEmail - userId => $userId email => $email');
  }
}
