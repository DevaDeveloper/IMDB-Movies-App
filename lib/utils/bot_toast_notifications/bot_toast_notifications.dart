import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:imdb_movies_app/styles/colors.dart';

class BotToastNotifications {
  static void showErrorNotification(BuildContext context, String title) {
    BotToast.showSimpleNotification(
      title: title,
      hideCloseButton: true,
      titleStyle: TextStyle(color: AppColorsLight.botToastForegroundColor),
      backgroundColor: AppColorsLight.errorBackgroundColor,
    );
  }

  static void showSuccessfulNotification(BuildContext context, String title) {
    BotToast.showSimpleNotification(
      title: title,
      hideCloseButton: true,
      titleStyle: TextStyle(color: AppColorsLight.botToastForegroundColor),
      backgroundColor: AppColorsLight.successfulBackgroundColor,
    );
  }
}
