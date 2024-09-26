import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/styling/app_colors.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLanguageProvider>(context);

    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              //change language to english
              langProvider.changLanguage('en');
            },
            child: langProvider.appLanguage == 'en'
                ? selectedItem(AppLocalizations.of(context)!.english)
                : unSelectedItem(AppLocalizations.of(context)!.english),
          ),
          const Divider(
            color: AppColors.primaryColor,
          ),
          InkWell(
            onTap: () {
              //change language to arabic
              langProvider.changLanguage('ar');
            },
            child: langProvider.appLanguage == 'ar'
                ? selectedItem(AppLocalizations.of(context)!.arabic)
                : unSelectedItem(AppLocalizations.of(context)!.arabic),
          )
        ],
      ),
    );
  }

  Widget selectedItem(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
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

  Widget unSelectedItem(String language) {
    return Text(
      language,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
