import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'checkDifficulty.dart';
import 'text_button.dart';

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
  String check = "";
  int correct = 0;
  double score = 0;
  double mscore = 0;

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

  Widget CheckOptions(List data) {
    if (data.length > 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textButton(
              data: _items[num]["incorrect_answers"][1],
              onPressed: () {
                setState(() {
                  check = "Sorry";
                });
              }),
          textButton(
              data: _items[num]["incorrect_answers"][2],
              onPressed: () {
                setState(() {
                  check = "Sorry";
                });
              }),
        ],
      );
    }
    return Row();
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
                  check = "";
                  score = correct / question;
                  mscore = (correct + (total - question)) / total;
                });
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Score: $score%"),
            Text("Max Score: $mscore%"),
          ],
        ),
        Center(
          child: Stack(
            children: <Widget>[
              LinearProgressIndicator(
                value: (correct + (total - question)) / total,
                backgroundColor: Colors.white.withOpacity(0.0),
                color: Colors.black12,
                minHeight: 20,
              ), //Container
              LinearProgressIndicator(
                value: correct / question,
                backgroundColor: Colors.white.withOpacity(0.0),
                color: Colors.black54,
                minHeight: 20,
              ), //Container
              LinearProgressIndicator(
                value: correct / total,
                backgroundColor: Colors.white.withOpacity(0.0),
                color: Colors.black,
                minHeight: 20,
              ), //Container
            ], //<Widget>[]
          ), //Stack
        )
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
            textButton(
                data: _items[num]["correct_answer"],
                onPressed: () {
                  setState(() {
                    check = "Correct";

                    correct++;
                  });
                }),
            textButton(
                data: _items[num]["incorrect_answers"][0],
                onPressed: () {
                  setState(() {
                    check = "Sorry";
                  });
                }),
          ],
        ),
        CheckOptions(_items[num]["incorrect_answers"]),
        Text(
          check,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
