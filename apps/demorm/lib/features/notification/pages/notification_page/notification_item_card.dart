import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:demorm/features/notification/foundation/notification_repository.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../foundation/models/notification.dart';
import '../../foundation/use_cases/mark_notification_as_read_usecase.dart';

class NotificationItemCard extends ConsumerStatefulWidget {
  const NotificationItemCard({
    super.key,
    required this.item,
  });

  final Notification item;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationItemCardState();
}

class _NotificationItemCardState extends ConsumerState<NotificationItemCard> {
  final markNotificationAsReadMutation =
      Mutation<void, MarkNotificationAsReadUseCaseParams>(
    queryFn: (params) => MarkNotificationAsReadUseCase(
      notificationRepository: NotificationRepository(),
    ).execute(params),
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await markNotificationAsReadMutation.mutate(
          MarkNotificationAsReadUseCaseParams(itemId: widget.item.id),
        );
        CachedQuery.instance.refetchQueries(
          keys: [
            ["notification", "list"]
          ],
        );
        CachedQuery.instance.refetchQueries(
          keys: [
            ["notification", "list", "count"]
          ],
        );
      },
      selected: widget.item.readAt == null,
      selectedTileColor: Colors.blue.shade50,
      leading: const Icon(PhosphorIconsRegular.chat),
      title: Text(widget.item.message ?? '--'),
      subtitle: Text(
        DateFormat('MMM dd, hh:mm a').format(widget.item.createdAt),
      ),
      titleAlignment: ListTileTitleAlignment.top,
    );
  }
}
