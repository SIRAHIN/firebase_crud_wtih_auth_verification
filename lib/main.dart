import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseall_in_one/firebase_options.dart';
import 'package:firebaseall_in_one/pages/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const GetMaterialApp(
    home: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: FirebaseAuth.instance.currentUser != null ? HomePage() : LoginPage());
  }
}
