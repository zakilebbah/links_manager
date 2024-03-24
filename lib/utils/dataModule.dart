import 'package:hive_flutter/adapters.dart';
import 'package:links_manager/models/pageLink.dart';

class DataModule {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PageLinkAdapter());
  }

  Future<List<PageLink>> getPageLinks() async {
    var box = await Hive.openBox<PageLink>('link');
    List<PageLink> linkList = box.values.toList();
    if (box.isOpen) await box.close();
    return linkList;
  }

  Future<void> saveLink(PageLink link) async {
    var box = await Hive.openBox<PageLink>('link');
    await box.add(link);
    if (box.isOpen) await box.close();
  }

  Future<void> updateLink(PageLink link, int index) async {
    var box = await Hive.openBox<PageLink>('link');
    await box.putAt(index, link);
    if (box.isOpen) await box.close();
  }

  Future<void> deleteLink(int index) async {
    var box = await Hive.openBox<PageLink>('link');
    await box.deleteAt(index);
    if (box.isOpen) await box.close();
  }

  Future<int> getNumberOfPageLinks() async {
    var box = await Hive.openBox<PageLink>('link');
    List<PageLink> linkList = box.values.toList();
    if (box.isOpen) await box.close();
    return linkList.length;
  }
}
