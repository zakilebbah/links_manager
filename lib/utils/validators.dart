import 'package:links_manager/utils/app_enums.dart';

String? urlValidation(String? url) {
  if (url == null || url.isEmpty) {
    return 'Url Cannot be empty';
  } else if (url.length > 25) {
    return 'Url must be under 25 characters';
  } else if (Uri.parse(url).isAbsolute) {
    return null;
  } else {
    return 'Invalid Url';
  }
}

String? nameValidation(String? name) {
  if (name == null || name.isEmpty) {
    return null;
  } else if (InputValidation(name).isValidName) {
    return null;
  } else {
    return 'Invalid Name';
  }
}
