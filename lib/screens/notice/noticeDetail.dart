import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomBackGroundImageWidget(type: 'bg'),
        _renderContents(context),
      ],
    );
  }

  Scaffold _renderContents(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextWidget(
                text: Get.arguments.data['title'],
                kind: 'headTitle2',
              ),
              const Divider(
                color: Colors.black54,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomTextWidget(
                      text: Get.arguments.data['contents'],
                      kind: 'fieldTitle',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
