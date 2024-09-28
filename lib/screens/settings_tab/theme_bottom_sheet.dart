import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/styling/app_colors.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              //change theme to light
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: themeProvider.isDark()
                ? unSelectedItem(AppLocalizations.of(context)!.light)
                : selectedItem(AppLocalizations.of(context)!.light),
          ),
          const Divider(
            color: AppColors.primaryColor,
          ),
          InkWell(
            onTap: () {
              //change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDark()
                ? selectedItem(AppLocalizations.of(context)!.dark)
                : unSelectedItem(AppLocalizations.of(context)!.dark),
          )
        ],
      ),
    );
  }

  Widget selectedItem(String theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          theme,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.primaryColor),
        ),
        Icon(
          Icons.check,
          size: MediaQuery.of(context).size.height * 0.04,
          color: AppColors.primaryColor,
        )
      ],
    );
  }

  Widget unSelectedItem(String theme) {
    return Text(
      theme,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
