import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/backend/Authentication.dart';
import 'package:quiz_app/pages/auth/LoginPage.dart';
import 'package:quiz_app/pages/auth/RegisterPage.dart';
import 'package:quiz_app/pages/home/HomePage.dart';
import 'package:quiz_app/pages/home/ISRO/IsroHomepage.dart';
import 'package:quiz_app/pages/home/ProfilePage.dart';
import 'package:quiz_app/pages/home/learn/IndividualTopicPage.dart';

import 'pages/home/learn/SubjectsPage.dart';
import 'pages/home/learn/TopicsPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.grey.shade900,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
            elevation: 0.6,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterPage.routeName: (_) => const RegisterPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
        SubjectsPage.routeName: (_) => const SubjectsPage(),
        TopicsPage.routeName: (_) => const TopicsPage(),
        IndividualTopicPage.routeName: (_) => const IndividualTopicPage(),
        IsroHomepage.routeName: (_) => const IsroHomepage(),
      },
      home: FutureBuilder(
        future: Authentication().isUserActive(),
        builder: (ctx, isLoggedin) {
          if (isLoggedin.hasData && isLoggedin.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
