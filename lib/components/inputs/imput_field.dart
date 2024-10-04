import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/style/constants.dart';
import 'package:tic_tac_toe/components/style/style.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.controller,
    this.node,
    super.key,
  });
  final TextEditingController controller;
  final FocusNode? node;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: node,
      textAlign: TextAlign.center,
      cursorColor: whiteColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: brownColor,

        // Border when TextFormField is not focused
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: borderColor, width: 1), // Border color and width
          borderRadius: BorderRadius.circular(22), // Border radius
        ),

        // Border when TextFormField is focused
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xFF782621),
              width: 1), // Border color and width when focused
          borderRadius: BorderRadius.circular(22), // Border radius when focused
        ),

        contentPadding: EdgeInsets.symmetric(
            vertical: 15 *
                grw(context)), // Adjust padding if needed to align text centrally
      ),
      style: h5Style,
    );
  }
}
