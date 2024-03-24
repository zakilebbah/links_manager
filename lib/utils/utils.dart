import 'package:flutter/material.dart';
import 'package:links_manager/models/pageLink.dart';
import 'package:links_manager/pages/home/linkBottomSheet.dart';

class Utils {
  static void showAddLinkBottomSheet(BuildContext pageContext,
      {int? index, PageLink? pageLink}) {
    showModalBottomSheet(
        context: pageContext,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Padding(
                padding: EdgeInsets.only(
                    top: 0,
                    right: 20,
                    left: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: LinkBottomSheet(
                  homeSetState: setState,
                  index: index,
                  pageLink: pageLink,
                ));
          });
        });
  }

  static void showErrorMessage(String message0, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message0,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        backgroundColor: Colors.red.shade800,
        dismissDirection: DismissDirection.startToEnd));
  }

  static String getIconPath(String url) {
    if (url.toLowerCase().contains('instagram')) {
      return 'assets/icons/instagram.png';
    } else if (url.toLowerCase().contains('facebook')) {
      return 'assets/icons/facebook.png';
    } else if (url.toLowerCase().contains('tiktok')) {
      return 'assets/icons/tiktok.png';
    } else {
      return 'assets/icons/website.png';
    }
  }
}
