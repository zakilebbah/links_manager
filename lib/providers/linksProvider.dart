import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:links_manager/models/pageLink.dart';
import 'package:links_manager/utils/dataModule.dart';

class LinksProvider with ChangeNotifier {
  final DataModule _dataModule = DataModule();

  Future<List<PageLink>> _links = Future.value([]);
  Future<List<PageLink>> get links => _links;

  void getLinks() {
    _links = _dataModule.getPageLinks();
    notifyListeners();
  }

  Future<void> addLink(PageLink link) async {
    await _dataModule.saveLink(link);
    getLinks();
  }

  Future<void> updateLink(PageLink link, int index) async {
    await _dataModule.updateLink(link, index);
    getLinks();
  }

  Future<void> deleteLink(int index) async {
    await _dataModule.deleteLink(index);
    getLinks();
  }

  Future<int> getNumOfLinks() async {
    int num = await _dataModule.getNumberOfPageLinks();
    return num;
  }
}
