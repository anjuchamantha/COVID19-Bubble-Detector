import 'package:url_launcher/url_launcher.dart';

abstract class UiUtil {
  static telephone(String number) async {
    if (await canLaunch('tel:$number')) {
      await launch('tel:$number');
    }
  }
}
