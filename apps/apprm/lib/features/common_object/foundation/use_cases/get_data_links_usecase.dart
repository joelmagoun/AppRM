import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../object_repository.dart';
import 'common_usecase.dart';

final getDataLinksProvider = Provider<GetDataLinksUseCase>(
  (ref) => GetDataLinksUseCase(
    objectRepository: ref.read(objectRepositoryProvider),
  ),
);

class GetDataLinksUseCase implements ParamsUseCase<Future<List<Map<String, dynamic>>>, GetDataLinksUseCaseParams> {
  final ObjectRepository objectRepository;

  GetDataLinksUseCase({required this.objectRepository});

  @override
  execute(params) {
    return objectRepository.getDataLinks(functionId: params.functionId);
  }
}

class GetDataLinksUseCaseParams {
  final String functionId;

  GetDataLinksUseCaseParams({required this.functionId});
}
