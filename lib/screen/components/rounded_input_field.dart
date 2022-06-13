import 'package:flutter/material.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/text_field_container.dart';
import 'package:mini_project/screen/constants/color.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType inputType;
  final bool isEnable;
  final String hintText;
  final IconData icon;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isEnable = true,
    this.isObscureText = false,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        enabled: isEnable,
        keyboardType: inputType,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tolong Input $hintText';
          }
          if (hintText == "Email" && !validateEmail(value)) {
            return 'Tolong Input Email yang Benar';
          }
          return null;
        },
      ),
    );
  }
}
