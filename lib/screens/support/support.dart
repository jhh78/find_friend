import 'package:find_friend/utils/google_ad.dart';
import 'package:find_friend/widgets/common/text_body.dart';
import 'package:find_friend/widgets/common/text_title.dart';
import 'package:find_friend/widgets/support/support_button.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Column(
                children: [
                  TextTitle(text: '支援ページ'),
                  TextBody(text: 'このアプリで広告を提供しない理由は、皆さんの利用経験を最優先に考えているからです。'),
                  TextBody(
                      text:
                          '広告なしで快適にアプリを利用していただけるように、皆さんが楽しく利用できる環境を作りたいと考えています。'),
                  TextBody(
                      text:
                          'ただし、アプリの運営、向上した機能の提供、より安定したサービスのためには、皆さんのサポートが不可欠です。'),
                  TextBody(text: 'アプリの運営、アップデート、新機能追加には皆さんの協力とサポートが必要です'),
                  TextBody(text: '一緒により良いアプリを作るために、支援お願いいたします。'),
                  TextBody(text: 'このアプリの企画者はあなたです。'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SupportButton(
                        callBack: () {
                          debugPrint('広告を見る click');
                          GoogleAdManager().loadInterstitialAd();
                        },
                        text: '広告を見る',
                      ),
                      SupportButton(
                        callBack: () {
                          debugPrint('100円支援 click');
                        },
                        text: '100円支援',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SupportButton(
                        callBack: () {
                          debugPrint('500円支援 click');
                        },
                        text: '500円支援',
                      ),
                      SupportButton(
                        callBack: () {
                          debugPrint('1000円支援 click');
                        },
                        text: '1000円支援',
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
