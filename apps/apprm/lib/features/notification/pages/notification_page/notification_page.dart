import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../foundation/models/notification.dart';
import '../../foundation/notification_repository.dart';
import '../../foundation/use_cases/get_notification_list_usecase.dart';
import 'notification_item_card.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final query = Query(
    key: [
      "notification",
      "list",
    ],
    queryFn: () async {
      final result = await GetNotificationListUseCase(
        notificationRepository: NotificationRepository(),
      ).execute();

      return result;
    },
    config: QueryConfig(
      cacheDuration: const Duration(seconds: 1),
      refetchDuration: const Duration(seconds: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: QueryBuilder<List<Notification>>(
          query: query,
          builder: (context, state) {
            if (state.status == QueryStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.data?.isEmpty ?? true) {
              return const Center(
                child: Text('No notification yet!'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                query.refetch();
              },
              child: ListView.separated(
                itemBuilder: (context, idx) {
                  return NotificationItemCard(item: state.data![idx]);
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                  indent: 16,
                ),
                itemCount: state.data!.length,
              ),
            );
          }),
    );
  }
}
