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
    );
  }
}
