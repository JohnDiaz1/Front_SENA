import 'package:http/http.dart' as http;
import 'package:front_sena/models/employee_model.dart';
import 'package:front_sena/utils/constants_app.dart';

class EmployeeHttpService {
  final String _url = ConstantsApp.webURL;

  Future<List<Employee>> getAllEmployees() async {
    var uri = Uri.parse(_url + "employees");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return employeeFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<String> deleteEmployeeId(String employeeId) async {
    try {
      var uri = Uri.parse(_url + "deleteEmployee/${employeeId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }

    } catch(error) {
      print("Error en deleteItemById: $error");
      throw "Error inesperado";
    }
  }

}