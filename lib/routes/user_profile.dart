import 'package:flutter/material.dart';
import 'package:shopping_app/util/user_data.dart';
class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  void _updateControllers() {
    addressController.text = UserData.address;
    contactController.text = UserData.contactNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'USER PROFILE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings').then((_) {
                setState(() {
                  _updateControllers(); //
                });
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: addressController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contactController,
              enabled: false,
              decoration: const InputDecoration(labelText: 'Contact Number'),
            ),
          ],
        ),
      ),
    );
  }
}
