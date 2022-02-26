import 'dart:convert';
import 'package:http/http.dart';
import 'package:networking_lesson_6_6/models/employee_create.dart';
import 'package:networking_lesson_6_6/models/employee_delete.dart';
import 'package:networking_lesson_6_6/models/employee_model.dart';
import 'package:networking_lesson_6_6/models/employee_one.dart';
import 'package:networking_lesson_6_6/models/employee_update.dart';
import '../models/employee_list.dart';
import 'log_service.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "dummy.restapiexample.com";
  static String SERVER_PRODUCTION = "dummy.restapiexample.com";

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  static Map<String, String> getHeaders() {
    Map<String, String> header = {
      "Content-type": 'application/json; charset=UTF-8'
    };
    return header;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, String> params) async {
    Uri uri = Uri.http(getServer(), api, params);
    var response = await get(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if (response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    Uri uri = Uri.http(getServer(), api);
    var response =
        await post(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if (response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    Uri uri = Uri.http(getServer(), api);
    var response =
        await put(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if (response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    Uri uri = Uri.http(getServer(), api);
    var response =
        await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if (response.statusCode == 429) return "Too many request";
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> paramsEmpty) async {
    Uri uri = Uri.http(getServer(), api);
    var response = await delete(uri, headers: getHeaders());
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;
    if (response.statusCode == 429) return "Too many request";
    return null;
  }

  /* Http Apis */
  static String API_LIST = "/api/v1/employees";
  static String API_ONE_ELEMENT = "/api/v1/employee/"; //{id}
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/"; //{id}
  static String API_DELETE = "/api/v1/delete/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'employee_name': employee.name!,
      'employee_salary': employee.salary.toString(),
      'employee_age': employee.age.toString(),
      'profile_image': employee.image??"",
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'id': employee.id.toString(),
      'employee_name': employee.name!,
      'employee_salary': employee.salary.toString(),
      'employee_age': employee.age.toString(),
      'profile_image': employee.image??"",
    });
    return params;
  }

  /* Http parsing */

  static EmpList parseEmpList(String response){
      dynamic json = jsonDecode(response);
      return EmpList.fromJson(json);
  }

  static EmpOne parseEmpOne(String response){
    dynamic json = jsonDecode(response);
    return EmpOne.fromJson(json);
  }

  static CreateEmployee parseCreate(String response){
    dynamic json = jsonDecode(response);
    return CreateEmployee.fromJson(json);
  }

  static UpdateEmployee parseUpdate(String response){
    dynamic json = jsonDecode(response);
    return UpdateEmployee.fromJson(json);
  }

  static DeleteEmployee parseDelete(String response){
    dynamic json = jsonDecode(response);
    return DeleteEmployee.fromJson(json);
  }
}
