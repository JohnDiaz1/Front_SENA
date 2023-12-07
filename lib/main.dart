import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'MainScreens/Welcome/welcome_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:front_sena/Provider/client_provider.dart';
import 'package:front_sena/Provider/inventory_provider.dart';
import 'package:front_sena/Provider/service_request_provider.dart';
import 'package:front_sena/MainScreens/ServiceRequest/service_request_screen.dart';
import 'package:front_sena/MainScreens/Home/home_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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

