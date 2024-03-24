import 'package:flutter/material.dart';
import 'package:links_manager/pages/tabsPage/tabsPage.dart';
import 'package:links_manager/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double heightOfModalBottomSheet = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Links Manager"),
      ),
      body: const TabsPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.showAddLinkBottomSheet(context);
        },
        child: const Icon(
          Icons.add,
          size: 26,
        ),
      ),
    );
  }
}
