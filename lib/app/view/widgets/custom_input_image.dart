import 'package:flutter/material.dart';

class CustomInputImage extends StatefulWidget {
  const CustomInputImage({ Key? key }) : super(key: key);

  @override
  State<CustomInputImage> createState() => _CustomInputImageState();
}

class _CustomInputImageState extends State<CustomInputImage> {
  String? pathImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pathImage != null ? AssetImage(pathImage!) : null,
          child: pathImage != null 
          ? null 
          : InkWell(
            child: const Icon(Icons.add_a_photo),
            onTap: () {},
          ),
        )
      ],
    );
  }
}