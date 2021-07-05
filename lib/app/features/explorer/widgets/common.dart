import 'package:cloud/app/utils/utils.dart';
import 'package:flutter/material.dart';

buildFileIcon({String? extension, Color? color}) {
  return Container(
    width: 42,
    height: 42,
    decoration:
    BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    child: Center(
        child: extension != null
            ? Text(
          capitalize(extension.toLowerCase()),
          style: TextStyle(fontSize: 10),
        )
            : SizedBox()),
  );
}

loadingDialog(String text){
  return Center(
    child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Material(
                color: Colors.transparent,
                child: Text(text),
              ),
            )
          ],
        )),
  );
}