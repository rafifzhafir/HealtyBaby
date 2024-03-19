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
                      name: "Imunisasi",
                      urlIcon: "assets/icons/baby.png",
                      color: Color.fromARGB(255, 255, 142, 122),
                      onTap: () {
                        Navigator.of(context).pushNamed("/bayi");
                      },
                    ),
                    CardMenu(
                      name: "Riwayat",
                      urlIcon: "assets/icons/immunity.png",
                      color: Color.fromARGB(255, 100, 210, 253),
                      onTap: () {
                        Navigator.of(context).pushNamed("/riwayat");
                      },
                    ),
                    CardMenu(
                      name: "Artikel",
                      urlIcon: "assets/icons/info.png",
                      color: Color.fromARGB(255, 169, 221, 56),
                      onTap: () {
                        Navigator.of(context).pushNamed("/info");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10,right: 10),
                  child: Positioned(
                    bottom: 0,
                    child: Image.asset("assets/images/tumbuh.png")
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
