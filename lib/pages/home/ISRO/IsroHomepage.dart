import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home/ISRO/SpacecraftsPage.dart';

class IsroHomepage extends StatefulWidget {
  static const routeName = "/home/isroknowledge";
  const IsroHomepage({Key? key}) : super(key: key);

  @override
  _IsroHomepageState createState() => _IsroHomepageState();
}

class _IsroHomepageState extends State<IsroHomepage> {
  void navigatioHandler(int i) {
    switch (i) {
      case 0:
        Navigator.of(context).pushNamed(SpacecraftsPage.routeName);
        break;
      default:
    }
  }

  final List topics = [
    "Spacecrafts",
    "Launchers",
    "Customer Satellites",
    "Centers",
  ];
  final List uriEndpoints = [
    "spacecrafts",
    "launchers",
    "customer_satellites",
    "centers",
  ];

  final List<Color> colors = [
    Colors.red.shade500,
    Colors.orange.shade500,
    Colors.pink.shade600,
    Colors.green.shade600,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISRO'),
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
                onTap: () => navigatioHandler(i),
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
                        '${topics[i]}',
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
        itemCount: topics.length,
      ),
    );
  }
}
