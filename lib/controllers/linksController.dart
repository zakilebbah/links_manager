import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:links_manager/models/pageLink.dart';
import 'package:links_manager/utils/dataModule.dart';

class LinksController extends GetxController {
  final DataModule _dataModule = DataModule();

  Future<List<PageLink>> links = Future.value([]);
  // Future<List<PageLink>> links = _link

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    getLinks();
    super.onInit();
  }

  void getLinks() {
    links = _dataModule.getPageLinks();
    update();
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
