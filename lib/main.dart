import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/styling/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('ar'),
      theme: MyThemeData.lightModeStyle,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (context)=> HomeScreen(),
      },
    );
  }
}