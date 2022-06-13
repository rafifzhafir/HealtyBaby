import 'package:flutter/material.dart';
import 'package:mini_project/screen/components/com_helper.dart';
import 'package:mini_project/screen/components/text_field_container.dart';
import 'package:mini_project/screen/constants/color.dart';
import 'package:intl/intl.dart';

class RoundedInputDate extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  const RoundedInputDate({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedInputDate> createState() => _RoundedInputDateState();
}

class _RoundedInputDateState extends State<RoundedInputDate> {
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.controller,
        cursorColor: kPrimaryColor,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Tolong Input ${widget.hintText}';
          }
          if (widget.hintText == "Email" && !validateEmail(value)) {
            return 'Tolong Input Email yang Benar';
          }
          return null;
        },
        onTap: () async {
          final selectDate = await showDatePicker(
            context: context,
            initialDate: currentDate,
            firstDate: DateTime(2010),
            lastDate: currentDate,
          );
          setState(() {
            if (selectDate != null) {
              _dueDate = selectDate;
              widget.controller
                ..text = DateFormat('dd/MM/yyyy').format(_dueDate)
                ..selection = TextSelection.fromPosition(
                  TextPosition(
                    offset: widget.controller.text.length,
                    affinity: TextAffinity.upstream,
                  ),
                );
            }
          });
        },
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
