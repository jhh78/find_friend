import 'package:flutter/material.dart';

class CustomBackGroundImageWidget extends StatelessWidget {
  final String type;
  const CustomBackGroundImageWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == 'bg1') {
      return Image.asset(
        'assets/images/bg1.jpg',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    } else if (type == 'bg2') {
      return Image.asset(
        'assets/images/bg2.png',
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      );
    } else if (type == 'intro') {
      return Image.asset(
        'assets/images/intro.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    }

    return const Placeholder();
  }
}
