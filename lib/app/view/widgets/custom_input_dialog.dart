import 'package:flutter/material.dart';

class CustomInputDialog extends StatefulWidget {
  final String title;
  final String hint;
  final String buttonText;
  final String initialTextValue;
  final void Function(String) onSubmit;
  const CustomInputDialog({ 
    Key? key, 
    required this.title, 
    required this.hint, 
    this.initialTextValue = '', 
    required this.onSubmit, 
    required this.buttonText 
  }) : super(key: key);

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.initialTextValue;
    textEditingController.selection = TextSelection.fromPosition(TextPosition(offset: textEditingController.text.length));
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextFormField(
        autofocus: true,
        controller: textEditingController,
        decoration: InputDecoration(hintText: widget.hint),
        textInputAction: TextInputAction.done,
        onFieldSubmitted: (String value) {
          if (value.isNotEmpty) {
            widget.onSubmit(textEditingController.text);
            Navigator.of(context).pop();
          }
        }
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (textEditingController.text.isNotEmpty) {
              widget.onSubmit(textEditingController.text);
            }
            Navigator.pop(context);
          },
           child: Text(widget.buttonText)
          ),
      ],
    );
  }
}