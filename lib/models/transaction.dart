class Transaction {
  int id, mpoints;
  String transactionId, productName, customerName;

  Transaction(
      {this.id,
      this.transactionId,
      this.mpoints,
      this.productName,
      this.customerName});

  factory Transaction.fromJson(
      String transactionId, Map<String, dynamic> json) {
    return Transaction(
        transactionId: transactionId,
        id: json['id'],
        mpoints: json['mpoints'],
        productName: json['productName'],
        customerName: json['customerName']);
  }
}
