import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_database/firebase_database.dart';
import '../utils/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../models/transaction.dart';
import './user_service.dart';

mixin TransactionService on Model, UserService {
  List<Product> _transactionList = [];
  List<Product> get transactionList => _transactionList;

  bool _isLoadingTransaction = false;
  bool get isLoadingTransaction => _isLoadingTransaction;

  void addProductToTransations(Product transaction) {
    return transactionList.add(transaction);
  }

  Future<List<Product>> fetchAvailableEligibleProduct(
      String barcode, int id, Function showInSnackBar) async {
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
          var _transaction = new Product(
              id: id,
              // customerName: customerName,
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

  Future<void> addStatementToTransactionList(
      {String uid, int id, String custName}) async {
    _isLoadingTransaction = true;
    notifyListeners();
    final Map<String, dynamic> _userData = {
      'id': id,
      'customerName': custName,
      'products': _transactionList.map((tf) => tf.toJson()).toList()
    };

    try {
      final http.Response response = await http.post(
          Constant.baseUrl +
              Constant.partnersParam +
              '/$uid' +
              Constant.statementParam +
              Constant.jsonExt,
          body: json.encode(_userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      fetchStatements(uid);

      // final Transaction newTransaction = Transaction(
      //     transactionId: responseData['name'],
      //     id: id,
      //     customerName: custName,
      //     productList: _transactionList);

      // statementLists.add(newTransaction);

      _isLoadingTransaction = false;
      notifyListeners();
    } catch (error) {
      _isLoadingTransaction = false;
      notifyListeners();
      throw Exception('failed to load data');
    }
  }

  Future<void> updateMPoints(double mpoints, String uid) async {
    _isLoadingTransaction = true;
    notifyListeners();

    final response = await http.put(
        Constant.baseUrl +
            Constant.userParam +
            '/$uid/mpoints' +
            Constant.jsonExt,
        body: json.encode(mpoints));
    print(json.decode(response.body));

    _isLoadingTransaction = false;
    notifyListeners();
  }

  void clearTransactionList() {
    _transactionList.clear();
    notifyListeners();
  }
}
