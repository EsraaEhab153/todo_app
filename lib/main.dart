import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/provider/task_list_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/providers/language_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/styling/theme_data.dart';

import 'auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguageProvider langProvider = AppLanguageProvider();
  AppThemeProvider themeProvider = AppThemeProvider();
  await langProvider.getLang();
  await themeProvider.getTheme();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: 'AIzaSyCMa9gD_xF5qDE4gJGAPLapAHIPO4kmKHE',
              appId: 'com.example.todo_app',
              messagingSenderId: '542304008037',
              projectId: 'my-todo-app-4ef70'))
      : await Firebase.initializeApp();
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => langProvider),
        ChangeNotifierProvider(
          create: (context) => themeProvider,
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => TaskListProvider())
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(langProvider.appLanguage),
      themeMode: themeProvider.appTheme,
      theme: MyThemeData.lightModeStyle,
      darkTheme: MyThemeData.darkModeStyle,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName : (context)=> HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
    );
  }
}