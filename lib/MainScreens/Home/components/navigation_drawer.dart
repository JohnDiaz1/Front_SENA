import 'package:flutter/material.dart';
import 'package:front_sena/MainScreens/Inventory/inventory_screen.dart';
import 'package:front_sena/MainScreens/Home/home_screen.dart';
import 'package:front_sena/MainScreens/ServiceRequest/service_request_screen.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: const Text("Inicio"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen())),
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory_outlined),
            title: const Text("Inventario"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => InventoryScreen())),
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: const Text("Clientes"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ServiceRequestScreen())),
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: const Text("Solicitudes de Servicio"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ServiceRequestScreen())),
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: const Text("Trabajo en progreso"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ServiceRequestScreen())),
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: const Text("Empleados"),
            onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ServiceRequestScreen())),
            },
          ),
        ],
      ),
    );
  }
}
