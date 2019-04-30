class Transaction {
  int id;
  String transactionId, customerName;
  List<Product> productList;

  Transaction(
      {this.id, this.transactionId, this.customerName, this.productList});

  factory Transaction.fromJson(
      String transactionId, Map<String, dynamic> json) {
    List<Product> listOfProduct = [];
    if (json['products'] as List != null) {
      json['products'].forEach((content) {
        Product stuff = Product.fromJson(Map<String, dynamic>.from(content));
        print(content['id']);
        listOfProduct.add(stuff);
      });
    } else {
      listOfProduct = null;
    }

    return Transaction(
        transactionId: transactionId,
        id: json['id'],
        customerName: json['customerName'],
        productList: listOfProduct);
  }
}

class Product {
  String productName;
  int id, mpoints;

  Product({
    this.productName,
    this.id,
    this.mpoints,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['productName'],
      id: json['id'],
      mpoints: json['mpoints'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id != null ? id : 0,
        'productName': productName != null ? productName : '',
        'mpoints': mpoints != null ? mpoints : 0,
      };
}
