import 'package:flutter/material.dart';
import 'package:shopping_app/util/colors.dart';
import 'package:shopping_app/util/pads.dart';

class CartItem {
  String name;
  int price;
  int itemCount;
  String imageName;
  

  CartItem(this.name, this.price, this.itemCount, this.imageName);
}

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
  
}

class _CartState extends State<Cart> {

  List<CartItem> items = [ //Placeholder elements for UI demonstration purposes
    CartItem('Item 1', 10, 1, 'assets/images/productplaceholder.png'), //Placeholder Image from assets
    CartItem('Item 2', 20, 2, 'assets/images/productplaceholder.png'),
    CartItem('Item 3', 30, 3, 'assets/images/productplaceholder.png'),
    CartItem('Item 4', 40, 4, 'assets/images/productplaceholder.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        backgroundColor: appcolor.backgroundColor,
        title: Text('Cart',
        style: TextStyle(fontSize: 24,
        fontWeight: FontWeight.bold, color: appcolor.primary),),
        centerTitle: true,
        
      ),
      body: Padding(
        padding: apppad.regularPadding,
        child: SingleChildScrollView(
          child: Column(
            children: items.map((item) => Card(
              child: ListTile(
                leading: Image.asset(item.imageName, width:50, height:50),
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Price: ${item.price}'),
                    Text('Amount: ${item.itemCount}'), 
                    Text('Total: ${item.price * item.itemCount}')
                  ]
                  ),
                  trailing: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            item.itemCount--;
                            if(item.itemCount <= 0) {
                              items.remove(item);
                            }
                                      });
                          
                        }
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {item.itemCount++;});
                        }
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {items.remove(item);});
                        }
                      )
                    ],
                  ),
              )
            )).toList(),
          )
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Proceed to Checkout"),
        onPressed: () {} //Implement Logic on future phases
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



