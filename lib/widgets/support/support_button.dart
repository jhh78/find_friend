import 'package:flutter/material.dart';

class SupportButton extends StatelessWidget {
  final void Function() callBack;
  final String text;
  const SupportButton({super.key, required this.callBack, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callBack,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[400],
        //높이를 설정한다
        minimumSize: const Size(150, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: Colors.blueGrey,
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
