import 'package:flutter/material.dart';
import 'package:shopping_app/util/pads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_app/model/usermodel.dart';
import 'package:shopping_app/model/auth_provider.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      if(mounted) {
        Provider.of<AuthInfoProvider>(context, listen : false).setAuth(false);
        Navigator.pushReplacementNamed(context, '/home');  
      }
    } catch (error) {
      print('Error signing out: $error');
    }
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
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
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(context),
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
                  _loadUserData(); //
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
            Padding(
                padding: apppad.regularPadding,
                child: ElevatedButton(
                    onPressed: _signOut,
                    child: const Text('Sign Out')
                )
            ),
          ],
        ),
      ),
    );
  }
}
