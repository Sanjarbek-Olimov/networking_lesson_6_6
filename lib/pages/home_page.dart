import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:networking_lesson_6_6/models/employee_create.dart';
import 'package:networking_lesson_6_6/models/employee_delete.dart';
import 'package:networking_lesson_6_6/models/employee_list.dart';
import 'package:networking_lesson_6_6/models/employee_model.dart';
import 'package:networking_lesson_6_6/models/employee_update.dart';
import 'package:networking_lesson_6_6/pages/details_page.dart';
import 'package:networking_lesson_6_6/services/http_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> data = [];
  Employee? dataEmployee;
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void _showResponse(String response) {
    EmpList empList = Network.parseEmpList(response);
    setState(() {
      data = empList.data!;
    });
  }

  void _apiEmployeesList() {
    Network.GET(Network.API_LIST, Network.paramsEmpty())
        .then((response) => {_showResponse(response!)});
  }

  void androidDialogCreate({Employee? employee}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(employee != null ? "Update Employee" : "Create Employee"),
            content: SizedBox(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(hintText: "Name"),
                  ),
                  TextField(
                    controller: salaryController,
                    decoration: const InputDecoration(hintText: "Salary"),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: const InputDecoration(hintText: "Age"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: employee != null
                        ? () {
                            _apiUpdateEmployee(employee.id!);
                          }
                        : _apiCreateEmployee,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          );
        });
  }

  void _apiCreateEmployee() {
    String name = nameController.text.trim();
    int salary = int.parse(salaryController.text.trim());
    int age = int.parse(ageController.text.trim());
    Employee create = Employee(name: name, salary: salary, age: age);
    Network.POST(Network.API_CREATE, Network.paramsCreate(create))
        .then((response) {
      CreateEmployee newEmp = Network.parseCreate(response!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 20),
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: ${newEmp.status}"),
                Text(
                    "Data:\n\tid: ${newEmp.data.id}\n\tname: ${newEmp.data.name}\n\tsalary: ${newEmp.data.salary}\n\tage: ${newEmp.data.age}"),
                Text("Message: ${newEmp.message}")
              ],
            ),
          )));
    });
    nameController.clear();
    salaryController.clear();
    ageController.clear();
    Navigator.pop(context);
  }

  void _apiUpdateEmployee(int id) {
    String name = nameController.text.trim();
    int salary = int.parse(salaryController.text.trim());
    int age = int.parse(ageController.text.trim());
    Employee create = Employee(id: id, name: name, salary: salary, age: age);
    Network.PUT(
            Network.API_UPDATE + id.toString(), Network.paramsUpdate(create))
        .then((response) {
      UpdateEmployee updateEmployeeEmp = Network.parseUpdate(response!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 20),
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: ${updateEmployeeEmp.status}"),
                Text(
                    "Data:\n\tid: ${updateEmployeeEmp.data.id}\n\tname: ${updateEmployeeEmp.data.name}\n\tsalary: ${updateEmployeeEmp.data.salary}\n\tage: ${updateEmployeeEmp.data.age}"),
                Text("Message: ${updateEmployeeEmp.message}")
              ],
            ),
          )));
    });
    nameController.clear();
    salaryController.clear();
    ageController.clear();
    Navigator.pop(context);
  }

  void _apiDeleteEmployee(int id) {
    Network.DEL(Network.API_DELETE + id.toString(), Network.paramsEmpty())
        .then((response) {
      DeleteEmployee deleteEmployee = Network.parseDelete(response!);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 20),
          content: SizedBox(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Status: ${deleteEmployee.status}"),
                Text("Data: ${deleteEmployee.data}"),
                Text("Message: ${deleteEmployee.message}")
              ],
            ),
          )));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiEmployeesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP Networking"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return employees(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: androidDialogCreate,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget employees(int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(employeeId: index + 1)));
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                _apiDeleteEmployee(index+1);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                androidDialogCreate(employee: data[index]);
              },
              icon: Icons.edit,
              backgroundColor: Colors.blue,
            )
          ],
        ),
        child: ListTile(
          title: Text(data[index].name.toString() + "(${data[index].age})"),
          subtitle: Text("\$" + data[index].salary.toString()),
        ),
      ),
    );
  }
}
