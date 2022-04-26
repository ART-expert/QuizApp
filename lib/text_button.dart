import 'package:flutter/material.dart';

class textButton extends StatelessWidget {
  textButton({required this.data, required this.onPressed});
  final String data;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey,
      ),
      child: Text(
        data,
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
