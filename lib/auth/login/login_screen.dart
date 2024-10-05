import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/dialog_utils.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/home_screen.dart';

import '../../provider/user_provider.dart';
import '../../styling/app_colors.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Stack(
      children: [
        Container(
          color: themeProvider.isDark()
              ? AppColors.darkBackgroundColor
              : AppColors.lightBackgroundColor,
          child: Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcome_back,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: themeProvider.isDark()
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                          fontSize: 24),
                    ),
                    CustomTextFormField(
                      label: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      controller: passwordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forget_password,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.primaryColor),
                        )),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.whiteColor),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: MediaQuery.of(context).size.height * 0.04,
                          )
                        ],
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.or_create_account,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.primaryColor),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (_formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(context: context, content: 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');

        if (user == null) {
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(user);

        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context: context,
          message: 'Login Successfully!',
          posActionName: 'Ok',
          posAction: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context: context,
              message: 'Email or Password is incorrect !',
              posActionName: 'ok');
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            posActionName: 'Ok',
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context: context, message: e.toString(), posActionName: 'Ok');
      }
    }
  }
}
