import 'package:flutter/material.dart';

import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class CustomHeaderBoard extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final void Function()? onTap;
  final void Function(String value) onChanged;
  const CustomHeaderBoard({
    Key? key, 
    required this.title, 
    required this.onChanged, 
    required this.hint, 
    required this.controller, 
    required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22
                  ),
                ),
              ),
            ],
          ),
          CustomTextField(
            controller: controller,
            hint: hint,
            onChanged: onChanged,
            suffix: CustomIconButton(
              radius: 32,
              iconData: Icons.add,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}