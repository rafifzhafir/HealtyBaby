import 'package:flutter/material.dart';
import 'package:mini_project/screen/Bayi/components/body.dart';
import 'package:mini_project/screen/Bayi/components/tambah_data.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/components/floating_button.dart';

class BayiPage extends StatelessWidget {
  const BayiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Data Bayimu",
        page: "/home",
      ),
      body: const Center(
        child: Body(),
      ),
      floatingActionButton: FloatingBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahData()),
          );
        },
      ),
    );
  }
}
