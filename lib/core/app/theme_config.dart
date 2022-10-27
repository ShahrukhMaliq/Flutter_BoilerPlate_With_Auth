import 'package:Flutter_BoilerPlate_With_Auth/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  final DimensionsConfig dimensionsConfig;
  final ColorsConfig colorsConfig;
  final TextThemeConfig textThemeConfig;

  ThemeConfig(
      {DimensionsConfig? dimensionsConfig,
      ColorsConfig? colorsConfig,
      TextThemeConfig? textThemeConfig})
      : dimensionsConfig = dimensionsConfig ?? DimensionsConfig(),
        colorsConfig = colorsConfig ?? ColorsConfig(),
        textThemeConfig = textThemeConfig ??
            TextThemeConfig(
                config: colorsConfig ?? ColorsConfig(),
                dimensionsConfig: dimensionsConfig ?? DimensionsConfig());

  ThemeData getThemeData() {
    var textTheme = TextTheme(
        headline1: TextStyle(color: colorsConfig.primaryTextColor),
        headline6: TextStyle(color: colorsConfig.primaryTextColor),
        bodyText2: TextStyle(fontSize: dimensionsConfig.fontSize, fontFamily: 'Hind'));

    var theme = ThemeData(
        appBarTheme: AppBarTheme(),
        primaryColor: colorsConfig.primaryColor,
        primaryColorLight: colorsConfig.primaryColorLight,
        primaryColorDark: colorsConfig.primaryColorDark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: HexColor('#fe892e')),
        ),
        primaryTextTheme: textTheme);

    return theme;
  }
}

class DimensionsConfig {
  final double fontSizeSmall;
  final double fontSize;

  final double? paddingPage;
  final double? paddingControl;
  final double? paddingControlBig;

  final double? margin;

  DimensionsConfig(
      {double? fontSizeSmall,
      double? fontSize,
      double? pagePadding,
      double? controlPadding,
      double? controlPaddingBig,
      double? margin})
      : fontSizeSmall = fontSizeSmall ?? 11,
        fontSize = fontSize ?? 14,
        paddingPage = pagePadding ?? 12,
        paddingControl = controlPadding ?? 5,
        paddingControlBig = controlPaddingBig ?? 10,
        margin = margin ?? 10;
}

class ColorsConfig {
  final HexColor? primaryColor;
  final HexColor? primaryColorLight;
  final HexColor primaryColorDark;
  final HexColor primaryColorGrey;
  final HexColor primaryTextColor;
  final HexColor barcodeLineColor;
  final HexColor defaultToastBackgroundColor;
  final HexColor defaultToastTextColor;
  final HexColor minPlnBorderColor;
  final HexColor minPlnIndicatorLine;
  final HexColor minPlnActiveColor;
  final HexColor minPlnBackgroundColor;

  ColorsConfig(
      {HexColor? primaryColor,
      HexColor? primaryColorLight,
      HexColor? primaryColorDark,
      HexColor? primaryColorGrey,
      HexColor? primaryTextColor,
      HexColor? barcodeLineColor,
      HexColor? defaultToastBackgroundColor,
      HexColor? defaultToastTextColor,
      HexColor? minPlnBorderColor,
      HexColor? minPlnIndicatorLine,
      HexColor? minPlnActiveColor,
      HexColor? minPlnBackgroundColor})
      : this.primaryColor = primaryColor ?? HexColor('#ffffff'),
        this.primaryColorLight = primaryColorLight ?? HexColor('#fe892e'),
        this.primaryColorDark = primaryColorDark ?? HexColor('#000000'),
        this.primaryColorGrey = primaryColorDark ?? HexColor('#717477'),
        this.primaryTextColor = primaryTextColor ?? HexColor('#000000'),
        this.barcodeLineColor = barcodeLineColor ?? HexColor('#fe892e'),
        this.defaultToastBackgroundColor = defaultToastBackgroundColor ?? HexColor('#000000'),
        this.defaultToastTextColor = defaultToastTextColor ?? HexColor('#FFFFFF'),
        this.minPlnBorderColor = minPlnBorderColor ?? HexColor('#CDCDCD'),
        this.minPlnIndicatorLine = minPlnIndicatorLine ?? HexColor('#979797'),
        this.minPlnActiveColor = minPlnActiveColor ?? HexColor('#009DE0'),
        this.minPlnBackgroundColor = minPlnBackgroundColor ?? HexColor('#F4F4F4');
}

class TextThemeConfig {
  final TextStyle headline1;
  final TextStyle headline6;
  final TextStyle bodyText2;

  TextThemeConfig(
      {@required ColorsConfig? config,
      @required DimensionsConfig? dimensionsConfig,
      TextStyle? headline1,
      TextStyle? headline6,
      TextStyle? bodyText2})
      : headline1 = headline1 ?? TextStyle(color: config?.primaryTextColor),
        headline6 = headline6 ?? TextStyle(color: config!.primaryTextColor),
        bodyText2 =
            bodyText2 ?? TextStyle(fontSize: dimensionsConfig?.fontSize, fontFamily: 'Hind');
}
