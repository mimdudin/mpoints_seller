import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

// import './reward_list_service.dart';
import '../models/user.dart';
import '../utils/constant.dart';
import '../models/employee.dart';
import '../models/transaction.dart';

mixin UserService on Model {
  int _selEmployeeIndex;

  User _user = new User();
  User get user => _user;

  // String _status = "Claim & Redeem";
  // String get status => _status;

  List<Employee> _employeeList = [];
  List<Employee> get employeeList => _employeeList;

  List<Transaction> statementLists = [];
  List<Transaction> get statementList => statementLists;

  // List<Statement> get statementList {
  //   if (_status == 'Claim') {
  //     return List.from(_statementList
  //         .where((statement) => statement.claim != null)
  //         .toList());
  //   } else if (_status == 'Redeem') {
  //     return List.from(_statementList
  //         .where((statement) => statement.rewardName != null)
  //         .toList());
  //   } else if (_status == 'Claim & Redeem') {
  //     return List.from(_statementList);
  //   }
  //   return List.from(_statementList);
  // }

  bool _isLoadingUser = false;
  bool get isLoadingUser => _isLoadingUser;

  // int getStatementsCount() {
  //   return _statementList.length;
  // }

  // void addStatementToList(Statement statement) {
  //   return _statementList.add(statement);
  // }

  // void setStatus(String update) {
  //   _status = update;
  //   notifyListeners();
  // }

  Employee get getSelectedEmployee {
    if (_employeeList == null) {
      return null;
    }
    return _employeeList[_selEmployeeIndex];
  }

  void selectedEmployee(int index) {
    _selEmployeeIndex = index;
    notifyListeners();
  }

  Future<User> fetchUserById(String userId) async {
    _isLoadingUser = true;
    notifyListeners();

    final response = await http.get(Constant.baseUrl +
        Constant.partnersParam +
        '/$userId' +
        Constant.jsonExt);

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print(result);
      if (result != null) {
        loadData(userId);

        _user = User(
            uid: userId,
            name: result['name'],
            pin: result['PIN'],
            email: result['email'],
            employeeList: _employeeList,
            statementList: statementLists);
      }
      //  User.fromJson(result);

      _isLoadingUser = false;
      notifyListeners();
      return _user;
    } else {
      _isLoadingUser = false;
      notifyListeners();
      throw Exception('failed to load user');
    }
  }

  Future loadData(userId) async {
    await Future.wait([fetchEmployees(userId), fetchStatements(userId)]);
  }

  Future updateProrfile(
      String uid,
      String address,
      String email,
      String mailingAddress,
      String name,
      String partnerNumber,
      String phoneNumber,
      String registeredName) async {
    _isLoadingUser = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'address': address,
      'email': email.isEmpty ? _user?.email : email,
      'mailing_address': mailingAddress,
      'name': name,
      'PIN': '',
      'partner_number': partnerNumber,
      'phone_number': phoneNumber,
      'points_rate': 0,
      'registered_name': registeredName,
      'social_rate': 0,
    };

    String _uid = uid.isEmpty ? '/${_user.uid}' : '/$uid';

    final response = await http.put(
        Constant.baseUrl + Constant.partnersParam + _uid + Constant.jsonExt,
        body: json.encode(updateData));
    print(json.decode(response.body));

    _isLoadingUser = false;
    notifyListeners();
  }

  Future addEmployee(String pin, String firstName, String lastName,
      String title, int uniqueId) async {
    // final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    // print(timestamp.toString());

    _isLoadingUser = true;
    notifyListeners();

    final Map<String, dynamic> employeeData = {
      'PIN': pin,
      'first_name': firstName,
      'last_name': lastName,
      'title': title,
      'uniqueId': uniqueId,
    };

    try {
      final http.Response response = await http.post(
          Constant.baseUrl +
              Constant.partnersParam +
              '/${_user.uid}' +
              Constant.employeeParam +
              Constant.jsonExt,
          body: json.encode(employeeData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      final Employee newEmployee = Employee(
          id: responseData['name'],
          firstName: firstName,
          lastName: lastName,
          title: title,
          pin: pin,
          uniqueId: uniqueId);

      _employeeList.add(newEmployee);

      _isLoadingUser = false;
      notifyListeners();
    } catch (error) {
      _isLoadingUser = false;
      notifyListeners();
      throw Exception('failed to load data');
    }
  }

  // Future addClaimToPartner(
  //     double claim, int purchaseAmount, String user, String partnerId) async {
  //   final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
  //   print(timestamp.toString());

  //   _isLoadingUser = true;
  //   notifyListeners();

  //   final Map<String, dynamic> statementData = {
  //     'claim': claim,
  //     'contra': "Unknown",
  //     'timestamp': timestamp,
  //     'purchase_amount': purchaseAmount,
  //     'user': user,
  //   };

  //   try {
  //     final http.Response response = await http.post(
  //         Constant.baseUrl + '/partners/$partnerId/claims' + Constant.jsonExt,
  //         body: json.encode(statementData));

  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     print(responseData);

  //     // final Statement newStatement = Statement(
  //     //     id: responseData['name'],
  //     //     claim: claim,
  //     //     contra: "Unknown",
  //     //     timestamp: timestamp,
  //     //     partnerName: partnerName,
  //     //     purchaseAmount: purchaseAmount);

  //     // _statementList.add(newStatement);

  //     _isLoadingUser = false;
  //     notifyListeners();
  //   } catch (error) {
  //     _isLoadingUser = false;
  //     notifyListeners();
  //     throw Exception('failed to load data');
  //   }
  // }

  Future<List<Employee>> fetchEmployees(String uid) async {
    final List<Employee> _fetchedEmployee = [];

    // _isLoadingClaim = true;
    // notifyListeners();

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    await ref.child("partners/$uid/employees").once().then((DataSnapshot snap) {
      var values;
      if (snap.value != null) {
        values = new Map<String, dynamic>.from(snap.value);
        print(values);
      }

      if (values != null) {
        values.forEach((key, data) {
          print(key);
          print(data);
          var _statement =
              new Employee.fromJson(key, Map<String, dynamic>.from(data));
          _fetchedEmployee.add(_statement);
        });
      }

      _employeeList = _fetchedEmployee;
      notifyListeners();

      print(_employeeList.length.toString());

      // _isLoadingClaim = false;
    });
    return _employeeList;
  }

  Future<List<Transaction>> fetchStatements(String uid) async {
    final List<Transaction> _fetchedStatement = [];

    // _isLoadingClaim = true;
    // notifyListeners();

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    await ref
        .child("partners/$uid/statements")
        .once()
        .then((DataSnapshot snap) {
      var values;
      if (snap.value != null) {
        values = new Map<String, dynamic>.from(snap.value);
        print(values);
      }

      if (values != null) {
        values.forEach((key, data) {
          print(key);
          print(data);
          var _statement =
              new Transaction.fromJson(key, Map<String, dynamic>.from(data));
          _fetchedStatement.add(_statement);
        });
      }

      statementLists = _fetchedStatement;
      notifyListeners();

      print(statementLists.length.toString());

      // _isLoadingClaim = false;
    });
    return statementLists;
  }

  Future addClaimToStatement(
      double claim, int purchaseAmount, String userId) async {
    final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch;
    print(timestamp.toString());

    _isLoadingUser = true;
    notifyListeners();

    final Map<String, dynamic> statementData = {
      'claim': claim,
      'contra': "Unknown",
      'timestamp': timestamp,
      'partner_name': _user?.name,
      'purchase_amount': purchaseAmount
    };

    try {
      final http.Response response = await http.post(
          Constant.baseUrl +
              Constant.userParam +
              '/$userId' +
              Constant.statementParam +
              Constant.jsonExt,
          body: json.encode(statementData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      print(claim);

      _isLoadingUser = false;
      notifyListeners();
    } catch (error) {
      _isLoadingUser = false;
      notifyListeners();
      throw Exception('failed to load data');
    }
  }

  Future deleteEmployee() async {
    _isLoadingUser = true;
    final deletedEmployee = getSelectedEmployee?.id;
    _employeeList.removeAt(_selEmployeeIndex);
    _selEmployeeIndex = null;
    notifyListeners();

    try {
      // await wishListRef.child(getSelectedWishlist?.foodId).remove().then((_) {
      //   // ...
      //   print("deleted: true");
      //   print(getSelectedWishlist?.foodId);
      // });

      await http.delete(Constant.baseUrl +
          Constant.partnersParam +
          '/${_user?.uid}' +
          Constant.employeeParam +
          '/$deletedEmployee' +
          Constant.jsonExt);

      _isLoadingUser = false;
      notifyListeners();
    } catch (error) {
      _isLoadingUser = false;
      notifyListeners();
      throw Exception('failed to load data $error');
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  void clearEmployeeList() {
    _employeeList.clear();
    notifyListeners();
  }

  void clearStatementList() {
    statementLists.clear();
    notifyListeners();
  }
}
