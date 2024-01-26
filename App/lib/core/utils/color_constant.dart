import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray5066 = fromHex('#66fbfcfc');

  static Color gray5001 = fromHex('#fcfcfc');

  static Color gray5002 = fromHex('#fcfcfd');

  static Color blueGray5099 = fromHex('#99edeef1');

  static Color blueGray50 = fromHex('#edeef1');

  static Color gray90033 = fromHex('#33131416');

  static Color green50019 = fromHex('#1948bc65');

  static Color blue50061 = fromHex('#611786f9');

  static Color red400 = fromHex('#eb5a5a');

  static Color black9003f = fromHex('#3f000000');

  static Color gray50 = fromHex('#f9f9fa');

  static Color green500 = fromHex('#48bc65');

  static Color gray30099 = fromHex('#99d8dae2');

  static Color red40019 = fromHex('#19eb5a5a');

  static Color black900 = fromHex('#000000');

  static Color yellow700 = fromHex('#fabe3c');

  static Color teal900 = fromHex('#082d53');

  static Color blueGray40014 = fromHex('#14718096');

  static Color blueGray900 = fromHex('#29303c');

  static Color red4000c = fromHex('#0ceb5a5a');

  static Color blueGray5001 = fromHex('#eeeff2');

  static Color gray5099 = fromHex('#99f9f9fa');

  static Color gray700 = fromHex('#5d5f6f');

  static Color blueGray5087 = fromHex('#87edeef1');

  static Color blueGray400 = fromHex('#8b8fa7');

  static Color blue500 = fromHex('#1786f9');

  static Color blue900 = fromHex('#7072cf');

  static Color gray900 = fromHex('#131416');

  static Color blueGray500 = fromHex('#74778b');

  static Color gray300 = fromHex('#d8dae2');

  static Color blue50 = fromHex('#d1e7fe');

  static Color gray9007e = fromHex('#7e131416');

  static Color blueGray1000f = fromHex('#0fc5c7d3');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Color getIncidentColor(String status) {
  if (status.toLowerCase() == 'resolved') {
    return ColorConstant.green500;
  } else if (status.toLowerCase() == 'pending') {
    return ColorConstant.yellow700;
  } else {
    return ColorConstant.black900;
  }
}
