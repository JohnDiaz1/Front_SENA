import 'dart:convert';

List<Employee> employeeFromJson(String str) => List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

enum EmployeeStatus { Activo, Vacaciones, Inactivo}

class Employee {
  String employeeId;
  String name;
  String phone;
  String position;
  EmployeeStatus state;

  Employee({
    required this.employeeId,
    required this.name,
    required this.phone,
    required this.position,
    required this.state,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    employeeId: json["employeeId"],
    name: json["name"],
    phone: json["phone"],
    position: json["position"],
    state: _parseEmployeeStateToString(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "employeeId": employeeId,
    "name": name,
    "phone": phone,
    "position": position,
    "state": _parseStringToEmployeeState(state),
  };

  static EmployeeStatus _parseEmployeeStateToString(dynamic state) {
    switch (state) {
      case "Activo":
        return EmployeeStatus.Activo;
      case "Vacaciones":
        return EmployeeStatus.Vacaciones;
      case "Inactivo":
        return EmployeeStatus.Inactivo;
      default:
        throw Exception("Unknown ServiceRequestState: $state");
    }
  }

  static String _parseStringToEmployeeState(dynamic state) {
    switch (state) {
      case EmployeeStatus.Activo:
        return "Activo";
      case  EmployeeStatus.Vacaciones:
        return "Vacaciones";
      case EmployeeStatus.Inactivo:
        return "Inactivo";
      default:
        throw Exception("Unknown ServiceRequestState: $state");
    }
  }

}