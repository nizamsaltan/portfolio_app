import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/home_page.dart';
import 'package:portfolio_app/pages/tteam_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

FirebaseOptions get platformOptions {
  return const FirebaseOptions(
    apiKey: "AIzaSyDPZoBQMtPNwIRUDt6Z3R-xxfWNql1cO4E",
    authDomain: "nizam-saltan-8d17f.firebaseapp.com",
    projectId: "nizam-saltan-8d17f",
    storageBucket: "nizam-saltan-8d17f.appspot.com",
    messagingSenderId: "643540489940",
    appId: "1:643540489940:web:c17c762224e50c25478d41",
    measurementId: "G-7W1G15TR1S",
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: platformOptions);
  await FirebaseAnalytics.instance.logAppOpen();

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
