import 'package:flutter/material.dart';
import 'package:shopping_app/util/user_data.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final addressController = TextEditingController(text: UserData.address);
  final contactController = TextEditingController(text: UserData.contactNumber);

  void saveChangesAndPop() {
    UserData.address = addressController.text;
    UserData.contactNumber = contactController.text;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: saveChangesAndPop,
        ),
        title: const Text('SETTINGS', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: const [
          Icon(Icons.settings),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contactController,
              decoration: const InputDecoration(labelText: 'Contact Number'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      ),
    );
  }
}
