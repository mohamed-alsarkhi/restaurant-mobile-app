import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String name;
  const MyTextFormField({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "$name",
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 1
      ),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      ),
      validator: (value){
        if (value == null || value.isEmpty) {
          return "Please Enter your $name";
        }
        return null;
      },
    );
  }
}
