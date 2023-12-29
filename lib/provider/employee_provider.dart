import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/employee_http_service.dart';
import 'package:front_sena/models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> employeesModel = [];
  Employee? employeeModel;
  EmployeeHttpService employeeHttpService = EmployeeHttpService();
  String responseString = "";

  Future<void> getAllEmployees() async {
    employeesModel = await employeeHttpService.getAllEmployees();
    notifyListeners();
  }

  Future<void> getEmployeeById(String employeeId) async {
    employeeModel = await employeeHttpService.getEmployeeById(employeeId);
    notifyListeners();
  }

  void createEmployee(Employee employee) async {
    responseString = await employeeHttpService.createEmployee(employee);
    notifyListeners();
  }

  void updateEmployee(Employee employee) async {
    responseString = await employeeHttpService.updateEmployee(employee);
    notifyListeners();
  }

  void deleteEmployeeById(String employeeId) async {
    responseString = await employeeHttpService.deleteEmployeeId(employeeId);
    notifyListeners();
  }
}