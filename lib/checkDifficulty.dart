import 'package:flutter/material.dart';

Widget checkDifficulty(String data) {
  Widget star = Row(
    children: [
      Icon(Icons.star, color: Colors.grey),
      Icon(Icons.star, color: Colors.grey),
      Icon(Icons.star, color: Colors.grey),
      Icon(Icons.star, color: Colors.grey),
      Icon(Icons.star, color: Colors.grey)
    ],
  );
  Icon(Icons.star, color: Colors.yellow);
  if (data == "easy") {
    star = Row(
      children: [
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey)
      ],
    );
  } else if (data == "medium") {
    star = Row(
      children: [
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey)
      ],
    );
  } else if (data == "hard") {
    star = Row(
      children: [
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.grey),
        Icon(Icons.star, color: Colors.grey)
      ],
    );
  }
  return star;
}
