import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/user.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/styling/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'esraa');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

  TextEditingController emailController =
      TextEditingController(text: 'esraa@gmail.com');

  final _formKey = GlobalKey<FormState>();

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
              AppLocalizations.of(context)!.register,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    CustomTextFormField(
                      label: 'User Name',
                      controller: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter User Name';
                        }
                        return null;
                      },
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
                        if (text.length < 6) {
                          return 'Password must be at least 6 chars.';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    CustomTextFormField(
                      label: 'Confirm Password',
                      controller: confirmPasswordController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Confirm Password';
                        }
                        if (text != passwordController.text) {
                          return "The Confirm password doesn't match Password";
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        register();
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
                            AppLocalizations.of(context)!.or_create_account,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context, content: 'Loading...');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);

        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(
            context: context,
            message: 'Register Successesfully',
            posActionName: 'Ok',
            posAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            message: 'The password provided is too weak',
            posActionName: 'Ok',
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);

          DialogUtils.showMessage(
            context: context,
            message: 'The account already exists for that email.',
            posActionName: 'Ok',
          );
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
            context: context,
            message: e.toString(),
            posActionName: 'Ok',
            negActionName: 'cancel');
      }
    }
  }
}
