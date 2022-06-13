import 'package:flutter/material.dart';

class GenderInput extends StatelessWidget {
  final String gender;
  final ValueChanged<String?> onChanged;
  const GenderInput({
    Key? key,
    required this.gender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Jenis Kelamin *",
            style: TextStyle(fontSize: 17),
          ),
          RadioListTile(
            value: "Pria",
            title: const Text("Pria"),
            groupValue: gender,
            onChanged: onChanged,
          ),
          RadioListTile(
            value: "Wanita",
            title: const Text("Wanita"),
            groupValue: gender,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// class GenderInput extends StatefulWidget {
//   final String gender;
//   final String onChanged;
//   const GenderInput({
//     Key? key,
//     required this.gender,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   State<GenderInput> createState() => _GenderInputState();
// }

// class _GenderInputState extends State<GenderInput> {
//   void _pilihGender(String value) {
//     setState(() {
//       _gender = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         const Text(
//           "Jenis Kelamin *",
//           style: TextStyle(fontSize: 17),
//         ),
//         RadioListTile(
//           value: "Pria",
//           title: const Text("Pria"),
//           groupValue: gender,
//           onChanged: (String? value) {
//             _pilihGender(value!);
//           },
//         ),
//         RadioListTile(
//           value: "Wanita",
//           title: const Text("Wanita"),
//           groupValue: gender,
//           onChanged: oncha
//         ),
//       ],
//     );
//   }
// }
