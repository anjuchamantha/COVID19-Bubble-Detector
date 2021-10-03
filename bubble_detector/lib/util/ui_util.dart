import 'package:url_launcher/url_launcher.dart';

abstract class UiUtil {
  /// Used to call the [number] passed
  static telephone(String number) async {
    if (await canLaunch('tel:$number')) {
      await launch('tel:$number');
    }
  }
}
