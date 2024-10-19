
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  String title;
  bool autofocus;
  MyTextFormField({super.key, this.controller, this.validator, this.title = '', this.autofocus=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != '')
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: MyText(
              text: title,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          autofocus: autofocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              errorStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.red[400]),
              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              fillColor: Colors.grey[200],
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none)),
        ),
      ],
    );
  }
}
