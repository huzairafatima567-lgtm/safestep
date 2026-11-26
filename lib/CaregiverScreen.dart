import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:safestep/database/databasehelper.dart';
import 'package:safestep/models/caregivermodel.dart';

class CaregiverScreen extends StatefulWidget {
  const CaregiverScreen({super.key});

  @override
  State<CaregiverScreen> createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  int _currentIndex = 0;
  List<Caregiver> _caregivers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCaregivers();
  }

  Future<void> _loadCaregivers() async {
    setState(() => _isLoading = true);

    final existing = await DatabaseHelper.instance.getCaregivers();

    if (existing.isEmpty) {
      await DatabaseHelper.instance.insertCaregiver(
        const Caregiver(
          name: 'Caregiver 1',
          phoneNumber: '03459149862',
          isPrimary: true,
        ),
      );
      await DatabaseHelper.instance.insertCaregiver(
        const Caregiver(
          name: 'Caregiver 2',
          phoneNumber: '034211603278',
          isPrimary: false,
        ),
      );
    }

    final data = await DatabaseHelper.instance.getCaregivers();
    if (!mounted) return;

    setState(() {
      _caregivers = data;
      _isLoading = false;
    });
  }

  Future<void> _pickContact() async {
    final bool permissionGranted =
    await FlutterContacts.requestPermission(readonly: true);

    if (!permissionGranted) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contacts permission is denied!')),
      );
      return;
    }

    final Contact? contact = await FlutterContacts.openExternalPick();

    if (contact != null) {
      final fullContact = await FlutterContacts.getContact(contact.id);

      if (fullContact != null && fullContact.phones.isNotEmpty) {
        final String phoneNumber = fullContact.phones.first.number.trim();
        final String contactName = fullContact.displayName.trim().isNotEmpty
            ? fullContact.displayName.trim()
            : 'Caregiver';

        final newCaregiver = Caregiver(
          name: contactName,
          phoneNumber: phoneNumber,
          isPrimary: _caregivers.isEmpty,
        );

        await DatabaseHelper.instance.insertCaregiver(newCaregiver);
        await _loadCaregivers();
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selected contact has no phone number.')),
        );
      }
    }
  }

  Future<void> _removeContact(Caregiver caregiver) async {
    if (caregiver.id == null) return;
    await DatabaseHelper.instance.deleteCaregiver(caregiver.id!);
    await _loadCaregivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF063465)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Caregiver Number',
          style: TextStyle(
            color: Color(0xFF063465),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add your caregiver number here.',
                    style: TextStyle(
                      color: Color(0xFF063465),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_add, color: Color(0xFF063465), size: 28),
                    onPressed: _pickContact,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: CircularProgressIndicator(),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _caregivers.length,
                itemBuilder: (context, index) {
                  final caregiver = _caregivers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildNumberCard(
                      caregiver: caregiver,
                      onDelete: () => _removeContact(caregiver),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              const Text(
                '*Minimum two numbers are required.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildNumberCard({required Caregiver caregiver, required VoidCallback onDelete}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FC),
        border: Border.all(color: const Color(0xFFB0C4DE), width: 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.phone,
                color: Color(0xFF063465),
                size: 24,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caregiver.name,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    caregiver.phoneNumber,
                    style: const TextStyle(
                      color: Color(0xFF063465),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Color(0xFF063465),
              size: 24,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF063465),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
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

            if (index == 1) {
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
    );
  }
}