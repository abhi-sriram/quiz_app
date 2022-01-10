import 'dart:async';
import 'dart:convert' as json_parse;

import 'package:flutter/material.dart';
import 'package:quiz_app/backend/QuizData.dart';
import 'package:quiz_app/pages/home/Quiz/FinalAnswersRevealPage.dart';
import 'package:quiz_app/pages/home/Quiz/multiple_choice_question_widget.dart';
import 'package:quiz_app/pages/home/Quiz/multiple_choice_question_widget_two.dart';

import '../../../models/JsonQuestionParser.dart';

class AttemptQuizPage extends StatefulWidget {
  static const routeName = "/home/quiz/attempt";
  const AttemptQuizPage({Key? key}) : super(key: key);

  @override
  _AttemptQuizPageState createState() => _AttemptQuizPageState();
}

class _AttemptQuizPageState extends State<AttemptQuizPage>
    with TickerProviderStateMixin {
  bool _exit = false;

  late Timer _timer;

  int duration = (15 * 60);

  String seconds = '00', minutes = '00', hours = '00';

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (duration < 1) {
            timer.cancel();
            Navigator.popAndPushNamed(context, FinalAnswersRevelaPage.routeName,
                arguments: {
                  'answers': selectedItems,
                  'data': json,
                });
          } else {
            duration = duration - 1;
            if (duration > 60) {
              int min = (duration / 60).truncate();
              if (min > 60) {
                int hr = (min / 60).truncate();
                min = min - hr * 60;
                int sec = duration - (min * 60 + hr * 60 * 60);
                if (hr < 10) {
                  hours = '0$hr';
                } else {
                  hours = '$hr';
                }

                if (min < 10) {
                  minutes = '0$min';
                } else {
                  minutes = '$min';
                }

                if (sec < 10) {
                  seconds = '0$sec';
                } else {
                  seconds = '$sec';
                }
              } else {
                int sec = duration - (min * 60);
                if (min < 10) {
                  minutes = '0$min';
                } else {
                  minutes = '$min';
                }

                if (sec < 10) {
                  seconds = '0$sec';
                } else {
                  seconds = '$sec';
                }
                hours = '00';
              }
            } else {
              if (duration < 10) {
                seconds = '0$duration';
              } else {
                seconds = '$duration';
              }
              minutes = '00';
              hours = '00';
            }
          }
        },
      ),
    );
  }

  Future<dynamic> showBackExitDilog({bool fromBackButton = true}) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(fromBackButton ? 'Exit' : 'End the exam?'),
            content: SizedBox(
              height: 200,
              width: 300,
              child: Center(
                child: Text(fromBackButton
                    ? 'Do you want to exit from exam.\nYou can come back and attempt before time runs out.'
                    : 'Do you want to finish the exam and submit your answers.'),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size.fromWidth(100),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (fromBackButton) {
                    setState(() {
                      _exit = true;
                    });
                    Navigator.pop(context);
                  } else {
                    _timer.cancel();
                    // dispose();
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(
                        context, FinalAnswersRevelaPage.routeName,
                        arguments: {
                          'answers': selectedItems,
                          'data': json,
                        });
                  }
                },
                child: Text(
                  fromBackButton ? 'Exit' : 'End exam',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size.fromWidth(100),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
            ],
          );
        });
  }

  int totalLen = 0;
  int totalAnswerd = 0;
  late JsonQuestionParser json;
  List<dynamic> selectedItems = [];
  bool isLoading = true;

  late TabController _tabController;

  void setupQuestionsAndStartTimer(dynamic data) async {
    print("from here\n\n");
    print(data);
    json = JsonQuestionParser.fromJson(data);
    _tabController = TabController(length: json.questions.length, vsync: this);
    totalLen = json.questions.length;
    List.generate(totalLen, (index) {
      if (json.questions[index].type == 1) {
        final n = List.generate(
            json.questions[index].answers.length, (i) => -1234567890123411123);
        selectedItems.add(n);
      } else {
        selectedItems.add(-1234567890123411123);
      }
    });
    // setState(() {
    //   isLoading = false;
    // });
    startTimer();
  }

  @override
  void initState() {
    // setupQuestionsAndStartTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void noOfAnswerd() {
    int count = 0;

    for (var element in selectedItems) {
      if (element is List) {
        final b = element.any((e) => e != -1234567890123411123);
        if (b) {
          count++;
        }
      } else if (element is String) {
        count++;
      } else {
        if (element != -1234567890123411123) {
          count++;
        }
      }
    }
    setState(() {
      totalAnswerd = count;
    });
  }

  void selectRadioTile(int val, int index) {
    setState(() {
      selectedItems[index] = val;
    });
    noOfAnswerd();
  }

  void selectedCheckBoxes(int val, int index, int anotherIndex) {
    if (anotherIndex == -1) {
      setState(() {
        selectedItems[index][val] = val;
      });
    } else {
      setState(() {
        selectedItems[index][anotherIndex] = val;
      });
    }

    noOfAnswerd();
  }

  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (!isInitialized) {
      setupQuestionsAndStartTimer(args['data']);
      setState(() {
        isInitialized = true;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        await showBackExitDilog();
        return _exit;
      },
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Time left - $hours:$minutes:$seconds',
            style: TextStyle(
              color: duration > (5 * 60) ? Colors.white : Colors.red,
              fontSize: 16,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.green,
            labelStyle: const TextStyle(
              color: Colors.white,
            ),
            labelColor: Colors.white,
            controller: _tabController,
            tabs: List.generate(
                totalLen,
                (index) => Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Tab(
                          text: '${index + 1}',
                        ),
                        // if (selectedItems[index] != -1234567890123411123)
                        (selectedItems[index] is List)
                            ? (selectedItems[index]
                                    .any((e) => e != -1234567890123411123))
                                ? const Positioned(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container()
                            : (selectedItems[index] != -1234567890123411123)
                                ? const Positioned(
                                    child: Text(
                                      'A',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container(),
                      ],
                    )).toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: List.generate(totalLen, (index) {
            if (json.questions[index].type == 0) {
              return multipleChoiceQuestionWidget(
                question: json.questions[index],
                function: selectRadioTile,
                index: index,
                selectedVal: selectedItems[index],
              );
            } else {
              return multipleChoiceQuestionTwoWidget(
                question: json.questions[index],
                function: selectedCheckBoxes,
                index: index,
                selectedVal: selectedItems[index],
              );
            }
          }),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.blueGrey.shade100,
              ),
            ),
          ),
          padding: const EdgeInsets.only(top: 5),
          height: 90,
          child: Card(
            color: Colors.grey.shade900,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Questions left : ${totalLen - totalAnswerd}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Answerd : $totalAnswerd',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    showBackExitDilog(fromBackButton: false);
                  },
                  child: const Text('Submit & End-Exam'),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size.fromWidth(200),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return FutureBuilder<Map<String, dynamic>>(
    //     future: QuizData().fetchData(endPoint: args['subject']),
    //     builder: (ctx, data) {

    //       if (data.hasData) {
    //         setupQuestionsAndStartTimer(data: data.data!['data']);
    //       }
    //       return );
  }
}
