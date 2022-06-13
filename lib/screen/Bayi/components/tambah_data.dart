import 'package:flutter/material.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/bayi/bayi_model.dart';
import 'package:mini_project/screen/Bayi/bayi_page.dart';
import 'package:mini_project/screen/Bayi/components/input_gender.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/rounded_button.dart';
import 'package:mini_project/screen/components/rounded_input_date.dart';
import 'package:mini_project/screen/components/rounded_input_field.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:mini_project/state/bayi_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class TambahData extends StatefulWidget {
  const TambahData({Key? key}) : super(key: key);

  @override
  State<TambahData> createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final _formKey = GlobalKey<FormState>();
  final _conName = TextEditingController();
  final _conDate = TextEditingController();
  String _gender = "";
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String getEmail = "";
  late DbHelper dbHelper;

  void _pilihGender(String value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    getUser();
  }

  Future<void> getUser() async {
    final SharedPreferences sp = await _pref;
    getEmail = sp.getString("email")!;
  }

  tambahData() async {
    String uname = _conName.text;
    String date = _conDate.text;

    if (_formKey.currentState!.validate()) {
      if (_gender == "") {
        toastDialog(context, 'Jenis Kelamin Harus Dipilih!', Colors.redAccent);
      } else {
        _formKey.currentState!.save();
        BayiModel bayiModel = BayiModel(
          nama: uname,
          gender: _gender,
          tanggal_lahir: date,
          email: getEmail,
        );
        await dbHelper.saveDataBayi(bayiModel).then((value) {
          toastDialog(context, "Data Berhasil Dibuat!", Colors.lightGreen);
          Provider.of<BayiState>(context, listen: false).getDataBayi();

          Navigator.pushReplacementNamed(context, "/bayi");
        }).catchError((error) {
          print(error);
          toastDialog(
              context, "Error: Data Tidak Berhasil Dibuat!", Colors.redAccent);
        });
      }
    }
  }

  @override
  void dispose() {
    _conName.dispose();
    _conDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Tambah Data",
        page: "/bayi",
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Isi data dengan teliti dan benar!",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold),
              ),
              RoundedInputField(
                controller: _conName,
                inputType: TextInputType.name,
                hintText: "Nama Bayi",
                icon: Icons.child_care_rounded,
              ),
              RoundedInputDate(
                hintText: "Tanggal Lahir",
                icon: Icons.calendar_month_outlined,
                controller: _conDate,
              ),
              GenderInput(
                gender: _gender,
                onChanged: (String? value) {
                  _pilihGender(value!);
                },
              ),
              RoundedButton(
                text: "Simpan",
                color: kPrimaryColor,
                press: () {
                  tambahData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
