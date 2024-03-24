import 'package:flutter/material.dart';
import 'package:links_manager/pages/home/homePage.dart';
import 'package:links_manager/providers/linksProvider.dart';
import 'package:links_manager/utils/dataModule.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  DataModule.initializeHive().whenComplete;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LinksProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Links Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        focusColor: Colors.cyan.shade600,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.grey.shade800, //change your color here
          ),
          titleTextStyle: TextStyle(
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 19),
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      home: const HomePage(),
    );
  }
}
