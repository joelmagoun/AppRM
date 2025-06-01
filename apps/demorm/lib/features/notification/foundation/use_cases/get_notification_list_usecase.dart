import 'package:demorm/features/notification/foundation/models/notification.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notification_repository.dart';
import 'common_usecase.dart';

final getNotificationListProvider = Provider<GetNotificationListUseCase>(
  (ref) => GetNotificationListUseCase(
    notificationRepository: ref.read(notificationRepositoryProvider),
  ),
);

class GetNotificationListUseCase
    implements NoParamsUseCase<Future<List<Notification>>> {
  final NotificationRepository notificationRepository;

  GetNotificationListUseCase({required this.notificationRepository});

  @override
  execute() {
    return notificationRepository.getList();
  }
}
