
import 'employee_model.dart';

class EmpList {
  String? status;
  String? message;
  List<Employee>? data;

  EmpList.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        message = json['message'],
        data = List<Employee>.from(
            json['data'].map((element) => Employee.fromJson(element)));

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((e) => e.toJson()))
      };
}
