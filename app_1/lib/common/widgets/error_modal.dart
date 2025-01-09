import 'dart:convert';

import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';

void showErrorPopup(BuildContext context, String errorMessage, String? title,
    bool? removeCancel) {
  //String decodedMessage = utf8.decode(errorMessage.runes.toList());
  //String decodedTitle =title != null ? utf8.decode(title.runes.toList()) : 'Error';
  String decodedMessage = safeDecode(errorMessage);
  String decodedTitle = title != null ? safeDecode(title) : 'Error';
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text(
          decodedTitle,
          //title ?? 'Error',
          style: appStyle(
            18.0,
            Kolors.kRed,
            FontWeight.bold,
          ),
        ),
        message: Text(
          decodedMessage,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
        cancelButton: removeCancel == null
            ? CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                isDefaultAction: true,
                child: const Text('Cancel'),
              )
            : const SizedBox.shrink(),
      );
    },
  );
}

String safeDecode(String input) {
  try {
    return utf8.decode(utf8.encode(input), allowMalformed: true);
    //return utf8.decode(input.runes.toList(), allowMalformed: true);
    //return utf8.decode(input.codeUnits, allowMalformed: true);
  } catch (e) {
    return input;
  }
}
