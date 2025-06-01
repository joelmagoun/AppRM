import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../action_repository.dart';
import 'common_usecase.dart';

final createActionProvider = Provider<CreateActionUseCase>(
  (ref) => CreateActionUseCase(
    actionRepository: ref.read(actionRepositoryProvider),
  ),
);

class CreateActionUseCase
    implements ParamsUseCase<Future<void>, CreateActionUseCaseParams> {
  final ActionRepository actionRepository;

  CreateActionUseCase({required this.actionRepository});

  @override
  execute(params) {
    return actionRepository.create(
      userId: params.userId,
      data: params.data,
    );
  }
}

class CreateActionUseCaseParams {
  final String userId;
  final Map<String, dynamic> data;

  CreateActionUseCaseParams({
    required this.userId,
    required this.data,
  });
}
