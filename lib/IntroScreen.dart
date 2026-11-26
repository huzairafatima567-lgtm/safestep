import 'package:flutter/material.dart';
import 'package:safestep/TermsScreen.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 55),
              Image.asset(
                'assets/icons/logo2.png',
                height: 230,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 1),
              // Title Text
              const Text(
                'More Independence\nMore Confidence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF063465),
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 16),

              // Description Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'SafeStep helps you detect \n '
                      'obstacles,find your way and \n'
                      'keeps your loved ones informed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xFF063465),
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 120),

              Center(
              child: SizedBox(
                width: 280,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF063465),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}