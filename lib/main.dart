import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'checkDifficulty.dart';

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
  int question = 1;
  int total = 0;
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(response);
    total = data.length;
    //print(data);
    // print(total);
    setState(() {
      _items = data;
    });
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
        LinearProgressIndicator(
          value: question / total,
          backgroundColor: Colors.white,
          color: Colors.grey,
          minHeight: 10,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "Question No. $question of $total",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              _items[num]["category"],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [checkDifficulty(_items[num]["difficulty"])],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text(
              _items[num]["question"],
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(
            child: Buttons(),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: Text(
                "Next Question",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                setState(() {
                  question++;
                  num++;
                });
              },
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
                  fontSize: 15.0,
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
                  fontSize: 15.0,
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
                  fontSize: 15.0,
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
                  fontSize: 15.0,
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
