import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
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
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
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
                AppLocalizations.of(context)!.language,
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
                    color: themeProvider.isDark()
                        ? AppColors.darkGrayColor
                        : AppColors.whiteColor,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        langProvider.appLanguage == 'en'
                            ? AppLocalizations.of(context)!.english
                            : AppLocalizations.of(context)!.arabic,
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
                AppLocalizations.of(context)!.mode,
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
                    color: themeProvider.isDark()
                        ? AppColors.darkGrayColor
                        : AppColors.whiteColor,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        themeProvider.isDark()
                            ? AppLocalizations.of(context)!.dark
                            : AppLocalizations.of(context)!.light,
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
