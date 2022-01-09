import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home/learn/TopicsPage.dart';

class SubjectsPage extends StatefulWidget {
  static const routeName = "/home/homepage/subjectpage";
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  final List subject = ["Science", "Social", "English"];
  final List<Color> colors = [
    Colors.red.shade500,
    Colors.orange.shade500,
    Colors.pink.shade600
  ];
  final List topics = [
    [
      'Astronomy',
      'Ecology',
      'Geography',
    ],
    [
      'Gender Inequality',
      'Childhood Obesity',
    ],
    ['Subjects & Verbs', 'Pronouns']
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
      ),
      body: ListView.builder(
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
                      .pushNamed(TopicsPage.routeName, arguments: {
                    "topics": topics[i],
                    "subjectName": subject[i],
                    "color": colors[i],
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
                        '${subject[i]}',
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
        itemCount: 3,
      ),
    );
  }
}
