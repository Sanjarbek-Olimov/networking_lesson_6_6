import 'package:networking_lesson_6_6/models/employee_model.dart';

class EmpOne {
  String status;
  String message;
  Employee data;

  EmpOne.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        message = json["message"],
        data = Employee.fromJson(json["data"]);

  Map<String, dynamic> toJson() =>
      {"status": status, "message": message, "data": data.toJson()};
}
