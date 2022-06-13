import 'package:flutter/material.dart';
import 'package:mini_project/screen/Riwayat/components/body.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';
import 'package:mini_project/screen/constants/color.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCustom(
        title: "Riwayat Imunisasi",
        page: "/home",
      ),
      body: Body(),
    );
  }
}
