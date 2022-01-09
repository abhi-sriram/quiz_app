import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home/learn/IndividualTopicPage.dart';

class TopicsPage extends StatefulWidget {
  static const routeName = "/home/homepage/topicspage";
  // final List<String> topics;
  // final String subjectName;
  const TopicsPage({Key? key}) : super(key: key);

  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print(args['subjectName']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${args['subjectName']}'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          height: 100,
          child: Card(
            color: args['color'],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(IndividualTopicPage.routeName,
                      arguments: {"topicName": args['topics'][i]});
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
                        '${args['topics'][i]}',
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
        itemCount: args['topics'].length,
      ),
    );
  }
}
