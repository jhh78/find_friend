import 'package:find_friend/utils/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class NoticeService {
  Future<List<RecordModel>> getNoticesList() async {
    try {
      final pb = PocketBase(API_URL);

      // you can also fetch all records at once via getFullList
      final records = await pb.collection('notice').getFullList(
            sort: '-created',
          );

      return records;
    } catch (error) {
      rethrow;
    }
  }
}
