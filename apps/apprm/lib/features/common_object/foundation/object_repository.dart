import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../bootstrap/powersync.dart';

final objectRepositoryProvider = Provider<ObjectRepository>(
  (ref) => ObjectRepository(),
);

class ObjectRepository {
  Future<List<Map<String, dynamic>>> getObjectList({
    required String tableName,
    required Map<String, String?> sortValues,
    required Map<String, String?> filterValues,
    required List<String> searchFields,
    final String? searchValue,
  }) async {
    var sortStatement = "";
    if (sortValues.isNotEmpty) {
      final orderByKey =
          sortValues.entries.map((e) => '${e.key} ${e.value}').join(', ');
      sortStatement = " ORDER BY $orderByKey";
    }

    var filterStatement = "";
    if (filterValues.isNotEmpty) {
      final conditionByKey = filterValues.entries
          .map((e) => '${e.key}=\'${e.value}\'')
          .join(' AND ');
      filterStatement = " WHERE $conditionByKey";
    }

    if (searchValue?.isNotEmpty ?? false) {
      final searchStatement =
          searchFields.map((e) => '$e LIKE \'%$searchValue%\'').join(' OR ');
      if (filterStatement.isNotEmpty) {
        filterStatement = "$filterStatement $searchStatement";
      } else {
        filterStatement = " WHERE $searchStatement";
      }
    }

    try {
      String query = 'SELECT * FROM $tableName';
      if (tableName == 'work_logs') {
        query = '''
          SELECT wl.*, p.name AS username, a.name AS app_name
          FROM work_logs wl
          LEFT JOIN profile p ON wl.user_id = p.id
          LEFT JOIN applications a ON wl.app_id = a.id''';
      }
      query = '$query$filterStatement$sortStatement';

      final results = await db.getAll(query);

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getObjectItem({
    required String tableName,
    required String objectId,
  }) async {
    try {
      String query = 'SELECT * FROM $tableName WHERE id=?';
      if (tableName == 'work_logs') {
        query = '''
          SELECT wl.*, p.name AS username, a.name AS app_name
          FROM work_logs wl
          LEFT JOIN profile p ON wl.user_id = p.id
          LEFT JOIN applications a ON wl.app_id = a.id
          WHERE wl.id = ?''';
      }
      final result = await db.get(query, [objectId]);

      return result.entries
          .fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUniqueFieldList({
    required String tableName,
    required String field,
  }) async {
    try {
      final results = await db.getAll('SELECT DISTINCT $field FROM $tableName');

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> createObject({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    if (data.isEmpty) throw Exception('Please input at least 1 field');
    try {
      final fieldStatement = data.keys.map((e) => "'$e'").join(', ');
      final valueStatement = data.values.map((e) => "'$e'").join(', ');

      final result = await db.execute(
        "INSERT INTO $tableName(id, $fieldStatement, created_at, updated_at) VALUES (uuid(), $valueStatement, datetime(), datetime()) RETURNING *",
      );

      return result.firstWhere((e) => e.containsKey('id'))['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateObjectItem({
    required String tableName,
    required String objectId,
    required Map<String, dynamic> data,
  }) async {
    if (data.isEmpty) throw Exception('Please input at least 1 field');
    try {
      final setStatement =
          data.entries.map((e) => "'${e.key}' = '${e.value ?? ''}'").join(', ');
      await db.execute(
        "UPDATE $tableName SET $setStatement WHERE id = ?",
        [objectId],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteObjectItem({
    required String tableName,
    required String objectId,
  }) async {
    try {
      await db.execute(
        "DELETE FROM $tableName WHERE id = ?",
        [objectId],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getConnectedExternalSystem({
    required String tableName,
    required String objectId,
  }) async {
    try {
      final results = await db.getAll(
        'SELECT child_object_type, child_object_id FROM linked_objects WHERE parent_object_id = ?',
        [objectId],
      );

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDataLinks({
    required String functionId,
  }) async {
    try {
      final results = await db.getAll(
        '''
        SELECT dl.*, do.name AS data_object_name
        FROM data_links dl
        LEFT JOIN data_objects do ON do.id = dl.object_id
        WHERE dl.function_id = ?
        ''',
        [functionId],
      );

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getScreenElements({
    required String screenId,
  }) async {
    try {
      final results = await db.getAll(
        '''
        SELECT e.*
        FROM elements e
        LEFT JOIN screen_elements se ON se.element_id = e.id
        WHERE se.screen_id = ?
        ''',
        [screenId],
      );

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
              {}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future connectToExternalObject({
    required String objectType,
    required String objectId,
    required String externalObjectType,
    required String externalObjectId,
  }) async {
    try {
      await db.execute(
          "DELETE FROM linked_objects WHERE parent_object_type=? AND child_object_type=? AND parent_object_id=?",
          [objectType, externalObjectType, objectId]);

      await db.execute(
          "DELETE FROM linked_objects WHERE parent_object_type=? AND child_object_type=? AND child_object_id=?",
          [objectType, externalObjectType, externalObjectId]);

      await db.execute(
          "INSERT INTO linked_objects(id, parent_object_type, child_object_type, parent_object_id, child_object_id, created_at, updated_at) VALUES (uuid(), ?, ?, ?, ?, datetime(), datetime())",
          [objectType, externalObjectType, objectId, externalObjectId]);
    } catch (e) {
      rethrow;
    }
  }

  Future disconnectFromExternalObject({
    required String objectType,
    required String objectId,
    required String externalObjectType,
    required String externalObjectId,
  }) async {
    try {
      await db.execute(
          "DELETE FROM linked_objects WHERE parent_object_type=? AND child_object_type=? AND parent_object_id=? AND child_object_id=?",
          [objectType, externalObjectType, objectId, externalObjectId]);
    } catch (e) {
      rethrow;
    }
  }

  Future createObjectFromExternalObject({
    required String objectType,
    required String externalObjectType,
    required String externalObjectId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await db.execute(
          "DELETE FROM linked_objects WHERE parent_object_type=? AND child_object_type=? AND child_object_id=?",
          [objectType, externalObjectType, externalObjectId]);

      final objectId = await createObject(tableName: objectType, data: data);
      if (objectId == null) {
        throw Exception('Cannot create the object $objectType');
      }

      await db.execute(
          "INSERT INTO linked_objects(id, parent_object_type, child_object_type, parent_object_id, child_object_id, created_at, updated_at) VALUES (uuid(), ?, ?, ?, ?, datetime(), datetime())",
          [objectType, externalObjectType, objectId, externalObjectId]);
    } catch (e) {
      rethrow;
    }
  }
}
