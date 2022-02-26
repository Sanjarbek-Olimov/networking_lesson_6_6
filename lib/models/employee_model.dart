class Employee {
  int? id;
  String? name;
  int? salary;
  int? age;
  String? image;

  Employee({this.id, this.name, this.salary, this.age, this.image});

  Employee.fromJson(Map<String, dynamic> json)
      : id = json["id"] is int?json["id"]:int.parse(json["id"]),
        name = json["employee_name"],
        salary = json["employee_salary"] is int?json["employee_salary"]:int.parse(json["employee_salary"]),
        age = json["employee_age"] is int?json["employee_age"]:int.parse(json["employee_age"]),
        image = json["profile_image"];

  Map<String, dynamic> toJson() =>
      {'id': id, 'employee_name': name, 'employee_salary': salary, 'employee_age': age, 'profile_image': image};
}
