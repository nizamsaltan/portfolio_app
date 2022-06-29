import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/home_page.dart';
import 'package:portfolio_app/pages/tteam_page.dart';

FirebaseOptions get platformOptions {
  return const FirebaseOptions(
      apiKey: "AIzaSyCH1JrZF-s9krFwM8OuAvbhqKrXNLIbuWI",
      authDomain: "nizam-saltan-6c585.firebaseapp.com",
      projectId: "nizam-saltan-6c585",
      storageBucket: "nizam-saltan-6c585.appspot.com",
      messagingSenderId: "162039161411",
      appId: "1:162039161411:web:ea0740771a6324e58e6af6",
      measurementId: "G-5QHHDN64F4");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: platformOptions);
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
      initialRoute: '/tteam',
      routes: {
        '/': (context) => const HomePage(),
        '/tteam': (context) => const TTeamPage(),
      },
    );
  }
}
