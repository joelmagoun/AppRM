import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../bootstrap/powersync.dart';

final actionRepositoryProvider = Provider<ActionRepository>(
  (ref) => ActionRepository(),
);

class ActionRepository {
  Future<String?> create({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    if (data.isEmpty) throw Exception('Please input at least 1 field');
    try {
      final fieldStatement = data.keys.map((e) => "'$e'").join(', ');
      final valueStatement = data.values.map((e) => "'$e'").join(', ');

      final result = await db.execute(
        "INSERT INTO actions(id, $fieldStatement, user_id, created_at, updated_at) VALUES (uuid(), $valueStatement, ?, datetime(), datetime()) RETURNING *",
        [userId],
      );

      return result.firstWhere((e) => e.containsKey('id'))['id'];
    } catch (e) {
      rethrow;
    }
  }
}
