import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../bootstrap/powersync.dart';

final externalObjectRepositoryProvider = Provider<ExternalObjectRepository>(
  (ref) => ExternalObjectRepository(),
);

class ExternalObjectRepository {
  Future<List<Map<String, dynamic>>> getList({
    required String tableName,
  }) async {
    try {
      final results = await db.getAll('''
        SELECT ex.*, lo.parent_object_type, lo.parent_object_id, lo.child_object_type, lo.child_object_id
        FROM adp_system_users ex
        LEFT JOIN linked_objects lo ON ex.id = lo.child_object_id;
      ''');
      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getItem({
    required String tableName,
    required String externalObjectId,
  }) async {
    try {
      final result = await db.get('''
        SELECT ex.*, lo.parent_object_type, lo.parent_object_id, lo.child_object_type, lo.child_object_id
        FROM adp_system_users ex
        LEFT JOIN linked_objects lo ON ex.id = lo.child_object_id
        WHERE ex.id=?;
      ''', [externalObjectId]);

      return result.entries
          .fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value});
    } catch (e) {
      rethrow;
    }
  }
}
