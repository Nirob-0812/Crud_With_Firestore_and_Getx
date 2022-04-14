import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Notification_Controller>(Notification_Controller());
  }
}

class Notification_Controller extends GetxController {
  void send_notification() {
    AwesomeNotifications().isNotificationAllowed().then((isallowed) {
      if (!isallowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 1,
            title: "Theme Changed",
            body: "This is Dark Theme",
            channelKey: "test channel"));
  }
}
