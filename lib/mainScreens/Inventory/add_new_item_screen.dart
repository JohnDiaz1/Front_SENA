import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:front_sena/models/client_model.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
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
                        "En este campo deberá ingresar el nombre del item",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Descripcion",
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
                        maxLines: 3,
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá ingresar la descripcion del item",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Stock",
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
                        "En este campo deberá ingresar la cantidad disponibles de item",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Precio Compra",
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
                        "En este campo deberá ingresar el valor de compra del item",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Precio Venta",
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
                        "En este campo deberá ingresar el valor de venta del item",
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
