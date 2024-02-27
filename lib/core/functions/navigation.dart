import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

navigateOff(BuildContext context, Widget screen) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

pop(BuildContext context) {
  Navigator.pop(context);
}
