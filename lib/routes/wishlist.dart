import 'package:flutter/material.dart';
import 'package:shopping_app/util/colors.dart';
import 'package:shopping_app/util/pads.dart';
class WishlistItem {
  String title;
  String subtitle;
  String image;
  bool isOnline;
  WishlistItem(this.title, this.subtitle, this.image, {this.isOnline = true});
}
class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  void deleteItem (WishlistItem item) {
    setState(() {
      items.remove(item);
    });
  }

  List<WishlistItem> items = [
    WishlistItem('Item 1','price','https://i.imgur.com/sUFH1Aq.png'),
    WishlistItem('Item 2','price','assets/images/productplaceholder.png', isOnline: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WISHLIST',
          style: TextStyle(
            color: appcolor.primary,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: appcolor.backgroundColor,
      ),
      body: Padding(
        padding: apppad.extraPadding,
        child: SingleChildScrollView(
            child: Column(
              children: items.map((item) => Card(
                child: ListTile(
                  leading: item.isOnline ? Image.network(item.image, width: 50, height: 50) : Image.asset(item.image, width: 50, height: 50),
                  title: Text(item.title),
                  subtitle: Text(item.subtitle),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {items.remove(item);});
                        },
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: appcolor.backgroundColor,
                        ),
                        onPressed: () {},
                        child: Icon(
                            Icons.shopping_cart,
                            color: appcolor.primary
                        ),
                      )
                    ],
                  ),
                ),
              )).toList(),
            )
        ),
      ),
    );
  }
}