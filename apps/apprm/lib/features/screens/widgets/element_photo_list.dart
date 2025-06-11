import 'dart:io';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../attachments/queue.dart';
import '../../../constants/color.dart';
import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/create_object_usecase.dart';
import '../../common_object/foundation/use_cases/delete_object_item_usecase.dart';
import '../../common_object/foundation/use_cases/get_object_list_usecase.dart';

class ElementPhotoList extends ConsumerStatefulWidget {
  const ElementPhotoList({super.key, required this.elementId});

  final String elementId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ElementPhotoListState();
}

class _ElementPhotoListState extends ConsumerState<ElementPhotoList> {
  final ImagePicker _picker = ImagePicker();

  final _createMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  final _deleteMutation = Mutation<void, DeleteObjectItemUseCaseParams>(
    queryFn: (params) => DeleteObjectItemUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  void _refresh() {
    CachedQuery.instance.refetchQueries(keys: [
      ['element_photos', 'list', widget.elementId]
    ]);
  }

  Future<void> _addPhoto() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    final photoId = const Uuid().v4();
    final filename = '$photoId.jpg';
    final localUri = await attachmentQueue.getLocalUri(filename);

    final destDir = Directory(localUri).parent;
    if (!await destDir.exists()) {
      await destDir.create(recursive: true);
    }

    await attachmentQueue.localStorage.copyFile(file.path, localUri);
    await attachmentQueue.saveFile(photoId, bytes.length);

    await _createMutation.mutate(
      CreateObjectUseCaseParams(
        objectType: 'element_photos',
        data: {
          'element_id': widget.elementId,
          'name': file.name,
          'photo_id': photoId,
        },
      ),
    );

    _refresh();
  }

  Future<void> _deletePhoto(Map<String, dynamic> item) async {
    await attachmentQueue.deleteFile(item['photo_id']);
    await _deleteMutation.mutate(
      DeleteObjectItemUseCaseParams(
        objectType: 'element_photos',
        objectId: item['id'],
      ),
    );
    _refresh();
  }

  Future<void> _openFullScreenImage(String path) async {
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            onDoubleTap: () => Navigator.of(context).pop(),
            child: Center(
              child: InteractiveViewer(
                child: Image.file(File(path)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openPhotoDetail(Map<String, dynamic> item) async {
    final localPath =
        await attachmentQueue.getLocalUri('${item['photo_id']}.jpg');
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _openFullScreenImage(localPath),
                  onDoubleTap: () => _openFullScreenImage(localPath),
                  child: Image.file(File(localPath)),
                ),
                const SizedBox(height: 8),
                Text(item['name'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(item['description'] ?? '--'),
                const SizedBox(height: 4),
                Text('ID: ${item['photo_id']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ObjectUpdatingRoute(
                  appId: GoRouterState.of(context).pathParameters['appId']!,
                  objectType: 'element_photos',
                  objectId: item['id'],
                ).push(context);
              },
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deletePhoto(item);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
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
                  'element_photos',
                  'list',
                  widget.elementId,
                ],
                queryFn: () async {
                  return await GetObjectListUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetObjectListUseCaseParams(
                      objectType: 'element_photos',
                      sortValues: const {},
                      filterValues: {'element_id': widget.elementId},
                      searchFields: const ['name'],
                    ),
                  );
                },
                config: QueryConfig(
                  cacheDuration: Duration(seconds: 1),
                  refetchDuration: Duration(seconds: 1),
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
                          future: attachmentQueue
                              .getLocalUri('${e['photo_id']}.jpg'),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                width: 80,
                                height: 80,
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            final file = File(snapshot.data!);
                            return InkWell(
                              onTap: () => _openPhotoDetail(e),
                              child: Image.file(
                                file,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
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
