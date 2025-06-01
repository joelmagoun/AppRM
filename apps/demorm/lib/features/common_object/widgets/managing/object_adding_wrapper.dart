import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:apprm/features/common_object/foundation/use_cases/create_object_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../constants/color.dart';
import '../../../../typedefs/input_field.dart';
import '../../foundation/object_repository.dart';
import 'object_adding_form.dart';

class ObjectAddingWrapper extends ConsumerStatefulWidget {
  const ObjectAddingWrapper({
    super.key,
    required this.objectType,
    required this.objectLabel,
    required this.inputFields,
  });

  final String objectType;
  final String objectLabel;
  final List<InputField> inputFields;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectAddingWrapperState();
}

class _ObjectAddingWrapperState extends ConsumerState<ObjectAddingWrapper> {
  late FormGroup formGroup;

  final createObjectMutation = Mutation<void, CreateObjectUseCaseParams>(
    queryFn: (params) => CreateObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  @override
  void initState() {
    formGroup = FormGroup(widget.inputFields
        .fold({}, (r, e) => {...r, e.key: FormControl<String>()}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('New ${widget.objectLabel}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: () async {
                formGroup.markAllAsTouched();
                if (formGroup.valid) {
                  try {
                    EasyLoading.show(status: 'Creating...');
                    await createObjectMutation.mutate(CreateObjectUseCaseParams(
                      objectType: widget.objectType,
                      data: formGroup.value,
                    ));
                    CachedQuery.instance.refetchQueries(
                      keys: [widget.objectType, "list"],
                    );
                    if (context.mounted) {
                      context.pop(true);
                    }
                  } catch (e) {
                    EasyLoading.showError(e.toString());
                  } finally {
                    EasyLoading.dismiss();
                  }
                }
              },
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
        child: ObjectAddingForm(
          formGroup: formGroup,
          inputFields: widget.inputFields,
        ),
      ),
    );
  }
}
