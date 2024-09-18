import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/select_table_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/preview_order_screen.dart';
import 'screens/order_summary_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación para Meseros',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const SelectTableScreen(),
        '/menu': (context) => const MenuScreen(),
        '/previewOrder': (context) => PreviewOrderScreen(
          order: ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>,
        ),
        '/orderSummary': (context) => OrderSummaryScreen(
          order: ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>,
        ),
      },
    );
  }
}
