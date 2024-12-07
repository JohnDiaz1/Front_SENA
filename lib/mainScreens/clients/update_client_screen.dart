import 'package:flutter/material.dart';
import 'package:front_sena/Utils/constants_app.dart';
import 'package:front_sena/widgets/app_header_back.dart';
import 'package:provider/provider.dart';

import '../../provider/client_provider.dart';
import '../../widgets/button_widget_solid.dart';
import '../../models/client_model.dart';

class UpdateClientScreen extends StatefulWidget {
  final String clientId;

  const UpdateClientScreen({super.key, required this.clientId});

  @override
  State<UpdateClientScreen> createState() => _UpdateClientScreenState();
}

class _UpdateClientScreenState extends State<UpdateClientScreen> {
  late ClientProvider clientProvider;

  late String selectedValue = "";
  late TextEditingController _identificationController =
      TextEditingController();
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    _loadClientData();
  }

  Future<void> _loadClientData() async {
    await clientProvider.getClientById(widget.clientId);
    if (mounted) {
      _identificationController =
          TextEditingController(text: clientProvider.clientModel?.cedula);
      _nameController =
          TextEditingController(text: clientProvider.clientModel?.name);
      _addressController =
          TextEditingController(text: clientProvider.clientModel?.address);
      _phoneController =
          TextEditingController(text: clientProvider.clientModel?.phone);
      _emailController =
          TextEditingController(text: clientProvider.clientModel?.email);
      setState(() {}); // Redibujar la interfaz después de obtener los datos
    }
    //clientList = clientProvider.clientsModel;
    //selectedValue = clientList.first.name;
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
          AppHeaderBack(),
          Flexible(
            child: Container(
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
              child: clientProvider.clientModel == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Editar Cliente",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
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
                          SizedBox(height: ConstantsApp.defaultPadding),
                          Container(
                            child: ButtonWidgetSolid(
                              label: "Guardar",
                              onTap: () async {
                                bool response =
                                    await clientProvider.updateClient(Client(
                                        clientId: clientProvider
                                            .clientModel!.clientId,
                                        cedula: _identificationController.text,
                                        name: _nameController.text,
                                        address: _addressController.text,
                                        phone: _phoneController.text,
                                        email: _emailController.text));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response
                                          ? '¡Cliente actualizado exitosamente!'
                                          : 'Error al actualizar informacion del cliente',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        response ? Colors.green : Colors.red,
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
        ],
      ),
    );
  }
}
