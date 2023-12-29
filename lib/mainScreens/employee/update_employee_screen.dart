import 'package:flutter/material.dart';
import 'package:front_sena/models/employee_model.dart';
import 'package:front_sena/provider/employee_provider.dart';
import 'package:provider/provider.dart';

import '../../Utils/constants_app.dart';
import '../../widgets/app_header_back.dart';
import '../../widgets/button_widget_solid.dart';

class UpdateEmployeeScreen extends StatefulWidget {
  final String employeeId;

  const UpdateEmployeeScreen({super.key, required this.employeeId});

  @override
  State<UpdateEmployeeScreen> createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  late EmployeeProvider employeeProvider;

  String? selectedValue;
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _positionController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    _loadEmployeeData();
  }

  @override
  void dispose() {
    //_identificationController.dispose();
    _nameController.dispose();
    _positionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<Employee> _loadEmployeeData() async {

    await employeeProvider.getEmployeeById(widget.employeeId);
    if (mounted) {
      selectedValue = employeeProvider.employeeModel!.state.name;
      _nameController = TextEditingController(text: employeeProvider.employeeModel?.name);
      _positionController = TextEditingController(text: employeeProvider.employeeModel?.position);
      _phoneController = TextEditingController(text: employeeProvider.employeeModel?.phone);
      setState(() {}); // Redibujar la interfaz después de obtener los datos
      return employeeProvider.employeeModel!;
    }
    throw Exception("No");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          AppHeaderBack(),
          Flexible(child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(ConstantsApp.defaultPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(
                    Radius.circular(ConstantsApp.defaultPadding / 2))),
            margin: EdgeInsets.only(
                top: ConstantsApp.defaultPadding * 2,
                left: ConstantsApp.defaultPadding,
                right: ConstantsApp.defaultPadding * 2,
                bottom: ConstantsApp.defaultPadding * 3),
            child: employeeProvider.employeeModel == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Editar Empleado",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "Nombre",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el nombre del empleado",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Cargo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _positionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el cargo del empleado",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Telefono",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el telefono del empleado",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Estado",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    hint: Text("Selecciona el cliente"),
                    value: selectedValue,
                    borderRadius: BorderRadius.circular(5.0),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: EmployeeStatus.values.map((e) {
                      return DropdownMenuItem(
                        child: Text(e.name),
                        value: e.name,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el estado del empleado",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Container(
                    child: ButtonWidgetSolid(
                      label: "Guardar",
                      onTap: () {
                        employeeProvider.updateEmployee(
                            Employee(
                                employeeId: employeeProvider.employeeModel!.employeeId,
                                name: _nameController.text,
                                phone: _phoneController.text,
                                position: _positionController.text,
                                state: Employee.parseEmployeeStateToString(selectedValue)
                            ));
                      },
                      solidColor: Colors.blue,
                      borderRadius: 4,
                      icon: Icons.save_rounded,
                      labelAndIconColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          ),
          ),
        ],
      ),
    );
  }

}
