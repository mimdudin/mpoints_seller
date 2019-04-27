import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/transaction.dart';

mixin TransactionService on Model {
  List<Transaction> _transactionList = [];
  List<Transaction> get transactionList => _transactionList;

  bool _isLoadingTransaction = false;
  bool get isLoadingTransaction => _isLoadingTransaction;

  void addProductToTransations(Transaction transaction) {
    return transactionList.add(transaction);
  }

  Future<List<Transaction>> fetchAvailableEligibleProduct(String barcode,
      int id, String customerName, Function showInSnackBar) async {
    _isLoadingTransaction = true;
    notifyListeners();

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    await ref
        .child("eligible_products")
        .orderByChild('barcode')
        .equalTo(barcode)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      print(values);

      // final List<Transaction> _fetchedTransaction = [];

      if (values != null) {
        values.forEach((key, data) {
          print(key);
          print(data);
          var _transaction = new Transaction(
              id: id,
              customerName: customerName,
              mpoints: data['MPvalue'],
              productName: data['item_name']);
          // _fetchedTransaction.add(_transaction);
          addProductToTransations(_transaction);

          showInSnackBar('${data['item_name']} Added to Eligible Products.');
        });
      } else {
        showInSnackBar('Eligible product not found.');
      }

      print(_transactionList.length.toString());

      _isLoadingTransaction = false;
      notifyListeners();
    });
    return _transactionList;
  }

  void clearTransactionList() {
    _transactionList.clear();
    notifyListeners();
  }
}
