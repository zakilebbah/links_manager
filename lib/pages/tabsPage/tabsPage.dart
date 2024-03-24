import 'package:flutter/material.dart';
import 'package:links_manager/pages/emptyPage/emptyPage.dart';
import 'package:links_manager/pages/linksPage/linksPage.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text("Empty"),
              ),
              Tab(child: Text("Links")),
            ],
          ),
          body: TabBarView(
            children: [
              EmptyPage(),
              LinksPage(),
            ],
          ),
        ));
  }
}
