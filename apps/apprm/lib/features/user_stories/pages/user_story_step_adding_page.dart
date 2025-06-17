import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../constants/color.dart';
import '../../common_object/foundation/object_repository.dart';

class UserStoryStepAddingPage extends ConsumerStatefulWidget {
  const UserStoryStepAddingPage({super.key, required this.appId, required this.storyId});

  final String appId;
  final String storyId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserStoryStepAddingPageState();
}

class _UserStoryStepAddingPageState extends ConsumerState<UserStoryStepAddingPage> {
  late FormGroup formGroup;
  final ObjectRepository _repository = ObjectRepository();

  @override
  void initState() {
    formGroup = FormGroup({
      'name': FormControl<String>(),
      'description': FormControl<String>(),
    });
    super.initState();
  }

  Future<void> _save() async {
    formGroup.markAllAsTouched();
    if (formGroup.valid) {
      try {
        EasyLoading.show(status: 'Creating...');
        await _repository.createObject(
          tableName: 'user_story_steps',
          data: {
            'story_id': widget.storyId,
            'name': formGroup.control('name').value,
            'description': formGroup.control('description').value,
          },
        );
        CachedQuery.instance.refetchQueries(keys: [
          ['user_story_steps', 'list', widget.storyId]
        ]);
        if (context.mounted) {
          context.pop(true);
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text('New step'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: _save,
              icon: const Icon(PhosphorIconsBold.check),
              label: const Text('Add'),
              style: IconButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: ReactiveForm(
          formGroup: formGroup,
          child: Wrap(
            runSpacing: 16,
            children: [
              const Text('Name'),
              ReactiveTextField(
                formControlName: 'name',
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const Text('Description'),
              ReactiveTextField(
                formControlName: 'description',
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
