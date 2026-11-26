import 'package:flutter/material.dart';
import 'package:safestep/CaregiverScreen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool isLocationSharing = true;
  String selectedDuration = 'Always on';
  int _currentIndex = 1;

  void _requestLocationPermission(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Allow Location Access',
            style: TextStyle(
              color: Color(0xFF1E549A),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'The SafeStep app needs your device\'s location access to share your live location',
          ),
          actions: [
            TextButton(
              child: const Text('Deny', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  isLocationSharing = false;
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002D5D)),
              child: const Text('Allow', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Duration Selection Bottom Sheet
  void _showDurationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Duration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002D5D),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('Always on'),
                onTap: () {
                  setState(() => selectedDuration = 'Always on');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('For 1 Hour'),
                onTap: () {
                  setState(() => selectedDuration = 'For 1 Hour');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Until turned off'),
                onTap: () {
                  setState(() => selectedDuration = 'Until turned off');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF063465)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Live Location',
          style: TextStyle(color: Color(0xFF063465), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Layout (Map & Bottom Container)
          Column(
            children: [
              // Map Section
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.blue[50],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map_outlined, size: 64, color: Colors.blue[300]),
                        const SizedBox(height: 8),
                        Text(
                          'Map View Placeholder',
                          style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 55, 20, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    border: Border(
                      top: BorderSide(
                        color: Colors.blue.shade300,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Location sharing',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF063465),
                            ),
                          ),
                          Switch(
                            value: isLocationSharing,
                            onChanged: (value) {
                              setState(() {
                                isLocationSharing = value;
                              });
                              if (value) {
                                _requestLocationPermission(context);
                              }
                            },
                            activeColor: Colors.green.shade600,
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      InkWell(
                        onTap: () => _showDurationBottomSheet(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF063465),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    selectedDuration,
                                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              const Icon(Icons.chevron_right, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                      const Divider(height: 24),
                      const Text(
                        'Caregiver No.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF063465),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '+92 3459149862',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CaregiverScreen(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.chevron_right, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.30,
            left: 50,
            right: 50,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.blue.shade300, width: 1),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2)
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_pin, color: Color(0xFF063465), size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('You are here', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(height: 2),
                      Text('Last updated: 2 min ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFF063465),
              width: 1,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.pop(context);
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF063465),
            unselectedItemColor: const Color(0xFF063465),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined),
                activeIcon: Icon(Icons.location_on),
                label: 'Location',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/icons/msglogo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                activeIcon: SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    'assets/icons/send.png',
                    fit: BoxFit.contain,
                    color: const Color(0xFF063465),
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
                label: 'Messages',
              ),
            ],
          ),
        ),
      ),
    );
  }
}