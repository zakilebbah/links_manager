import 'package:flutter/material.dart';
import 'package:links_manager/models/pageLink.dart';
import 'package:links_manager/providers/linksProvider.dart';
import 'package:links_manager/utils/dataModule.dart';
import 'package:links_manager/utils/utils.dart';
import 'package:provider/provider.dart';

class LinksPage extends StatefulWidget {
  const LinksPage({super.key});

  @override
  State<LinksPage> createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  DataModule dataModule = DataModule();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LinksProvider provider =
          Provider.of<LinksProvider>(context, listen: false);
      provider.getLinks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        height: double.infinity,
        child:
            Consumer<LinksProvider>(builder: (context, carListProvider, child) {
          return FutureBuilder<List<PageLink>>(
              future: carListProvider.links,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(3),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Utils.showAddLinkBottomSheet(context,
                                index: index, pageLink: snapshot.data![index]);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: ListTile(
                              leading: Image.asset(
                                Utils.getIconPath(snapshot.data![index].URL),
                                height: 50.0,
                                width: 50.0,
                                alignment: Alignment.center,
                              ),
                              title: snapshot.data![index].NAME != null
                                  ? Text(snapshot.data![index].NAME!)
                                  : null,
                              subtitle: Text(
                                snapshot.data![index].URL,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ));
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              });
        }));
  }
}
