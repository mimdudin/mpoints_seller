import './employee.dart';
import './transaction.dart';

class User {
  String uid, name, pin, email;
  List<Employee> employeeList;
  List<Transaction> statementList;

  User(
      {this.uid,
      this.name,
      this.pin,
      this.email,
      this.employeeList,
      this.statementList});
}
