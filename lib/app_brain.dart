import "question.dart";

class AppBrain {
  int _questionNumber = 0;

  final List<Question> _questions = [
    Question("عدد الكواكب في المجموعة الشمسية هو ثمانية كواكب",
        "images/image-1.jpg", true),
    Question("القطط هي حيوانات لاحمة", "images/image-2.jpg", true),
    Question("الصين موجودة في قارة أفريقيا", "images/image-3.jpg", false),
    Question("الأرض مسطحة وليست كرويه", "images/image-4.jpg", false)
  ];

  String getQuestionText() {
    return _questions[_questionNumber].question;
  }

  String getQuestionImage() {
    return _questions[_questionNumber].image;
  }

  bool getQuestionAnswer() {
    return _questions[_questionNumber].answer;
  }

  int countQuestions() {
    return _questions.length;
  }

  void nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset()
  {
    _questionNumber = 0;
  }
}
