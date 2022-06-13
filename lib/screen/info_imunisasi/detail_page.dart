import 'package:flutter/material.dart';
import 'package:mini_project/screen/components/app_bar_custom.dart';

class DetailPage extends StatelessWidget {
  final String title;
  final String desc;
  const DetailPage({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Detail Penjelasan",
        page: "/info",
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
