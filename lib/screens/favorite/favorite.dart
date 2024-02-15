import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomTextWidget(
        text: 'お気に入り',
        kind: 'headTitle',
      ),
    );
  }
}
