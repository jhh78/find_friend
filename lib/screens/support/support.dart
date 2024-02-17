import 'dart:developer';

import 'package:find_friend/utils/googleAd.dart';
import 'package:find_friend/widgets/common/snackbar.dart';
import 'package:find_friend/widgets/common/text.dart';
import 'package:find_friend/widgets/support/supportButton.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        automaticallyImplyLeading: false,
        title: const CustomTextWidget(text: '支援ページ', kind: 'headTitle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    CustomTextWidget(
                      text: 'このアプリで広告を提供しない理由は、皆さんの利用経験を最優先に考えているからです。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text:
                          '広告なしで快適にアプリを利用していただけるように、皆さんが楽しく利用できる環境を作りたいと考えています。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text:
                          'ただし、アプリの運営、向上した機能の提供、より安定したサービスのためには、皆さんのサポートが不可欠です。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: 'アプリの運営、アップデート、新機能追加には皆さんの協力とサポートが必要です',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: '一緒により良いアプリを作るために、支援お願いいたします。',
                      kind: 'body',
                    ),
                    CustomTextWidget(
                      text: 'このアプリの企画者はあなたです。',
                      kind: 'body',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SupportButton(
                      callBack: () {
                        GoogleAdManager().loadInterstitialAd();
                      },
                      text: '広告を見る (+30ポイント)',
                    ),
                    SupportButton(
                      callBack: () {
                        CustomSnackbar.showSuccessSnackbar(
                            title: '100円支援 click',
                            message: 'show me the money');
                      },
                      text: '100円支援 (+120ポイント)',
                    ),
                    SupportButton(
                      callBack: () {
                        CustomSnackbar.showSuccessSnackbar(
                            title: '500円支援 click',
                            message: 'show me the money');
                      },
                      text: '500円支援 (+1300ポイント)',
                    ),
                    SupportButton(
                      callBack: () {
                        CustomSnackbar.showSuccessSnackbar(
                            title: '1000円支援 click',
                            message: 'show me the money');
                      },
                      text: '1000円支援 (+1500ポイント)',
                    ),
                    SupportButton(
                      callBack: () {
                        CustomSnackbar.showSuccessSnackbar(
                            title: '5000円支援 click',
                            message: 'show me the money');
                      },
                      text: '5000円支援 (+8500ポイント)',
                    ),
                    SupportButton(
                      callBack: () {
                        CustomSnackbar.showSuccessSnackbar(
                            title: '10000円支援 click',
                            message: 'show me the money');
                      },
                      text: '1万円支援 (+20000ポイント)',
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
