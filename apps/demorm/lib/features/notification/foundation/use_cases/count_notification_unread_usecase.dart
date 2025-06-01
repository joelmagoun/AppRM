import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notification_repository.dart';
import 'common_usecase.dart';

final countNotificationUnreadProvider =
    Provider<CountNotificationUnreadUseCase>(
  (ref) => CountNotificationUnreadUseCase(
    notificationRepository: ref.read(notificationRepositoryProvider),
  ),
);

class CountNotificationUnreadUseCase implements NoParamsUseCase<Future<int>> {
  final NotificationRepository notificationRepository;

  CountNotificationUnreadUseCase({required this.notificationRepository});

  @override
  execute() {
    return notificationRepository.countUnread();
  }
}
