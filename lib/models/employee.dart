class Employee {
  String id, pin, firstName, lastName, title;
  int uniqueId;

  Employee({this.id, this.pin, this.firstName, this.lastName, this.title, this.uniqueId});

  factory Employee.fromJson(String employeeId, Map<String, dynamic> json) {
    return Employee(
      id: employeeId,
      pin: json['PIN'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      title: json['title'],
      uniqueId: json['uniqueId']
    );
  }
}
