import 'package:flutter/material.dart';
import 'package:mini_project/screen/Bayi/bayi_page.dart';
import 'package:mini_project/screen/Home/home.dart';
import 'package:mini_project/screen/Login/login.dart';
import 'package:mini_project/screen/Profil/profil.dart';
import 'package:mini_project/screen/Register/Register.dart';
import 'package:mini_project/screen/Riwayat/riwayat.dart';
import 'package:mini_project/screen/components/transition_custom.dart';
import 'package:mini_project/screen/info_imunisasi/info_page.dart';
import 'package:mini_project/state/bayi_state.dart';
import 'package:mini_project/state/imunisasi_state.dart';
import 'package:mini_project/state/riwayat_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BayiState(),
        ),
        ChangeNotifierProvider(
          create: (_) => RiwayatState(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImunisasiState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == "/login") {
            return CustomTransition(child: const LoginPage());
          } else if (settings.name == "/register") {
            return CustomTransition(child: const RegisterPage());
          } else if (settings.name == "/home") {
            return CustomTransition(child: const HomePage());
          } else if (settings.name == "/info") {
            return CustomTransition(child: const InfoPage());
          } else if (settings.name == "/profil") {
            return CustomTransition(child: const ProfilPage());
          } else if (settings.name == "/bayi") {
            return CustomTransition(child: const BayiPage());
          } else if (settings.name == "/riwayat") {
            return CustomTransition(child: const RiwayatPage());
          }
        },
        home: const LoginPage(),
      ),
    );
  }
}
