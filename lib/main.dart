import 'package:flutter/material.dart';
import 'package:my_app/App2/Screens/homeScreen.dart';
import 'package:provider/provider.dart';

import 'App2/providers/UserProvider.dart';
import 'home.dart';
import 'login.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: const MyApp(),
          )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


