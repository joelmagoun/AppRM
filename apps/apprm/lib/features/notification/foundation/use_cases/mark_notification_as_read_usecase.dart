import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notification_repository.dart';
import 'common_usecase.dart';

final markNotificationAsReadProvider = Provider<MarkNotificationAsReadUseCase>(
  (ref) => MarkNotificationAsReadUseCase(
    notificationRepository: ref.read(notificationRepositoryProvider),
  ),
);

class MarkNotificationAsReadUseCase
    implements
        ParamsUseCase<Future<void>, MarkNotificationAsReadUseCaseParams> {
  final NotificationRepository notificationRepository;

  MarkNotificationAsReadUseCase({required this.notificationRepository});

  @override
  execute(params) {
    return notificationRepository.markAsRead(
      itemId: params.itemId,
    );
  }
}

class MarkNotificationAsReadUseCaseParams {
  final String itemId;

  MarkNotificationAsReadUseCaseParams({
    required this.itemId,
  });
}
