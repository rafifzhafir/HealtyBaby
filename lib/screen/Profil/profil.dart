import 'package:flutter/material.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/user/user_model.dart';
import 'package:mini_project/screen/Home/home.dart';
import 'package:mini_project/screen/Login/login.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/rounded_button.dart';
import 'package:mini_project/screen/components/rounded_input_field.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  SharedPreferences? logindata;
  String? username;

  @override
  void initState() {
    super.initState();
    getUserData();
    initial();

    dbHelper = DbHelper();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata!.getString('username');
    });
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserName.text = sp.getString("user_name")!;
      _conEmail.text = sp.getString("email")!;
      _conPassword.text = sp.getString("password")!;
    });
  }

  update() async {
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user =
          UserModel(user_name: uname, email: email, password: passwd);
      await dbHelper.updateUser(user).then((value) {
        if (value == 1) {
          toastDialog(context, "Data Berhasil Diubah!", Colors.lightGreen);

          updateSP(user, true).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (Route<dynamic> route) => false);
          });
        } else {
          toastDialog(context, "Data Gagal Diubah!", Colors.redAccent);
        }
      }).catchError((error) {
        print(error);
        toastDialog(context, "Error", Colors.redAccent);
      });
    }
  }

  Future updateSP(UserModel user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user.user_name);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Profil",
        page: "/home",
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                const Text(
                  "Edit Profil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F90A6),
                    fontSize: 20,
                  ),
                ),
                RoundedInputField(
                  controller: _conEmail,
                  inputType: TextInputType.emailAddress,
                  hintText: "Email",
                  icon: Icons.email,
                  isEnable: false,
                ),
                RoundedInputField(
                  controller: _conUserName,
                  inputType: TextInputType.name,
                  hintText: "Nama Lengkap",
                  icon: Icons.person,
                ),
                RoundedInputField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintText: 'Password',
                  isObscureText: true,
                ),
                RoundedButton(
                  text: "Simpan Perubahan",
                  color: kPrimaryColor,
                  press: () {
                    update();
                  },
                ),
                RoundedButton(
                  text: "Keluar",
                  color: Colors.red,
                  press: () {
                    logindata!.setBool('login', true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        ModalRoute.withName('/'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
