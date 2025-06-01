import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../bootstrap/powersync.dart';
import 'models/notification.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => NotificationRepository(),
);

class NotificationRepository {
  Future<List<Notification>> getList() async {
    try {
      final results = await db
          .getAll('SELECT * FROM notifications ORDER BY created_at DESC');

      return results
          .map(
            (r) => Notification.fromJson(r.entries.fold<Map<String, dynamic>>(
              {},
              (res, e) => {...res, e.key: e.value},
            )),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> countUnread() async {
    try {
      final result = await db.execute(
          'SELECT count(*) as count FROM (SELECT id FROM notifications WHERE read_at IS NULL ORDER BY created_at DESC) as unread_notifications;');

      return result.firstOrNull?['count'] ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsRead({
    required String itemId,
  }) async {
    try {
      await db.execute(
          'UPDATE notifications SET read_at=datetime() WHERE id = ?', [itemId]);
    } catch (e) {
      rethrow;
    }
  }
}
