import 'package:hive/hive.dart';
part 'pageLink.g.dart';

@HiveType(typeId: 1)
class PageLink {
  static final Map<String, int> idxFields = {
    'URL': 0,
    'NAME': 1,
  };

  @HiveField(0)
  String URL;
  @HiveField(1)
  String? NAME;

  PageLink({
    required this.URL,
    this.NAME,
  });
}
