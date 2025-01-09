import 'package:app_1/common/utils/kcolors.dart';
import 'package:app_1/common/widgets/app_style.dart';
import 'package:flutter/cupertino.dart';

void showCartPopup(BuildContext context) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(
            'Update Cart Item Qauntity',
            style: appStyle(
              18.0,
              Kolors.kGrayLight,
              FontWeight.bold,
            ),
          ),
          message: const Text(
            "By updating the cart the app will refetch the data",
            style: TextStyle(
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
        );
      });
}
