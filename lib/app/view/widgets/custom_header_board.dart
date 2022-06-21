import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'custom_icon_button.dart';
import 'custom_text_field.dart';

class CustomHeaderBoard extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final void Function()? onTap;
  final void Function()? onDelete;
  final void Function(bool)? onFocusChange;
  final void Function(String value) onChanged;
  const CustomHeaderBoard({
    Key? key, 
    required this.title, 
    required this.onChanged, 
    required this.hint, 
    required this.controller, 
    required this.onTap, 
    required this.onDelete, 
    this.onFocusChange,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  title,
                  maxLines: 1,
                  minFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                  ),
                ),
                CustomIconButton(
                  radius: 28,
                  iconData: Icons.delete, 
                  onTap: onDelete, 
                )
              ],
            ),
          ),
          CustomTextField(
            onFocusChange: onFocusChange,
            controller: controller,
            hint: hint,
            onChanged: onChanged,
            onSubmitted: onTap,
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