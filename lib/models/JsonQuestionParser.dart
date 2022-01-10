

class JsonQuestionParser {
    JsonQuestionParser({
        required this.questions,
    });

    List<Question> questions;

    factory JsonQuestionParser.fromJson(Map<String, dynamic> json) => JsonQuestionParser(
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}









class Question {
    Question({
       required this.question,
       required this.answers,
       required this.type,
       required this.correctIndex,
    });

    String question;
    List<String> answers;
    int type;
    List<int> correctIndex;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        type: json["type"],
        correctIndex: List<int>.from(json["correctIndex"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answers": List<dynamic>.from(answers.map((x) => x)),
        "type": type,
        "correctIndex": List<dynamic>.from(correctIndex.map((x) => x)),
    };
}
