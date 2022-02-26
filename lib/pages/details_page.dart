import 'package:flutter/material.dart';
import 'package:networking_lesson_6_6/models/employee_model.dart';
import 'package:networking_lesson_6_6/models/employee_one.dart';

import '../services/http_service.dart';

class DetailsPage extends StatefulWidget {
  static const String id = "details_page";
  int? employeeId;

  DetailsPage({Key? key, this.employeeId}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Employee data = Employee();
  bool isLoading = true;

  void _showResponse(String response) {
    EmpOne empOne = Network.parseEmpOne(response);
    setState(() {
      data = empOne.data;
      isLoading = false;
    });
  }

  void _apiOneEmployee(int id) {
    Network.GET(Network.API_ONE_ELEMENT + id.toString(), Network.paramsEmpty())
        .then((response) => {_showResponse(response!)});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiOneEmployee(widget.employeeId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
      ),
      body: Center(
        child: isLoading?const CircularProgressIndicator.adaptive():Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
               data.name.toString() + "(${data.age})"),
            const SizedBox(
              height: 5,
            ),
            Text("\$" + data.salary.toString()),
          ],
        ),
      ),
    );
  }
}
