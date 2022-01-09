import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home/ProfilePage.dart';

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
                    print('Tapped');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      //
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Learn',
                        style: TextStyle(
                          color: Colors.grey.shade50,
                          fontSize: 20,
                        ),
                      ),
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
                    child: Center(
                      child: Text(
                        'Knowledge Test',
                        style: TextStyle(
                          color: Colors.grey.shade50,
                          fontSize: 20,
                        ),
                      ),
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
