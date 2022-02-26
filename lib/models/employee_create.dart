import 'employee_model.dart';

class CreateEmployee {
  String status;
  String message;
  Employee data;

  CreateEmployee.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        message = json["message"],
        data = Employee.fromJson(json["data"]);

  Map<String, dynamic> toJson() =>
      {"status": status, "message": message, "data": data.toJson()};
}
