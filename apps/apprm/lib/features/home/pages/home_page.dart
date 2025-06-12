import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:apprm/bootstrap/powersync.dart';
import 'package:apprm/constants/color.dart';
import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final objectListData = [
    (icon: PhosphorIconsFill.appWindow, title: 'Applications', route: '/applications'),
    (icon: PhosphorIconsFill.clock, title: 'Work Log', route: '/work_logs'),
    (icon: PhosphorIconsFill.clockCounterClockwise, title: 'History', route: '/history')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Home'),
        actions: [
          QueryBuilder<int>(
            query: Query(
              key: ["notification", "list", "count"],
              queryFn: () async => 0,
              config: QueryConfig(
                cacheDuration: const Duration(seconds: 1),
                refetchDuration: const Duration(seconds: 1),
              ),
            ),
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () async {
                      NotificationRoute().push(context);
                    },
                    icon: const Icon(PhosphorIconsBold.dog),
                  ),
                  if (state.data != null && state.data! > 0)
                    const Positioned(
                      top: 14,
                      right: 14,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: Colors.red,
                      ),
                    ),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () async {
                await logout();
                if (context.mounted) {
                  const AuthPageRoute().pushReplacement(context);
                }
              },
              icon: const Icon(PhosphorIconsBold.signOut),
            ),
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, idx) {
          final objectData = objectListData[idx];
          return ListTile(
            onTap: () {
              context.push(objectData.route);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            selected: true,
            selectedTileColor: Colors.white,
            leading: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Icon(
                objectData.icon,
                color: AppColors.primaryColor,
                size: 24,
              ),
            ),
            title: Text(objectData.title),
            trailing: const Icon(
              PhosphorIconsBold.caretRight,
              size: 20,
            ),
          );
        },
        separatorBuilder: (_, idx) => const SizedBox(height: 8),
        itemCount: objectListData.length,
      ),
    );
  }
}
