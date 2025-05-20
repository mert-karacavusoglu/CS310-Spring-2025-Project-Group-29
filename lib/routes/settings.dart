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
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  void saveChangesAndPop() async {
    final user = _auth.currentUser;
    if (user == null) {
      Navigator.pop(context);
      return;
    }
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

  void uploadordeleteProduct() async {
    final title = titleController.text.trim();
    final priceText = priceController.text.trim();
    final imageUrl = imageController.text.trim();

    if (title.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product Name is required.')),
      );
      return;
    }
    if (priceText.isNotEmpty && imageUrl.isNotEmpty && title.isNotEmpty) {
      double? price;
      try {
        price = double.parse(priceText);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invalid price format. Please enter a number.')),
        );
        return;
      }

      final productData = {
        'title': title,
        'price': price,
        'image': imageUrl,
      };
      try {
        await productsCollection.add(productData);
        print('Product "$title" uploaded successfully.');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product "$title" uploaded successfully!')),
          );
        }
        titleController.clear();
        priceController.clear();
        imageController.clear();
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload product "$title".')),
          );
        }
      }
    } else if (priceText.isEmpty && imageUrl.isEmpty) {
        try{
          final querySnapshot = await productsCollection.where('title', isEqualTo: title).get();
          if (querySnapshot.docs.isEmpty) {
            if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No product found with title "$title".')),
            );
            }
          } else {
            WriteBatch batch = _firestore.batch();
            for (var doc in querySnapshot.docs) {
              batch.delete(doc.reference);
            }
            await batch.commit();
            if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${querySnapshot.docs.length} product(s) with title "$title" deleted.')),
            );
            }
          }
        titleController.clear();
        priceController.clear(); // Ensure other fields are also clear
        imageController.clear(); // Ensure other fields are also clear

      } catch (error) {
        print('Error deleting product(s): $error');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete product(s) with title "$title".')),
          );
        }
      }
    }
  }

  @override
  // this is for memory leaks dont mind it
  void dispose() {
    addressController.dispose();
    contactController.dispose();
    titleController.dispose();
    priceController.dispose();
    imageController.dispose();
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
            const SizedBox(height: 70),
            Text("SELLER MODE"),
            const SizedBox(height: 12),
            Text("enter product name only to delete, enter full unique product with price image link and title to upload a product"),
            const SizedBox(height: 12),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Product Name'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Product Image URL'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: uploadordeleteProduct, child: const Text("Upload/Delete Product"))
          ],
        ),
      ),
    );
  }
}
