import 'package:find_friend/models/thread.dart';
import 'package:find_friend/providers/favorite.dart';
import 'package:find_friend/screens/thread/threadContents.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final FavoriteProvider favoriteProvider = Get.put(FavoriteProvider());

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: const CustomTextWidget(
          text: 'お気に入りスレット一覧',
          kind: 'headTitle',
        ),
        centerTitle: true,
      ),
      body: Obx(() => favoriteProvider.favoriteThreadItems.isEmpty
          ? const Center(
              child: Center(
                child: CustomTextWidget(text: 'スレットがありません', kind: 'listTitle'),
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: favoriteProvider.favoriteThreadItems.length,
              itemBuilder: (BuildContext context, int index) {
                return _renderThreadList(
                    favoriteProvider.favoriteThreadItems[index]);
              },
            )),
    );
  }

  InkWell _renderThreadList(ThreadTable thread) {
    return InkWell(
      onTap: () {
        Get.to(
          () => ThreadContentsScreen(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.size,
          arguments: thread,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          color: Colors.white,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                color: Colors.black54,
              ),
            ),
            title: CustomTextWidget(
              text: thread.title.toString(),
              kind: 'listTitle',
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
