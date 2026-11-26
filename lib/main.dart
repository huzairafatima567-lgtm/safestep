import 'package:flutter/material.dart';
import 'package:safestep/splashscreen.dart';

void main() {
  runApp(const SafeStep());
}

class SafeStep extends StatelessWidget {
  const SafeStep({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeStep',
      home: SplashScreen(),
    );
  }
}


