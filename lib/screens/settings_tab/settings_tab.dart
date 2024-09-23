import 'package:flutter/material.dart';
import 'package:todo_app/screens/settings_tab/language_bottom_sheet.dart';
import 'package:todo_app/screens/settings_tab/theme_bottom_sheet.dart';
import 'package:todo_app/styling/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.1,
          color: AppColors.primaryColor,
        ),
        Padding(
          padding: EdgeInsets.all(width * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              InkWell(
                onTap: () {
                  showLanguageBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.all(width * 0.04),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  width: width * 0.7,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'English',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: AppColors.primaryColor,
                        size: width * 0.07,
                      )
                    ],
                  ),
                ),
              ),
              Text(
                'Mode',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              InkWell(
                onTap: () {
                  showThemeBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.all(width * 0.04),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  width: width * 0.7,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Light',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: AppColors.primaryColor,
                        size: width * 0.07,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
