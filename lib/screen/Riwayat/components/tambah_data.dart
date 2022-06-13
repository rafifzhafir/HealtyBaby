import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mini_project/api/api_imunisasi.dart';
import 'package:mini_project/database/db_helper.dart';
import 'package:mini_project/model/imunisasi/imunisasi_model.dart';
import 'package:mini_project/model/riwayat/riwayat_model.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/rounded_button.dart';
import 'package:mini_project/screen/components/rounded_input_date.dart';
import 'package:mini_project/screen/components/text_field_container.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:mini_project/state/riwayat_state.dart';
import 'package:provider/provider.dart';

class TambahRiwayatPage extends StatefulWidget {
  final int id;
  const TambahRiwayatPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TambahRiwayatPage> createState() => _TambahRiwayatPageState();
}

class _TambahRiwayatPageState extends State<TambahRiwayatPage> {
  final _formKey = GlobalKey<FormState>();
  final _conImunisasi = TextEditingController();
  final _conDate = TextEditingController();
  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  tambahData() async {
    String imunisasi = _conImunisasi.text;
    String date = _conDate.text;
    int getId = widget.id;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      RiwayatModel riwayatModel = RiwayatModel(
        imunisasi: imunisasi,
        tanggal_imunisasi: date,
        id_bayi: getId,
      );
      await dbHelper.saveDataRiwayat(riwayatModel).then((value) {
        toastDialog(context, "Data Berhasil Dibuat!", Colors.lightGreen);
        Provider.of<RiwayatState>(context, listen: false).getDataRiwayat(getId);

        Navigator.pop(context);
      }).catchError((error) {
        print(error);
        toastDialog(
            context, "Error: Data Tidak Berhasil Dibuat!", Colors.redAccent);
      });
    }
  }

  @override
  void dispose() {
    _conImunisasi.dispose();
    _conDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Riwayat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
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
              TextFieldContainer(
                child: autoCompleteField(),
              ),
              RoundedInputDate(
                hintText: "Tanggal Imunisasi",
                icon: Icons.calendar_month_outlined,
                controller: _conDate,
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

  TypeAheadFormField<ImunisasiModel?> autoCompleteField() {
    return TypeAheadFormField<ImunisasiModel?>(
      hideSuggestionsOnKeyboardHide: false,
      textFieldConfiguration: TextFieldConfiguration(
        controller: _conImunisasi,
        cursorColor: kPrimaryColor,
        decoration: const InputDecoration(
          icon: Icon(
            Icons.vaccines_rounded,
            color: kPrimaryColor,
          ),
          hintText: "Jenis Imunisasi",
          border: InputBorder.none,
        ),
      ),
      suggestionsCallback: (pattern) {
        return ImunisasiRepo.getUserSuggestions(pattern);
      },
      itemBuilder: (context, ImunisasiModel? suggestion) {
        final user = suggestion!;
        return ListTile(
          title: Text(user.nama_imunisasi),
        );
      },
      noItemsFoundBuilder: (context) => const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Imunisasi Tidak Ada.',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
      onSuggestionSelected: (ImunisasiModel? suggestion) {
        _conImunisasi.text = suggestion!.nama_imunisasi;
      },
      validator: (value) => value != null && value.isEmpty
          ? 'Tolong Input Jenis Imunisasi'
          : null,
    );
  }
}
