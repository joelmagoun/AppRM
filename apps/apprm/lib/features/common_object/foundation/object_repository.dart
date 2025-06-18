import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bootstrap/powersync.dart';
import '../../../utils/crypt.dart';

const _encryptedNameDescriptionTables = {
  'data_objects',
  'data_fields',
  'screens',
  'screen_functions',
  'user_stories',
  'screen_photos',
  'user_story_steps',
};

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
      final orderByKey = sortValues.entries.map((e) => '${e.key} ${e.value}').join(', ');
      sortStatement = " ORDER BY $orderByKey";
    }

    var filterStatement = "";
    if (filterValues.isNotEmpty) {
      final conditionByKey = filterValues.entries.map((e) => '${e.key}=\'${e.value}\'').join(' AND ');
      filterStatement = " WHERE $conditionByKey";
    }

    if (searchValue?.isNotEmpty ?? false) {
      final searchStatement = searchFields.map((e) => '$e LIKE \'%$searchValue%\'').join(' OR ');
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
      } else if (tableName == 'history') {
        query = '''
          SELECT h.*, p.name AS username, a.name AS app_name
          FROM history h
          LEFT JOIN profile p ON h.user_id = p.id
          LEFT JOIN applications a ON h.app_id = a.id''';
      } else if (tableName == 'applications') {
        final userId = getUserId();
        if (userId != null) {
          query = '''
            SELECT a.*
            FROM applications a
            LEFT JOIN application_users au ON au.app_id = a.id
            WHERE au.user_id = '$userId'
          ''';
        }
      }
      query = '$query$filterStatement$sortStatement';

      final results = await db.getAll(query);

      final list =
          results.map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value})).toList();

      if (tableName == 'requirements' || _encryptedNameDescriptionTables.contains(tableName)) {
        for (var i = 0; i < list.length; i++) {
          if (tableName == 'requirements') {
            list[i] = await _decryptRequirementFields(list[i]);
          } else {
            list[i] = await _decryptNameDescriptionFields(list[i]);
          }
        }
      }

      return list;
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
      } else if (tableName == 'history') {
        query = '''
          SELECT h.*, p.name AS username, a.name AS app_name
          FROM history h
          LEFT JOIN profile p ON h.user_id = p.id
          LEFT JOIN applications a ON h.app_id = a.id
          WHERE h.id = ?''';
      } else if (tableName == 'user_story_steps') {
        query = '''
          SELECT ss.*, us.app_id
          FROM user_story_steps ss
          JOIN user_stories us ON ss.story_id = us.id
          WHERE ss.id = ?''';
      }
      final result = await db.get(query, [objectId]);

      var map = result.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value});

      if (tableName == 'requirements' || _encryptedNameDescriptionTables.contains(tableName)) {
        if (tableName == 'requirements') {
          map = await _decryptRequirementFields(map);
        } else {
          map = await _decryptNameDescriptionFields(map);
        }
      }

      return map;
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
          .map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value}))
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
      String? appId = data['app_id'];
      if (tableName == 'user_story_steps' && data['story_id'] != null) {
        appId = await _getAppIdFromStory(data['story_id']);
        if (appId != null) {
          data = await _encryptNameDescriptionFields(appId, data);
        }
      } else if (tableName == 'requirements' && appId != null) {
        data = await _encryptRequirementFields(appId, data);
      } else if (_encryptedNameDescriptionTables.contains(tableName) && appId != null) {
        data = await _encryptNameDescriptionFields(appId, data);
      }
      final fieldStatement = data.keys.map((e) => "'$e'").join(', ');
      final valueStatement = data.values.map((e) => "'$e'").join(', ');

      final result = await db.execute(
        "INSERT INTO $tableName(id, $fieldStatement, created_at, updated_at) VALUES (uuid(), $valueStatement, datetime(), datetime()) RETURNING *",
      );
      final id = result.firstWhere((e) => e.containsKey('id'))['id'];

      if (appId != null) {
        var name = _extractName(data);
        if (name.isNotEmpty) {
          final secret = await _getAppSecret(appId);
          if (secret != null) {
            try {
              name = executeDecrypt(name, secret);
            } catch (_) {
              // ignore decrypt errors
            }
          }
        }
        final message = 'Created $tableName${name.isNotEmpty ? ' \"$name\"' : ''}';
        await _insertHistory(
          appId: appId,
          userId: getUserId(),
          message: message,
        );
      }

      return id;
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
      if (tableName == 'user_story_steps') {
        final appId = await _getAppIdFromStep(objectId);
        if (appId != null) {
          data = await _encryptNameDescriptionFields(appId, data);
        }
      } else if (tableName == 'requirements' || _encryptedNameDescriptionTables.contains(tableName)) {
        final existing = await getObjectItem(tableName: tableName, objectId: objectId);
        final appId = existing['app_id'];
        if (appId != null) {
          if (tableName == 'requirements') {
            data = await _encryptRequirementFields(appId, data);
          } else {
            data = await _encryptNameDescriptionFields(appId, data);
          }
        }
      }
      final setStatement = data.entries.map((e) => "'${e.key}' = '${e.value ?? ''}'").join(', ');
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
      final item = await getObjectItem(tableName: tableName, objectId: objectId);
      await db.execute(
        "DELETE FROM $tableName WHERE id = ?",
        [objectId],
      );

      final appId = item['app_id'];
      if (appId != null) {
        final name = _extractName(item);
        final message = 'Deleted $tableName${name.isNotEmpty ? ' \"$name\"' : ''}';
        await _insertHistory(
          appId: appId,
          userId: getUserId(),
          message: message,
        );
      }
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
          .map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value}))
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
          .map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value}))
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
          .map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getNavigations({
    required String fromId,
    required String fromType,
  }) async {
    try {
      final results = await db.getAll(
        '''
        SELECT n.*, s.name AS screen_name, sf.name AS function_name
        FROM navigations n
        LEFT JOIN screens s ON n.navigation_to = s.id AND n.navigation_to_type = 'screen'
        LEFT JOIN screen_functions sf ON sf.id = n.navigation_to AND n.navigation_to_type = 'function'
        WHERE n.navigation_from = ? AND n.navigation_from_type = ?
        ''',
        [fromId, fromType],
      );

      return results
          .map((r) => r.entries.fold<Map<String, dynamic>>({}, (res, e) => {...res, e.key: e.value}))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUserStorySteps({
    required String storyId,
  }) async {
    try {
      final results = await db.getAll(
        '''
        SELECT ss.*, us.app_id
        FROM user_story_steps ss
        JOIN user_stories us ON ss.story_id = us.id
        WHERE ss.story_id = ?
        ORDER BY rank
        ''',
        [storyId],
      );

      final list = results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
                {},
                (res, e) => {...res, e.key: e.value},
              ))
          .toList();

      for (var i = 0; i < list.length; i++) {
        list[i] = await _decryptNameDescriptionFields(list[i]);
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getStepActions({
    required String stepId,
  }) async {
    try {
      final results = await db.getAll(
        '''
        SELECT sa.*, e.name AS element_name, sf.name AS function_name, us.app_id
        FROM user_story_step_actions sa
        JOIN user_story_steps ss ON sa.step_id = ss.id
        JOIN user_stories us ON ss.story_id = us.id
        LEFT JOIN elements e ON sa.target_id = e.id AND sa.target_type = 'element'
        LEFT JOIN screen_functions sf ON sa.target_id = sf.id AND sa.target_type = 'screen_function'
        WHERE sa.step_id = ?
        ORDER BY sa.rank
        ''',
        [stepId],
      );

      final list = results
          .map((r) => r.entries.fold<Map<String, dynamic>>(
                {},
                (res, e) => {...res, e.key: e.value},
              ))
          .toList();

      for (var i = 0; i < list.length; i++) {
        final item = list[i];
        final appId = item['app_id'] as String?;
        if (appId != null && item['function_name'] != null) {
          final secret = await _getAppSecret(appId);
          if (secret != null) {
            try {
              item['function_name'] = executeDecrypt(item['function_name'].toString(), secret);
            } catch (_) {
              // ignore decrypt errors
            }
          }
        }
        list[i] = item;
      }

      return list;
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

  String _extractName(Map<String, dynamic> data) {
    return (data['name'] ?? data['requirement'] ?? data['description'] ?? '').toString();
  }

  Future<String?> _getAppSecret(String appId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('app_${appId}_secret');
  }

  Future<String?> _getAppIdFromStory(String storyId) async {
    try {
      final result = await db.get(
        'SELECT app_id FROM user_stories WHERE id = ?',
        [storyId],
      );
      return result['app_id'] as String?;
    } catch (_) {
      return null;
    }
  }

  Future<String?> _getAppIdFromStep(String stepId) async {
    try {
      final result = await db.get(
        '''
        SELECT us.app_id
        FROM user_story_steps ss
        JOIN user_stories us ON ss.story_id = us.id
        WHERE ss.id = ?
        ''',
        [stepId],
      );
      return result['app_id'] as String?;
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> _encryptRequirementFields(String appId, Map<String, dynamic> data) async {
    final secret = await _getAppSecret(appId);
    if (secret == null) return data;
    final newData = Map<String, dynamic>.from(data);
    if (newData['requirement'] != null) {
      newData['requirement'] = executeEncrypt(newData['requirement'].toString(), secret);
    }
    if (newData['description'] != null) {
      newData['description'] = executeEncrypt(newData['description'].toString(), secret);
    }
    return newData;
  }

  Future<Map<String, dynamic>> _encryptNameDescriptionFields(String appId, Map<String, dynamic> data) async {
    final secret = await _getAppSecret(appId);
    if (secret == null) return data;
    final newData = Map<String, dynamic>.from(data);
    if (newData['name'] != null) {
      newData['name'] = executeEncrypt(newData['name'].toString(), secret);
    }
    if (newData['description'] != null) {
      newData['description'] = executeEncrypt(newData['description'].toString(), secret);
    }
    if (newData['type'] != null) {
      newData['type'] = executeEncrypt(newData['type'].toString(), secret);
    }
    if (newData['default_value'] != null) {
      newData['default_value'] = executeEncrypt(newData['default_value'].toString(), secret);
    }
    return newData;
  }

  Future<Map<String, dynamic>> _decryptRequirementFields(Map<String, dynamic> data) async {
    final appId = data['app_id'];
    if (appId == null) return data;
    final secret = await _getAppSecret(appId);
    if (secret == null) return data;
    final newData = Map<String, dynamic>.from(data);
    if (newData['requirement'] != null) {
      newData['requirement'] = executeDecrypt(newData['requirement'].toString(), secret);
    }
    if (newData['description'] != null) {
      newData['description'] = executeDecrypt(newData['description'].toString(), secret);
    }
    return newData;
  }

  Future<Map<String, dynamic>> _decryptNameDescriptionFields(Map<String, dynamic> data) async {
    final appId = data['app_id'];
    if (appId == null) return data;
    final secret = await _getAppSecret(appId);
    if (secret == null) return data;
    final newData = Map<String, dynamic>.from(data);
    if (newData['name'] != null) {
      newData['name'] = executeDecrypt(newData['name'].toString(), secret);
    }
    if (newData['description'] != null) {
      newData['description'] = executeDecrypt(newData['description'].toString(), secret);
    }
    if (newData['type'] != null) {
      newData['type'] = executeDecrypt(newData['type'].toString(), secret);
    }
    if (newData['default_value'] != null) {
      newData['default_value'] = executeDecrypt(newData['default_value'].toString(), secret);
    }
    return newData;
  }

  Future<void> _insertHistory({
    required String appId,
    required String? userId,
    required String message,
  }) async {
    try {
      await db.execute(
        "INSERT INTO history(id, app_id, user_id, message, created_at) VALUES (uuid(), ?, ?, ?, datetime())",
        [appId, userId, message],
      );
    } catch (e) {
      // ignore
    }
  }
}
