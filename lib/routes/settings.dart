import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/usermodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    try {
      final userDoc = await _firestore.collection('users').doc(user?.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        final userData = userModel.fromMap(userDoc.data()!);
        addressController.text = userData.address;
        contactController.text = userData.number;
      }
    } catch (error) {
      print('Error loading data from firestore: $error');
    }
  }

  void saveChangesAndPop() async {
    final user = _auth.currentUser;
    try {
      final userDoc = _firestore.collection('users').doc(user?.uid);
      final saveData = userModel(
        address: addressController.text,
        number: contactController.text,
      );
      final dataMap = saveData.toMap();
      await userDoc.set(dataMap, SetOptions(merge: true));
      Navigator.pop(context);
    } catch (error) {
      print('Error saving data from firestore: $error');
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
