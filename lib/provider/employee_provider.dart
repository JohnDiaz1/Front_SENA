import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/employee_http_service.dart';
import 'package:front_sena/models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> employeeModel = [];
  EmployeeHttpService employeeHttpService = EmployeeHttpService();
  String responseString = "";

  void getAllEmployees() async {
    employeeModel = await employeeHttpService.getAllEmployees();
    notifyListeners();
  }

  void createEmployee(Employee employee) async {
    responseString = await employeeHttpService.createEmployee(employee);
    notifyListeners();
  }

  void deleteEmployeeById(String employeeId) async {
    responseString = await employeeHttpService.deleteEmployeeId(employeeId);
    notifyListeners();
  }
}