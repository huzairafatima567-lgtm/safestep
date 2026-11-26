import 'package:flutter/material.dart';
import 'package:safestep/IntroScreen.dart';
import 'package:safestep/LoginScreen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF063465),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Introduction:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF063465),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Please read and accept the following terms before setting up the Smart Stick.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '1. Use of the App',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'This app is designed to support visually impaired users through smart stick connectivity, object detection, location sharing, and emergency alerts.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '2. Smart Stick Connection',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                    color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'The app requires Bluetooth access to communicate with the Smart Stick. Keep the stick connected and sufficiently charged for proper operation.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '3. AI Detection',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'AI-based object detection is provided as an assistance feature. It may not always detect or identify objects correctly. Users should not rely on it as the only source of safety.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '4. Location & Emergency Alerts',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color:Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Location information may be shared with registered caregivers when an emergency alert is triggered. Make sure caregiver information is correct and up to date.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '5. Caregiver Responsibility',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'The caregiver is responsible for setting up the app, adding emergency contacts, granting required permissions, and ensuring the Smart Stick is properly connected.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '6. Privacy',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Personal information, location data, and emergency information should be handled securely and used only for providing the app\'s safety features.',
                style: TextStyle(fontSize: 12, color:Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 12),
              const Text(
                '7. Limitation of Responsibility',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF063465)),
              ),
              const SizedBox(height: 4),
              const Text(
                'This system is an assistive technology and does not guarantee complete protection from accidents, obstacles, or emergencies.',
                style: TextStyle(fontSize: 12, color: Color(0xFF063465), height: 1.4),
              ),

              const SizedBox(height: 20),

              // Agreement Checkbox
              GestureDetector(
                onTap: () {
                  setState(() {
                    isAgreed = !isAgreed;
                  });
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: isAgreed,
                        activeColor: const Color(0xFF063465),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            isAgreed = value ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'I agree to the Terms & Conditions and Privacy Policy',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF063465),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Elevated Button
              Center(
              child: SizedBox(
                width: 280,
                height: 52,
                child: ElevatedButton(
                  onPressed: isAgreed
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF063465),
                    disabledBackgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.grey.shade600,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'AGREE',
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