import 'package:apprm/constants/color.dart';
import 'package:apprm/typedefs/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MenuActionDialogContent extends ConsumerStatefulWidget {
  const MenuActionDialogContent({
    super.key,
    required this.actionButton,
  });

  final ActionButton actionButton;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MenuActionDialogContentState();
}

class _MenuActionDialogContentState
    extends ConsumerState<MenuActionDialogContent> {
  late FormGroup formGroup;

  @override
  void initState() {
    formGroup = FormGroup(widget.actionButton.params
        .fold({}, (r, e) => {...r, e['name']: FormControl<String>()}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(6),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ).copyWith(bottom: 8),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black54,
                    ),
                    child: const Text('Cancel'),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Assign License',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ReactiveForm(
                  formGroup: formGroup,
                  child: Wrap(
                    runSpacing: 16,
                    children: widget.actionButton.params.map((e) {
                      if (e['type'] == 'SINGLE_SELECT') {
                        return ReactiveDropdownField<String>(
                          formControlName: e['name'],
                          hint: Text('Select ${e['name']}...'),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: e['name'],
                          ),
                          items: e['value']
                                  ?.map<DropdownMenuItem<String>>(
                                      (e) => DropdownMenuItem(
                                            value: e.toString(),
                                            child: Text(e),
                                          ))
                                  .toList() ??
                              <DropdownMenuItem>[],
                        );
                      }

                      return ReactiveTextField(
                        formControlName: e['name'],
                        decoration: InputDecoration(
                          hintText: e['name'],
                          border: const OutlineInputBorder(),
                          labelText: e['name'],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 8),
                child: FilledButton(
                  onPressed: () {
                    formGroup.markAllAsTouched();

                    if (formGroup.valid) {
                      final fieldName =
                          widget.actionButton.params.firstOrNull?['name'] ?? '';
                      Navigator.of(context).pop(formGroup.value[fieldName]);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
