import 'dart:io';
import 'dart:typed_data';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/crypt.dart';

import '../../../attachments/queue.dart';
import '../../../constants/color.dart';
import '../../../router.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../common_object/foundation/use_cases/create_object_usecase.dart';
import '../../common_object/foundation/use_cases/delete_object_item_usecase.dart';
import '../../common_object/foundation/use_cases/get_object_list_usecase.dart';

class ScreenPhotoList extends ConsumerStatefulWidget {
  const ScreenPhotoList(
      {super.key, required this.appId, required this.screenId});

  final String appId;
  final String screenId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ScreenPhotoListState();
}

class _ScreenPhotoListState extends ConsumerState<ScreenPhotoList> {
  final ImagePicker _picker = ImagePicker();
  String? _secret;
  String _selectedCategory = 'current';
  final List<String> _categories = ['current', 'prototype', 'archive'];

  @override
  void initState() {
    super.initState();
    _loadSecret();
  }

  Future<void> _loadSecret() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _secret = prefs.getString('app_${widget.appId}_secret');
    });
  }

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
      ['screen_photos', 'list', widget.screenId, _selectedCategory]
    ]);
  }

  Future<void> _addPhoto() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();
    final photoId = const Uuid().v4();
    final filename = 'screens/$photoId.jpg';
    final localUri = await attachmentQueue.getLocalUri(filename);

    // Ensure the directory exists
    final destDir = Directory(localUri).parent;
    if (!await destDir.exists()) {
      await destDir.create(recursive: true);
    }

    if (_secret != null) {
      final encBytes = encryptBytes(bytes, _secret!);
      await File(localUri).writeAsBytes(encBytes);
      await attachmentQueue.saveFile(photoId, encBytes.length,
          folder: 'screens');
    } else {
      await attachmentQueue.localStorage.copyFile(file.path, localUri);
      await attachmentQueue.saveFile(photoId, bytes.length, folder: 'screens');
    }

    await _createMutation.mutate(
      CreateObjectUseCaseParams(
        objectType: 'screen_photos',
        data: {
          'app_id': widget.appId,
          'screen_id': widget.screenId,
          'name': file.name,
          'photo_id': photoId,
          'category': 'current',
        },
      ),
    );

    _refresh();
  }

  Future<void> _deletePhoto(Map<String, dynamic> item) async {
    await attachmentQueue.deleteFile(item['photo_id'], folder: 'screens');
    await _deleteMutation.mutate(
      DeleteObjectItemUseCaseParams(
        objectType: 'screen_photos',
        objectId: item['id'],
      ),
    );
    _refresh();
  }

  Future<void> _openFullScreenImage(Uint8List bytes) async {
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
                child: Image.memory(bytes),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _loadPhotoBytes(String photoId) async {
    final path = await attachmentQueue.getLocalUri('screens/$photoId.jpg');
    final fileBytes = await File(path).readAsBytes();
    if (_secret != null) {
      return decryptBytes(fileBytes, _secret!);
    }
    return fileBytes;
  }

  Future<void> _openPhotoDetail(Map<String, dynamic> item) async {
    final bytes = await _loadPhotoBytes(item['photo_id']);
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
                  onTap: () => _openFullScreenImage(bytes),
                  onDoubleTap: () => _openFullScreenImage(bytes),
                  child: Image.memory(bytes),
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
                  appId: widget.appId,
                  objectType: 'screen_photos',
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
            'Design',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
                _refresh();
              }
            },
            items: _categories
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
          ),
          QueryBuilder<List<Map<String, dynamic>>>(
          query: Query(
                key: [
                  'screen_photos',
                  'list',
                  widget.screenId,
                  _selectedCategory,
                ],
                queryFn: () async {
                  return await GetObjectListUseCase(
                    objectRepository: ObjectRepository(),
                  ).execute(
                    GetObjectListUseCaseParams(
                      objectType: 'screen_photos',
                      sortValues: const {},
                      filterValues: {
                        'screen_id': widget.screenId,
                        'category': _selectedCategory,
                      },
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
                        return FutureBuilder<Uint8List>(
                          future: _loadPhotoBytes(e['photo_id']),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: () => _openPhotoDetail(e),
                              child: Image.memory(
                                snapshot.data!,
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
