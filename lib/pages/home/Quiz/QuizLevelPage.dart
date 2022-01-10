import 'package:flutter/material.dart';
import 'package:quiz_app/backend/QuizData.dart';
import 'package:quiz_app/pages/home/Quiz/AttemptQuizPage.dart';

class QuizLevelPage extends StatefulWidget {
  static const routeName = "/home/quiz/level";
  const QuizLevelPage({Key? key}) : super(key: key);

  @override
  _QuizLevelPageState createState() => _QuizLevelPageState();
}

class _QuizLevelPageState extends State<QuizLevelPage> {
  List levels = ['Easy', 'Medium', 'Hard'];

  final List<Color> colors = [
    Colors.green.shade600,
    Colors.red.shade600,
    Colors.black87,
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: Text('Levels - ${args['subject']}')),
      body: FutureBuilder<Map<String, dynamic>>(
          future: QuizData().fetchData(endPoint: args['subject']),
          builder: (ctx, data) {
            if (!data.hasData) {
              return const Center(
                child: Text(
                  "Preparing...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              );
            }

            if (data.data!['responseCode'] == 400) {
              const Center(
                child: Text(
                  "Data not found",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (ctx, i) => Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                height: 100,
                child: Card(
                  color: colors[i],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AttemptQuizPage.routeName, arguments: {
                          "level": levels[i],
                          "subject": args['subject'],
                          "data": data.data!['data'],
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          //
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${levels[i]}',
                              style: TextStyle(
                                color: Colors.grey.shade50,
                                fontSize: 18,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
              ),
              itemCount: levels.length,
            );
          }),
    );
  }
}
