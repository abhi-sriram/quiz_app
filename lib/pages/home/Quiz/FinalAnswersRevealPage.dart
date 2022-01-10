import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/JsonQuestionParser.dart';

class FinalAnswersRevelaPage extends StatefulWidget {
  static const routeName = "/home/quiz/answers";

  const FinalAnswersRevelaPage({Key? key}) : super(key: key);

  @override
  _FinalAnswersRevelaPageState createState() => _FinalAnswersRevelaPageState();
}

class _FinalAnswersRevelaPageState extends State<FinalAnswersRevelaPage> {
  late List<dynamic> answers;
  late JsonQuestionParser jsonQuestionParser;
  int total = 0, answerd = 0, correct = 0;

  findInsights() {
    print(answers);
    total = jsonQuestionParser.questions.length;
    for (var i = 0; i < answers.length; i++) {
      if (answers[i] is List) {
        if (answers[i].any((e) => e != -1234567890123411123)) {
          answerd++;
          List l = answers[i];
          l.removeWhere((element) => element == -1234567890123411123);
          if (listEquals(l, jsonQuestionParser.questions[i].correctIndex)) {
            correct++;
          }
        }
      } else {
        if (answers[i] != -1234567890123411123) {
          answerd++;
          if (answers[i] == jsonQuestionParser.questions[i].correctIndex[0]) {
            correct++;
          }
        }
      }
    }
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    final modalRoute =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    answers = modalRoute['answers'];
    jsonQuestionParser = modalRoute['data'];
    if (i == 0) {
      findInsights();
      setState(() {
        i++;
      });
    }
    print(jsonQuestionParser.questions[0].question);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review answers',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (_, index) {
            if (index == 0) {
              return Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25),
                child: const Text(
                  '''Thank you for taking the test. Check out your dashboard for your score and live leaderboard ranking to know where you stand. Come back soon for another mock test.\n\nHappy Learning:)''',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 10,
                    color: Colors.blueGrey,
                    letterSpacing: 0.8,
                  ),
                  softWrap: true,
                ),
              );
            }
            return questionAnswerWidget(
              question: jsonQuestionParser.questions[index - 1],
              answer: answers[index - 1],
              qNumber: index,
            );
          },
          separatorBuilder: (_, ind) {
            return Divider(
              color: Colors.blueGrey[100],
            );
          },
          itemCount: jsonQuestionParser.questions.length + 1),
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total : $total',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'Answerd : $answerd',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'Correct : $correct',
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Finish review',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget questionAnswerWidget({
  required Question question,
  required dynamic answer,
  required int qNumber,
}) {
  print('hello');
  print(answer);
  return Container(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $qNumber',
              style: const TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Multiple choice',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  '1 Pts',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          question.question,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        ...List.generate(question.answers.length, (index) {
          return Column(
            children: [
              Text(
                '${index + 1}) ${question.answers[index]}',
                style: TextStyle(
                  color: question.correctIndex.contains(index)
                      ? Colors.green
                      : Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          );
        }),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Your Answer',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        question.type == 0
            ? //multiple ch
            multiple(question: question, answer: answer)
            : multipleTwo(answer: answer, question: question)
        // question.type == 1
        //     ? //mul with more than one
        //     multipleTwo(answer: answer, question: question)
        // : question.type == 2
        //     ? //true orfalse
        //     multiple(question: question, answer: answer)
        //     : fillInblanks(
        //         answer: answer, question: question) // fill in blanks
      ],
    ),
  );
}

Widget multiple({required Question question, required dynamic answer}) {
  // print(question.answers[answer]);
  if (answer == -1234567890123411123) {
    return const Text(
      'Unanswered',
      style: TextStyle(
        color: Colors.deepOrange,
      ),
    );
  }

  return Text(
    question.answers[answer],
    style: TextStyle(
      color: answer == question.correctIndex[0] ? Colors.green : Colors.red,
    ),
  );
}

Widget multipleTwo({required Question question, required List answer}) {
  if (answer.any((element) => element != -1234567890123411123)) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ...List.generate(answer.length, (i) {
        if (answer[i] != -1234567890123411123) {
          return Text(
            question.answers[answer[i]],
            style: TextStyle(
              color: question.correctIndex.contains(answer[i])
                  ? Colors.green
                  : Colors.red,
            ),
          );
        }
        return Container();
      }),
      const SizedBox(
        height: 5,
      ),
      const Text(
        'All options must be same',
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 10,
        ),
      )
    ]);
  }
  return const Text(
    'Unanswered',
    style: TextStyle(
      color: Colors.deepOrange,
    ),
  );
}


