import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:links_manager/controllers/linksController.dart';
import 'package:links_manager/models/pageLink.dart';
import 'package:links_manager/providers/linksProvider.dart';
import 'package:links_manager/utils/utils.dart';
import 'package:links_manager/utils/validators.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkBottomSheet extends StatefulWidget {
  final int? index;
  final PageLink? pageLink;
  final StateSetter homeSetState;
  const LinkBottomSheet(
      {super.key,
      required this.homeSetState,
      required this.index,
      required this.pageLink});

  @override
  State<LinkBottomSheet> createState() => _LinkBottomSheetState();
}

class _LinkBottomSheetState extends State<LinkBottomSheet> {
  double _linkSheetHeight = 360;
  late double _linkSheetWidth;
  late double _startSheetHeight;
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _pageTitle = '';

  final _formKey = GlobalKey<FormState>();
  WebViewController controller = WebViewController();
  Future<void> _saveOrUpdateLink(LinksController linksController) async {
    try {
      if (_formKey.currentState!.validate()) {
        if (widget.index != null && widget.pageLink != null) {
          await linksController.updateLink(
              PageLink(URL: _urlController.text, NAME: _nameController.text),
              widget.index!);
        } else {
          if ((await linksController.getNumOfLinks()) == 3) {
            Utils.showErrorMessage(
                "Sorry, you can add up to 3 links in total", context);
          } else {
            await linksController.addLink(
                PageLink(URL: _urlController.text, NAME: _nameController.text));
          }
        }
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      if (mounted) {
        Utils.showErrorMessage(e.toString(), context);
      }
    }
  }

  Future<void> _initSheet() async {
    if (widget.pageLink != null && widget.index != null) {
      _urlController.text = widget.pageLink!.URL;
      _nameController.text = widget.pageLink!.NAME!;
      await _populateWebViewController();
    }
  }

  Future<void> _populateWebViewController() async {
    if (_urlController.text != '') {
      try {
        controller = WebViewController()
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                String? title = await controller.getTitle();
                if (mounted && title != null) {
                  setState(() {
                    _pageTitle = title;
                  });
                }
              },
            ),
          )
          ..loadRequest(
            Uri.parse(_urlController.text),
          );
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    _initSheet();
  }

  @override
  Widget build(BuildContext context) {
    _linkSheetWidth = MediaQuery.of(context).size.width * .8;
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetBuilder<LinksController>(
            // no need to initialize Controller ever again, just mention the type
            builder: (linksController) => Container(
                width: _linkSheetWidth,
                height: _linkSheetHeight,
                color: Colors.transparent,
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          width: MediaQuery.of(context).size.width * .25,
                          height: 14,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: Colors.black,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)))),
                      onVerticalDragStart: (details) {
                        _startSheetHeight = details.globalPosition.dy;
                      },
                      onVerticalDragUpdate: (details) {
                        double endWidth = details.globalPosition.dy;
                        double distance = 0;
                        if (_startSheetHeight < endWidth) {
                          distance = _linkSheetHeight -
                              sqrt((endWidth - _startSheetHeight) *
                                  (endWidth - _startSheetHeight));
                        } else {
                          distance = _linkSheetHeight +
                              sqrt((endWidth - _startSheetHeight) *
                                  (endWidth - _startSheetHeight));
                        }
                        if (distance > 30) {
                          widget.homeSetState(() {
                            _linkSheetHeight = distance;
                          });
                        }

                        _startSheetHeight = endWidth;
                      },
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _pageTitle != ''
                                        ? Wrap(
                                            spacing: 5.0,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: AssetImage(
                                                    Utils.getIconPath(
                                                        _urlController.text)),
                                                radius: 22,
                                              ),
                                              Text(
                                                _pageTitle,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                    _pageTitle != ''
                                        ? const SizedBox(
                                            height: 16,
                                          )
                                        : const SizedBox(),
                                    Focus(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _urlController,
                                        validator: urlValidation,
                                        onChanged: urlValidation,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                            ),
                                            labelText: 'Url *',
                                            hintText: 'Enter Url',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(12)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade300),
                                            )),
                                      ),
                                      onFocusChange: (hasFocus) {
                                        if (!hasFocus) {
                                          _populateWebViewController();
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _nameController,
                                      validator: nameValidation,
                                      onChanged: nameValidation,
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                          ),
                                          labelText: 'Name',
                                          hintText: 'Enter Name',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12)),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Center(
                                        child: Wrap(
                                      spacing: 16,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        (widget.index != null &&
                                                widget.pageLink != null)
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          26, 10, 26, 10),
                                                  backgroundColor: Colors.red,
                                                  elevation: 0,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12), // <-- Radius
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await linksController
                                                      .deleteLink(
                                                          widget.index!);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              )
                                            : const SizedBox(),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.fromLTRB(
                                                26, 10, 26, 10),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 0, 126, 230),
                                            elevation: 0,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12), // <-- Radius
                                            ),
                                          ),
                                          onPressed: () {
                                            _saveOrUpdateLink(linksController);
                                          },
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ))
                                  ],
                                ))))
                  ],
                ))));
  }
}
