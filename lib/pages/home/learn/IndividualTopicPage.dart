import 'package:flutter/material.dart';
import 'package:quiz_app/backend/FetchSubjects.dart';

class IndividualTopicPage extends StatefulWidget {
  static const routeName = "/home/homepage/individualtopicpage";
  const IndividualTopicPage({Key? key}) : super(key: key);

  @override
  _IndividualTopicPageState createState() => _IndividualTopicPageState();
}

class _IndividualTopicPageState extends State<IndividualTopicPage> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('${args['topicName']}'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: FetchSubjects()
            .fetchData(endPoint: args['topicName'].toString().trim()),
        builder: (ctx, data) {
          print(data.data);
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
            return const Center(
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
            padding: const EdgeInsets.all(20),
            itemCount: data.data!['data']['content'].length,
            itemBuilder: (ctx, i) {
              return Text(
                '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t${data.data!['data']['content'][i]}\n',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
