/* Future<void> initOneSignalPushMessages() async {
    //OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    await OneSignal.shared
        .init("3cfbaca5-2b90-4f68-a1fe-98aa9a168894", iOSSettings: settings);

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setLocationShared(true);

    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }*/
