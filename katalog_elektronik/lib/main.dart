import 'package:flutter/material.dart';
import 'package:katalog_elektronik/models/db_manager.dart';
import 'package:katalog_elektronik/models/product_model.dart';
import 'package:katalog_elektronik/providers/product_provider.dart';
import 'package:katalog_elektronik/providers/save_provider.dart';
import 'package:katalog_elektronik/routes/app_routes.dart';
import 'package:katalog_elektronik/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DBManager()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SavedProducts()),
        ChangeNotifierProvider(create: (context) => ProductProvider(Product())),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalog Electronic',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
    );
  }
}
