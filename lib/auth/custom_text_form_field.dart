import 'package:flutter/material.dart';
import 'package:todo_app/styling/app_colors.dart';

typedef Validator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType;

  Validator validator;
  bool obscureText;

  CustomTextFormField(
      {super.key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      required this.validator,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
      child: TextFormField(
        decoration: InputDecoration(
          label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: AppColors.redColor)),
        ),
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}
