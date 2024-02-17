import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_sena/widgets/app_header_back.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/inventory_provider.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:front_sena/models/inventory_model.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({super.key});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  late InventoryProvider inventoryProvider;
   TextEditingController _nameController = TextEditingController();
   TextEditingController _descriptionController = TextEditingController();
   TextEditingController _stockController = TextEditingController();
   TextEditingController _precioCompraController = TextEditingController();
   TextEditingController _precioVentaController = TextEditingController();

  @override
  void initState() {
    inventoryProvider = Provider.of<InventoryProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _precioCompraController.dispose();
    _precioVentaController.dispose();
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
                        controller: _descriptionController,
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
                        controller: _stockController,
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
                        controller: _precioCompraController,
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
                        controller: _precioVentaController,
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
                          onTap: () async {
                            bool response = await inventoryProvider.createItem(Inventory.create(
                                name: _nameController.text,
                                description: _descriptionController.text,
                                stock: int.parse(_stockController.text),
                                precioCompra: double.parse(_precioCompraController.text),
                                precioVenta: double.parse(_precioVentaController.text)
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  response
                                      ? '¡Item creado exitosamente!'
                                      : 'Error al crear el item',
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
