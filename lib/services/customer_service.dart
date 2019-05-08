import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../models/customer.dart';

mixin CustomerService on Model {
  List<Customer> _customerList = [];
  List<Customer> get customerList => _customerList;

  bool _isLoadingCustomer = false;
  bool get isLoadingCustomer => _isLoadingCustomer;

  Future<List<Customer>> fetchAvailableCustomer(String customerId) async {
    _isLoadingCustomer = true;
    notifyListeners();

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    await ref
        .child("users")
        .orderByKey()
        .equalTo(customerId)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      print(values);

      final List<Customer> _fetchedCustomer = [];

      if (values != null) {
        values.forEach((key, data) {
          print(key);
          print(data);
          var _customer = new Customer(
              id: key,
              firstName: data['firstName'],
              lastName: data['lastName'],
              customerNumber: data['customerNumber'],
              mpoints: data['mpoints'],
              mpointsReceived: data['mpointsReceived']);
          _fetchedCustomer.add(_customer);
        });
      }

      _customerList = _fetchedCustomer;

      print(_customerList.length.toString());

      _isLoadingCustomer = false;
      notifyListeners();
    });
    return _customerList;
  }

  Future<List<Customer>> fetchAvailableCustomerByNumber(
      String customerNumber) async {
    _isLoadingCustomer = true;
    notifyListeners();

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    await ref
        .child("users")
        .orderByChild('customerNumber')
        .equalTo(customerNumber)
        .once()
        .then((DataSnapshot snap) {
      Map<dynamic, dynamic> values = snap.value;
      print(values);

      final List<Customer> _fetchedCustomer = [];

      if (values != null) {
        values.forEach((key, data) {
          print(key);
          print(data);
          var _employee = new Customer(
              id: key,
              firstName: data['firstName'],
              lastName: data['lastName'],
              customerNumber: data['customerNumber'],
              mpoints: data['mpoints'],
              mpointsReceived: data['mpointsReceived']);
          _fetchedCustomer.add(_employee);
        });
      }

      _customerList = _fetchedCustomer;

      print(_customerList.length.toString());

      _isLoadingCustomer = false;
      notifyListeners();
    });
    return _customerList;
  }

  void clearEmployeeList() {
    _customerList.clear();
    notifyListeners();
  }
}
