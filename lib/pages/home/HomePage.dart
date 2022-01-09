import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home/ISRO/IsroHomepage.dart';
import 'package:quiz_app/pages/home/ProfilePage.dart';

import 'learn/SubjectsPage.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home/homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ProfilePage.routeName);
            },
            icon: const Icon(
              Icons.person_rounded,
              color: Colors.grey,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.green.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(SubjectsPage.routeName);
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
                          'Learn',
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
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.deepOrange.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {
                    print('Tapped');
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
                          'Knowledge Test',
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
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(5),
            width: double.infinity,
            height: 100,
            child: Card(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(IsroHomepage.routeName);
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
                          'ISRO Knowledge',
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
        ],
      ),
    );
  }
}
