import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String label;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  const TextFieldComponent(
      {super.key, required this.label, this.suffixIcon, this.controller});

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.white, // Same blue color on focus
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors
                  .white, // Consistent blue color when enabled but not focused
              width: 1.0,
            ),
          ),
          hintText: widget.label,
          hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w400),
          suffixIcon: widget.suffixIcon),
    );
  }
}
