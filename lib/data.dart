import 'package:flutter/material.dart';

class ColorRes {
  static const legendary = Color(0xFFFA922E);
  static const epic = Color(0xFF9D2AF5);
  static const unusual = Color(0xFF266FD5);
  static const regular = Color(0xFF1CEC83);

  static const backGradientBegin = Color(0xFF351113);
  static const backGradientCenter = Color(0xFF110F14);
  static const backGradientEnd = Color(0xFF060E13);

  static const textRed = Colors.red;
  static const textBlue = Color(0xFF54DFE7);
  static const textYellow = Color(0xFFF6EF00);
  static const textWhite = Color(0xFFE4E3E4);

  static const iconBlue = Color(0xFF54DFE7);
  static const btnBackRed = Color(0x40F44336);
  static const splashBlue = Color(0x6054DFE7);
  static const msgBackBlue = Color(0x6054DFE7);
}

class ImageRes {
  static const _imageAssetPath = 'asset/image';
  static const mainHeaderSuffix = '$_imageAssetPath/logo_0.png';
  static const lecture_0 = '$_imageAssetPath/ls.webp';
  static const lecture_1 = '$_imageAssetPath/ls_2.webp';
  static const lecture_2 = '$_imageAssetPath/is_3.png';
  static const lecture_3 = '$_imageAssetPath/4step.gif';
  static const mentor_0 = '$_imageAssetPath/mentor_0.webp';
  static const mentor_1 = '$_imageAssetPath/mentor_1.webp';
  static const mentor_2 = '$_imageAssetPath/mentor_2.webp';
}

class IconRes {
  // static const _iconAssetPath = '/assets/asset/icon';
  static const _iconAssetPath = 'asset/icon';
  static const arch = '$_iconAssetPath/skill_0.svg';
  static const dev = '$_iconAssetPath/skill_1.svg';
  static const anim = '$_iconAssetPath/skill_2.svg';
  static const net = '$_iconAssetPath/skill_3.svg';
  static const inter = '$_iconAssetPath/skill_4.svg';
  static const release = '$_iconAssetPath/skill_5.svg';
  static const logo_text = '$_iconAssetPath/surflogo_text.svg';
  static const logo_gear = '$_iconAssetPath/surflogo_gear.svg';
  static const aware = '$_iconAssetPath/medal.svg';
  static const power = '$_iconAssetPath/exp.svg';
  static const activity = '$_iconAssetPath/src.svg';
  static const resume = '$_iconAssetPath/resume.svg';
  static const briefcase = '$_iconAssetPath/briefcase.svg';
  static const sert = '$_iconAssetPath/sert.svg';
  static const message = '$_iconAssetPath/message.svg';
  static const mainHead = '$_iconAssetPath/main_head.svg';
}

class StyleRes {
  static const content16Blue = TextStyle(fontSize: 16.0, fontFamily: 'play', color: ColorRes.textBlue);
  static const content20Blue = TextStyle(fontSize: 20.0, fontFamily: 'play', color: ColorRes.textBlue);
  static const content24Blue = TextStyle(fontSize: 24.0, fontFamily: 'play', color: ColorRes.textBlue);
  static const content32Blue = TextStyle(fontSize: 32.0, fontFamily: 'play', color: ColorRes.textBlue);
  static const content56Blue = TextStyle(fontSize: 56.0, fontFamily: 'play', color: ColorRes.textBlue);

  static const head24Title = TextStyle(fontSize: 24.0, fontFamily: 'play', color: ColorRes.textYellow);
  static const head36Title = TextStyle(fontSize: 36.0, fontFamily: 'play', color: ColorRes.textYellow);
  static const head40Title = TextStyle(fontSize: 40.0, fontFamily: 'play', color: ColorRes.textYellow);
  static const head56Title = TextStyle(fontSize: 56.0, fontFamily: 'zelek', color: ColorRes.textYellow);
}

final themeData = ThemeData(
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      filled: true,
      fillColor: ColorRes.msgBackBlue,
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
      errorStyle: StyleRes.content20Blue.copyWith(color: ColorRes.textRed),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: ColorRes.textRed),
      ),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: const BorderSide(color: ColorRes.textRed),
      ),
      labelStyle: StyleRes.content24Blue),
);
