class userModel {
  String address;
  String number;
  userModel({this.address = " ", this.number = " "});
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'number': number,
      // Add other fields here
    };
  }
  factory userModel.fromMap(Map<String, dynamic> data) {
    return userModel(
      address: data['address'] as String? ?? '',
      number: data['number'] as String? ?? '',
    );
  }
}