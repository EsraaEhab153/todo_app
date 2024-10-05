import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/styling/app_colors.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String content}) {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [const CircularProgressIndicator(), Text(content)],
            ),
            backgroundColor: themeProvider.isDark()
                ? AppColors.darkGrayColor
                : AppColors.whiteColor,
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required message,
    String title = '',
    String? posActionName,
    String? negActionName,
    Function? posAction,
    Function? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.primaryColor),
          )));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          var themeProvider =
              Provider.of<AppThemeProvider>(context, listen: false);
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: actions,
            backgroundColor: themeProvider.isDark()
                ? AppColors.darkGrayColor
                : AppColors.whiteColor,
          );
        });
  }
}
