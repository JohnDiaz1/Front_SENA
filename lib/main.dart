import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/provider/inventory_provider.dart';
import 'package:front_sena/provider/service_request_provider.dart';
import 'package:front_sena/provider/employee_provider.dart';
import 'package:front_sena/mainScreens/serviceRequest/service_request_screen.dart';
import 'package:front_sena/mainScreens/Home/home_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ClientProvider>(create: (_) => ClientProvider()),
          ChangeNotifierProvider<InventoryProvider>(create: (_) => InventoryProvider()),
          ChangeNotifierProvider<ServiceRequestProvider>(create: (_) => ServiceRequestProvider()),
          ChangeNotifierProvider<EmployeeProvider>(create: (_) => EmployeeProvider()),
          ChangeNotifierProvider(create: (_) => ClientDropdownController()),
        ],
      child: MaterialApp(
        title: 'Sena App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          primaryColor: Color(0xff2c2b50),
          primaryColorDark: Color(0xff050028),
          primaryColorLight: Color(0xff57547c),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

