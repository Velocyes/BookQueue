import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:skripskuy_web/app/controllers/notification_controller.dart';
import 'package:skripskuy_web/app/utils/splash_view.dart';
import 'package:skripskuy_web/firebase_options.dart';

import 'app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await GetStorage.init();
  runApp(BookQueue());
}

class BookQueue extends StatelessWidget {
  final authController = Get.put(AuthController(), permanent: true);
  final notificationController = Get.put(NotificationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return SplashView();
              }
              ;
              return StreamBuilder<User>(
                  stream: authController.getAuthStatus,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return Sizer(builder: (BuildContext context,
                          Orientation orientation, DeviceType deviceType) {
                        return GetMaterialApp(
                          title: "Application",
                          initialRoute: snapshot.data != null
                              ? Routes.DASHBOARD
                              : Routes.LOGIN,
                          getPages: AppPages.routes,
                        );
                      });
                    }
                    return SplashView();
                  });
            });
      },
    );
  }
}
