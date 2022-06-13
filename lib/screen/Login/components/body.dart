import 'package:flutter/material.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/user/user_model.dart';
import 'package:mini_project/screen/Login/components/background.dart';
import 'package:mini_project/screen/components/already_have_an_account_acheck.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/rounded_button.dart';
import 'package:mini_project/screen/components/rounded_input_field.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;
  SharedPreferences? logindata;
  bool? newuser;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    ChechkLogin();
  }

  void ChechkLogin() async {
    logindata = await _pref;
    newuser = (logindata!.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  login() async {
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    if (email.isEmpty) {
      toastDialog(context, "Tolong Input Email", Colors.redAccent);
    } else if (passwd.isEmpty) {
      toastDialog(context, "Tolong Input Password", Colors.redAccent);
    } else {
      await dbHelper.getLoginUser(email, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            logindata!.setBool('login', false);
            logindata!.setString('email', email);
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", ModalRoute.withName('/'));
          });
        } else {
          toastDialog(
              context, "Error: Akun Tidak Ditemukan!", Colors.redAccent);
        }
      }).catchError((error) {
        print(error);
        toastDialog(context, "Error: Login Gagal!", Colors.redAccent);
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  void dispose() {
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
                "assets/images/login.png",
                height: size.height * 0.35,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F90A6),
                  fontSize: 20,
                ),
              ),
              RoundedInputField(
                controller: _conEmail,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
                icon: Icons.email,
              ),
              RoundedInputField(
                controller: _conPassword,
                icon: Icons.lock,
                hintText: 'Password',
                isObscureText: true,
              ),
              RoundedButton(
                text: "Login",
                color: kPrimaryColor,
                press: () {
                  login();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.of(context).pushNamed("/register");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
