import 'package:find_friend/providers/thread.dart';
import 'package:find_friend/widgets/common/backgroudImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadDetailScreen extends StatelessWidget {
  ThreadDetailScreen({super.key});

  final ThreadProvider threadProvider = Get.put(ThreadProvider());

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const CustomBackGroundImageWidget(
        type: 'bg',
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black54,
          ),
        ),
        body: Center(
          child: Text(
            'Thread Detail Screen\n ${Get.arguments} \n ${Get.arguments['key']}',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
      )
    ]);
  }
}
