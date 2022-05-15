import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomHeaderBoard extends StatelessWidget {
  final String title;
  const CustomHeaderBoard({ Key? key, required this.title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22
                  ),
                ),
                // padding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
        CustomTextField(onChanged: (value) {})
      ],
    );
  }
}