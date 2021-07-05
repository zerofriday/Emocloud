import 'package:url_launcher/url_launcher.dart';

void openLink(String link) async {
  if (await canLaunch(link)) {
    launch(link);
  }
}
  String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }