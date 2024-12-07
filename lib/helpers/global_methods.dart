
import 'package:url_launcher/url_launcher.dart';

class GlobalMethods {

  static void launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

}