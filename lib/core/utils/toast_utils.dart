import 'package:Flutter_BoilerPlate_With_Auth/core/app/flavor_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void showToast(String message) {
    var themeConfig = FlavorConfig.instance.values.themeConfig;
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: themeConfig?.colorsConfig.defaultToastBackgroundColor,
        textColor: themeConfig?.colorsConfig.defaultToastTextColor);
  }
}
