import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/styling/app_colors.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: selectedItem(),
          ),
          Divider(
            color: AppColors.primaryColor,
          ),
          InkWell(
            onTap: () {},
            child: unSelectedItem(),
          )
        ],
      ),
    );
  }

  Widget selectedItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.english,
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

  Widget unSelectedItem() {
    return Text(
      AppLocalizations.of(context)!.arabic,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
