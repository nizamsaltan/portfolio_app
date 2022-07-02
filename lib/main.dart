import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/home_page.dart';
import 'package:portfolio_app/pages/tteam_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.grey[900]),
      debugShowCheckedModeBanner: false,
      title: 'Nizam Saltan',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/tteam': (context) => const TTeamPage(),
      },
    );
  }
}
