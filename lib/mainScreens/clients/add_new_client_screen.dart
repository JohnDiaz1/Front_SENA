import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/provider/service_request_provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';

class AddNewClientScreen extends StatefulWidget {
  final String? itemId;

  const AddNewClientScreen({super.key, this.itemId});

  @override
  State<AddNewClientScreen> createState() =>
      _AddNewClientScreen();
}

class _AddNewClientScreen extends State<AddNewClientScreen> {
  late List<Client> clientList;
  //Iterable<TableRow>? filteredServiceRequestList;
  late ClientProvider clientProvider;
  late String selectedValue;
  late TextEditingController _identificationController;
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;


  @override
  void initState() {
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    clientProvider.getAllClient();
    clientList = clientProvider.clientsModel;
    selectedValue = clientList.first.name;
    _identificationController = TextEditingController();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _identificationController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          AppHeader(),
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
                        "Añadir Nuevo Cliente",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "Cedula",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _identificationController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá ingresar la cedula del cliente",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
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
                        "En este campo deberá ingresar el nombre del cliente",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Direccion",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá ingresar la direccion del cliente",
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
                        "En este campo deberá ingresar el telefono del ciente",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Correo Electronico",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá ingresar el correo electronico del cliente",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      Expanded(
                          child: ButtonWidgetSolid(
                            label: "Guardar",
                            onTap: () {
                              clientProvider?.createClient(
                                  Client.create(
                                      cedula: _identificationController.text,
                                      name: _nameController.text,
                                      address: _addressController.text,
                                      phone: _phoneController.text,
                                      email: _emailController.text
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
          ),
        ],
      ),
    );
  }
}
