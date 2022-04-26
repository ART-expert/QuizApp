import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List _items = [];
  int num = 0;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    //print(data);
    setState(() {
      _items = data;
    });
  }

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

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _items[num]["category"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
                child: Row(
              children: [checkDifficulty(_items[num]["difficulty"])],
            )),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _items[num]["question"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Buttons(),
            ),
          ),
        ),
      ],
    );
  }

  Column Buttons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                _items[num]["correct_answer"],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                _items[num]["incorrect_answers"][0],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                _items[num]["incorrect_answers"][1],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                _items[num]["incorrect_answers"][2],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
