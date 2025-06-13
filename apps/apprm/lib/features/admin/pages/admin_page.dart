import 'package:flutter/material.dart';

import '../../../bootstrap/powersync.dart';
import '../../../constants/color.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _apps = [];
  Set<String> _assignments = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final users = await db.getAll(
        "SELECT id, name FROM profile WHERE name IS NOT NULL ORDER BY name");
    final apps =
        await db.getAll("SELECT id, name FROM applications ORDER BY name");
    final assigns =
        await db.getAll('SELECT user_id, app_id FROM application_users');
    setState(() {
      _users = users;
      _apps = apps;
      _assignments =
          assigns.map((e) => '${e['user_id']}_${e['app_id']}').toSet();
    });
  }

  Future<void> _toggle(String userId, String appId, String appName) async {
    final key = '${userId}_$appId';
    final assigned = _assignments.contains(key);
    if (assigned) {
      await db.execute(
          "DELETE FROM application_users WHERE user_id=? AND app_id=?",
          [userId, appId]);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Unassigned from $appName')));
      }
    } else {
      await db.execute(
          "INSERT INTO application_users(id, created_at, updated_at, app_id, user_id) VALUES (uuid(), datetime(), datetime(), ?, ?)",
          [appId, userId]);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Assigned to $appName')));
      }
    }
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text('Admin'),
      ),
      body: _users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, idx) {
                final user = _users[idx];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        children: _apps.map((app) {
                          final assigned = _assignments
                              .contains('${user['id']}_${app['id']}');
                          return ElevatedButton(
                            onPressed: () => _toggle(
                                user['id'], app['id'], app['name'] as String),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: assigned
                                  ? AppColors.primaryColor
                                  : Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(app['name']),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: _users.length,
            ),
    );
  }
}
