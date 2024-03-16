import 'package:horsian/Resources/exports.dart';

class NotificationServices{
    static FirebaseMessaging messaging = FirebaseMessaging.instance;

    static Future<void> requestPermission() async {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: true,
        criticalAlert: true,
        sound: true
      );
      if(settings.authorizationStatus==AuthorizationStatus.authorized){
        print('Enabled');
      }else{
       await AppSettings.openAppSettings(type: AppSettingsType.notification);
      }
    }
}