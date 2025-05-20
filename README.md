# shopping_app

Our project repository for CS310 term project. We're developing a mobile shopping app called QuickMart. The development platform is the Flutter API
and the Dart Programming Language.
void addtoCart() async {
final user = _auth.currentUser;
final temp1 = TextEditingController();
final temp2 = TextEditingController();
try {
final userDoc = await _firestore.collection('users').doc(user?.uid).get();
if (userDoc.exists && userDoc.data() != null) {
final userData = userModel.fromMap(userDoc.data()!);
temp1.text = userData.address;
temp2.text = userData.number;

      }
      final dataMap = saveData.toMap();
      await userDoc.set(dataMap, SetOptions(merge: true));
      Navigator.pop(context);
    } catch (error) {
      print('Error saving data from firestore: $error');
    }
}