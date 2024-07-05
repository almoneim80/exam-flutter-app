import 'package:flutter/material.dart';
import 'app_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AppBrain appBrain = AppBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("إختبار"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Exam(),
      ),
    ));
  }
}

class Exam extends StatefulWidget {
  const Exam({super.key});

  @override
  State<Exam> createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  List<Widget> answersWidget = [];
  int rightAnswers = 0;

  void checkAnswer(bool choise) {
    setState(() {
      bool correctAnswer = appBrain.getQuestionAnswer();
      if (choise == correctAnswer) {
        rightAnswers++;
        answersWidget.add(const Icon(
          Icons.thumb_up,
          color: Colors.green,
        ));
      } else {
        answersWidget.add(const Icon(
          Icons.thumb_down,
          color: Colors.red,
        ));
      }
      if (appBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "انتهى الاختبار",
          desc: "لقد أجبت عن $rightAnswers اسئلة بشكل صحيح",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "أبدأ من جديد",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();

        appBrain.reset();
        answersWidget = [];
        rightAnswers = 0;
      } else {
        appBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 5,
            child: Column(
              children: [
                Image.asset(appBrain.getQuestionImage()),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  appBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontFamily: "ElMessiri",
                  ),
                ),
              ],
            )),
        Row(
          children: answersWidget,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)))),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                "صح",
                style: TextStyle(
                    fontFamily: "ElMessiri",
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)))),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                "خطأ",
                style: TextStyle(
                    fontFamily: "ElMessiri",
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
