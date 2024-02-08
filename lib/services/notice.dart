import 'dart:developer';

import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class NoticeService {
  Future<List<RecordModel>> getNoticesList() async {
    try {
      final pb = PocketBase(REMOTE_DB_URL);

      // you can also fetch all records at once via getFullList
      final records = await pb.collection('notice').getFullList(
            sort: '-created',
          );

      log('>>>>>>>>>>>>>>> NoticeService getNoticesList $records');
      return records;
    } catch (error) {
      rethrow;
    }
  }
}
