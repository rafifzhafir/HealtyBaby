import 'package:flutter/material.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/user/user_model.dart';
import 'package:mini_project/screen/Register/components/background.dart';
import 'package:mini_project/screen/components/already_have_an_account_acheck.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/rounded_button.dart';
import 'package:mini_project/screen/components/rounded_input_field.dart';
import 'package:mini_project/screen/constants/color.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        toastDialog(context, 'Password Tidak Sama!', Colors.redAccent);
      } else {
        _formKey.currentState!.save();

        UserModel uModel =
            UserModel(user_name: uname, email: email, password: passwd);
        await dbHelper.saveDataUser(uModel).then((userData) {
          toastDialog(context, "Akun Berhasil Dibuat!", Colors.lightGreen);

          Navigator.pushNamedAndRemoveUntil(
              context, '/login', ModalRoute.withName('/'));
        }).catchError((error) {
          print(error);
          toastDialog(
              context, "Error: Akun Tidak Berhasil Dibuat!", Colors.redAccent);
        });
      }
    }
  }

  @override
  void dispose() {
    _conUserName.dispose();
    _conCPassword.dispose();
    _conEmail.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Background(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/register.png",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                "Daftar Akun",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F90A6),
                  fontSize: 20,
                ),
              ),
              RoundedInputField(
                controller: _conUserName,
                inputType: TextInputType.name,
                hintText: "Nama Lengkap",
                icon: Icons.person,
              ),
              RoundedInputField(
                controller: _conEmail,
                inputType: TextInputType.emailAddress,
                hintText: "Email",
                icon: Icons.email,
              ),
              RoundedInputField(
                controller: _conPassword,
                icon: Icons.lock,
                hintText: 'Password',
                isObscureText: true,
              ),
              RoundedInputField(
                controller: _conCPassword,
                icon: Icons.lock,
                hintText: 'Konfirmasi Password',
                isObscureText: true,
              ),
              RoundedButton(
                text: "Daftar",
                color: kPrimaryColor,
                press: () {
                  signUp();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
