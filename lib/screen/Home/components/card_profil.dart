import 'package:flutter/material.dart';
import 'package:mini_project/screen/constants/color.dart';

class CardProfile extends StatelessWidget {
  final String name;
  const CardProfile({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.person_pin,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Hai, ",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/profil");
              },
              child: const Text(
                "Profilmu",
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
