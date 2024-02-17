import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:front_sena/models/employee_model.dart';
import 'package:front_sena/utils/constants_app.dart';

class EmployeeHttpService {
  final String _url = ConstantsApp.webURL + "employee/";

  Future<List<Employee>> getAllEmployees() async {
    var uri = Uri.parse(_url + "employees");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return employeeFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<Employee> getEmployeeById(String employeeId) async {
    var uri = Uri.parse(_url + "getEmployeeById/$employeeId");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return Employee.fromJson(json.decode(response.body));
    } else {
      throw ("Error al obtener api");
    }
  }

  Future<bool> createEmployee(Employee employee) async {
    try {
      var uri = Uri.parse(_url + "addEmployee");
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: employeeToJson(employee));
      if (response.statusCode == 201) {
        return true; // "Se creo el cliente correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
        return false;
      }
    } catch (error) {
      print("Error en Create Cliente: $error");
      throw "Error inesperado";
    }
  }

  Future<bool> updateEmployee(Employee employee) async {
    try {
      var uri = Uri.parse(_url + "updateEmployee");
      var response = await http.put(uri,
          headers: {"Content-Type": "application/json"},
          body: employeeToJson(employee));
      if (response.statusCode == 200) {
        return true; //"Se actualizo la informacion del empleado correctamente";
      } else {
        return false; //"Error al actualizar informacion del empleado";
      }
    } catch (error) {
      throw "Error inesperado";
    }
  }

  Future<bool> deleteEmployeeId(String employeeId) async {
    try {
      var uri = Uri.parse(_url + "deleteEmployee/${employeeId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return true; // "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
        return false;
      }

    } catch(error) {
      print("Error en deleteItemById: $error");
      throw "Error inesperado";
    }
  }

}