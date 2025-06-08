import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../attachments/queue.dart';
import '../../../constants/color.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/create_object_usecase.dart';
import '../../common_object/foundation/use_cases/get_object_list_usecase.dart';

class ScreenPhotoList extends ConsumerStatefulWidget {
  const ScreenPhotoList({super.key, required this.appId, required this.screenId});

  final String appId;
  final String screenId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreenPhotoListState();
}

class _ScreenPhotoListState extends ConsumerState<ScreenPhotoList> {
  final ImagePicker _picker = ImagePicker();

  final _createMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  void _refresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['screen_photos', 'list', widget.screenId]
    ]);
  }

  Future<void> _addPhoto() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    final photoId = const Uuid().v4();
    final filename = '$photoId.jpg';
    final filePath = attachmentQueue.getLocalFilePathSuffix(filename);
    final localUri = await attachmentQueue.getLocalUri(filePath);

    // Ensure the directory exists
    final destDir = Directory(localUri).parent;
    if (!await destDir.exists()) {
      await destDir.create(recursive: true);
    }

    await attachmentQueue.localStorage.copyFile(file.path, localUri);
    await attachmentQueue.saveFile(photoId, bytes.length);

    await _createMutation.mutate(
      CreateObjectUseCaseParams(
        objectType: 'screen_photos',
        data: {
          'app_id': widget.appId,
          'screen_id': widget.screenId,
          'name': file.name,
          'photo_id': photoId,
        },
      ),
    );

    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Photos',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
            query: Query(
                key: [
                  'screen_photos',
                  'list',
                  widget.screenId,
                ],
                queryFn: () async {
                  return await GetObjectListUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetObjectListUseCaseParams(
                      objectType: 'screen_photos',
                      sortValues: const {},
                      filterValues: {'screen_id': widget.screenId},
                      searchFields: const ['name'],
                    ),
                  );
                },
                config: QueryConfig(
                  cacheDuration: const Duration(seconds: 1),
                  refetchDuration: const Duration(seconds: 1),
                  storeQuery: false,
                )),
            builder: (context, state) {
              final list = state.data ?? [];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (list.isEmpty)
                    const Text(
                      '--',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: list.map((e) {
                        return FutureBuilder<String>(
                          future: attachmentQueue.getLocalUri(
                              attachmentQueue.getLocalFilePathSuffix(
                                  '${e['photo_id']}.jpg')),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                            final file = File(snapshot.data!);
                            return Image.file(
                              file,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: OutlinedButton.icon(
                      onPressed: _addPhoto,
                      icon: const Icon(PhosphorIconsBold.plus),
                      label: const Text(''),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
