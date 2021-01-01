import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/auth/get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp/home/home_screen.dart';
import 'package:whatsapp/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (ctx, snapshot) {
        return MaterialApp(
          title: 'Whatsapp',
          home: snapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, authSnap) {
                    if (authSnap.connectionState == ConnectionState.waiting) {
                      return SplashScreen();
                    }
                    if (authSnap.hasData) {
                      return HomeScreen();
                    }
                    return GetStarted();
                  },
                ),
        );
      },
    );
  }
}
