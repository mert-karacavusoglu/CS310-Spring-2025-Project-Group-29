class Product {
  final String title;
  final double price;
  final String image;

  Product({this.title = " ", this.price = 0.0, this.image = " "});

  Map<String, dynamic> toMapP() {
    return {
      'title': title,
      'price': price,
      'image': image,
    };
  }

  factory Product.fromMapP(Map<String, dynamic> data) {
    return Product(
      title: data['title'] ?? '',
      price: data['price'] ?? 0.0,
      image: data['image'] ?? '',
    );
  }

}
// this is complete