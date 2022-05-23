import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomInputImage extends StatefulWidget {
  const CustomInputImage({ Key? key }) : super(key: key);

  @override
  State<CustomInputImage> createState() => _CustomInputImageState();
}

class _CustomInputImageState extends State<CustomInputImage> {
  String? _pathImage;
  XFile? _imageFile;
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: _imageFile == null 
              ? null
              : Image.file(File(_imageFile!.path)).image,
          child: _imageFile == null
              ? const Icon(
                  Icons.person,
                  size: 60,
                )
              : null,
        ),
        Positioned(
          top: 50,
          left: 50,
          child: InkWell(
            child: Icon(
              Icons.add_a_photo, 
              size: 32, 
              color: Theme.of(context).backgroundColor, 
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                ),
              ],
              ),
            onTap: () {
              showModalBottomSheet(context: context, builder: (context) => _buildBottomSheet());
            },
          ),
        )
      ],
    );
  }

  _buildBottomSheet() {
    
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const Text(
            'Carregar imagem',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
              Expanded(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.photo),
                      SizedBox(width: 8),
                      Text('Galeria'),
                    ],
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt),
                      SizedBox(width: 8),
                      Text('Câmera'),
                    ],
                  ),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
              ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }
}