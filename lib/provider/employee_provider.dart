import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/employee_http_service.dart';
import 'package:front_sena/models/employee_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> employeesModel = [];
  Employee? employeeModel;
  EmployeeHttpService employeeHttpService = EmployeeHttpService();
  String responseString = "";
  bool response = false;

  Future<void> getAllEmployees() async {
    employeesModel = await employeeHttpService.getAllEmployees();
    notifyListeners();
  }

  Future<void> getEmployeeById(String employeeId) async {
    employeeModel = await employeeHttpService.getEmployeeById(employeeId);
    notifyListeners();
  }

  Future<bool> createEmployee(Employee employee) async {
    response = await employeeHttpService.createEmployee(employee);
    notifyListeners();
    return response;
  }

  Future<bool> updateEmployee(Employee employee) async {
    response = await employeeHttpService.updateEmployee(employee);
    notifyListeners();
    return response;
  }

  Future<bool> deleteEmployeeById(String employeeId) async {
    response = await employeeHttpService.deleteEmployeeId(employeeId);
    notifyListeners();
    return response;
  }
}