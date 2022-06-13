import 'package:flutter/material.dart';
import 'package:mini_project/screen/Home/components/card_menu.dart';
import 'package:mini_project/screen/Home/components/card_profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String getName = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getUser() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      getName = sp.getString("user_name")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CardProfile(
                  name: getName.isEmpty ? "Ambil Nama Gagal" : getName,
                ),
                GridView.count(
                  childAspectRatio: 0.9,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: <Widget>[
                    CardMenu(
                      name: "Daftar\nBayimu",
                      urlIcon: "assets/icons/baby.png",
                      color: Colors.yellow,
                      onTap: () {
                        Navigator.of(context).pushNamed("/bayi");
                      },
                    ),
                    CardMenu(
                      name: "Riwayat\nImunisasi",
                      urlIcon: "assets/icons/immunity.png",
                      color: Colors.blueAccent,
                      onTap: () {
                        Navigator.of(context).pushNamed("/riwayat");
                      },
                    ),
                    CardMenu(
                      name: "Informasi\nImunisasi",
                      urlIcon: "assets/icons/info.png",
                      color: Colors.greenAccent,
                      onTap: () {
                        Navigator.of(context).pushNamed("/info");
                      },
                    ),
                    // CardMenu(
                    //   name: "Tabel\nImunisasi",
                    //   urlIcon: "assets/icons/table.png",
                    //   color: Colors.redAccent,
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
