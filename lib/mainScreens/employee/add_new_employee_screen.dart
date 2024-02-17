import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_sena/widgets/app_header_back.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/employee_provider.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:front_sena/models/employee_model.dart';

class AddNewEmployeeScreen extends StatefulWidget {
  const AddNewEmployeeScreen({super.key});

  @override
  State<AddNewEmployeeScreen> createState() => _AddNewEmployeeScreenState();
}

class _AddNewEmployeeScreenState extends State<AddNewEmployeeScreen> {

  late EmployeeProvider employeeProvider;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _positionController = TextEditingController();

  @override
  void initState() {
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          AppHeaderBack(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ConstantsApp.defaultPadding),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    ConstantsApp.defaultPadding / 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ConstantsApp.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Añadir Nuevo Item",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
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
                        "Posicion",
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
                        maxLines: 3,
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
                        "En este campo deberá ingresar la posicion que ocupa el empleado",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: ButtonWidgetSolid(
                          label: "Guardar",
                          onTap: () async {
                            bool response = await employeeProvider.createEmployee(
                                Employee.
                                create(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  position: _positionController.text,
                                  state: EmployeeStatus.Activo));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  response
                                      ? '¡Empleado creado exitosamente!'
                                      : 'Error al crear el empleado',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: response ? Colors.green : Colors.red,
                              ),
                            );
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
          ),
        ],
      ),
    );
  }
}
