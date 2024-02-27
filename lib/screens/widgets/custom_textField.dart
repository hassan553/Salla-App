import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final controller;
  final keyboard;
  final hint;
  final valid;
  final prefix;
  final obscure;

  const BuildTextField({
    Key? key,
    required this.controller,
    required this.keyboard,
    required this.hint,
    required this.valid,
    required this.prefix,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      validator: valid,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: prefix,
        hintStyle: const TextStyle(color: Colors.black),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              20,
            ),
            bottomRight: Radius.circular(
              20,
            ),
          ),
        ),
      ),
    );
  }
}



Widget buildListTitle(
  String title,
  IconData iconData,
  dynamic function,
) {
  return ListTile(
    onTap: function,
    title: Text(
      title,
      softWrap: true,
      style: const TextStyle(
        letterSpacing: 2,
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    leading: Icon(
      iconData,
      color: Colors.blue,
    ),
  );
}
