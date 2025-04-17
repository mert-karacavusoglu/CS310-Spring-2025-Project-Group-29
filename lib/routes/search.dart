import 'package:flutter/material.dart';
import 'package:shopping_app/util/colors.dart';
import 'package:shopping_app/util/pads.dart';

class SearchResult {
  String name;
  int price;
  String imagePath;

  SearchResult(this.name, this.price, this.imagePath);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  bool searched = false;
  List<SearchResult> results = [
    SearchResult('Placeholder 1', 10, 'assets/images/productplaceholder.png'),
    SearchResult('Placeholder 2', 20, 'assets/images/productplaceholder.png'),
    SearchResult('Placeholder 3', 30, 'assets/images/productplaceholder.png'),
    SearchResult('Placeholder 4', 40, 'assets/images/productplaceholder.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); //Go Back to previous screen
          }
        ),
        backgroundColor: appcolor.backgroundColor,
        title: Text('Search',
        style: TextStyle(fontSize: 24,
        fontWeight: FontWeight.bold, color: appcolor.primary),),
        centerTitle: true,
      ),
      body: Column(children: [Padding(
        padding: apppad.regularPadding,
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const WidgetStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              trailing: <Widget> [IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  //Implement search functionality here
                  setState(() {searched = true;});
                },
              )]
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            List<String> suggestionPlaceholders = ['Water', 'Soap', 'Bread', 'Chocolate', 'Milk'];
            return List<ListTile>.generate(5, (int index) {
              return ListTile(
                title: Text(suggestionPlaceholders[index]),
                onTap: () {
                  setState((){
                    controller.closeView(suggestionPlaceholders[index]);
                  });
                },
              );
            });
          },
        )
      ),
      if(searched) SingleChildScrollView(
        child: Column(
          children: results.map((result) => Card(
            child:ListTile(
              leading: Image.asset(result.imagePath, width:50, height:50),
              title: Text(result.name),
              subtitle: Text('Price: ${result.price}'),
              trailing: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  //Add to cart logic
                }
              )
            )
          )).toList(),
        )
      ),
      ])
     
    );
  }
}
