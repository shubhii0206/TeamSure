import 'package:flutter/material.dart';

// InputFormFields

class InputFormDeco extends StatefulWidget {
  final String hintText;
  final String Function(String) validator;
  final TextEditingController controller;
  final TextAlign textAlign;
  final int maxLines;
  final TextInputType keyboardType;

  InputFormDeco({
    this.hintText,
    this.validator,
    this.controller,
    this.textAlign = TextAlign.left,
    this.maxLines,
    this.keyboardType,
  });
  @override
  _InputFormDecoState createState() => _InputFormDecoState();
}

class _InputFormDecoState extends State<InputFormDeco> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: widget.key,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      textAlign: widget.textAlign,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.grey[400]),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: Colors.grey[400]),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        hintText: widget.hintText,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
      ),
    );
  }
}
