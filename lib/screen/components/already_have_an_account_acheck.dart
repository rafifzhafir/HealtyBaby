import 'package:flutter/material.dart';
import 'package:mini_project/screen/constants/color.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Tidak memiliki akun ? " : "Sudah memiliki akun ? ",
          style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 15,
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Daftar disini" : "Login",
            style: const TextStyle(
              color: kPrimaryColor,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        )
      ],
    );
  }
}
