import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

void openLink(String link) async {
  if (await canLaunch(link)) {
    launch(link);
  }
}

bool isSuccess(Response res) {
  return res.statusCode == 200 && res.data["success"] != 0;
}

String capitalize(String text) {
  return "${text[0].toUpperCase()}${text.substring(1)}";
}
