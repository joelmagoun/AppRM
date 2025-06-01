import 'package:demorm/typedefs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'form_field_base.dart';

class ObjectUpdatingForm extends ConsumerStatefulWidget {
  const ObjectUpdatingForm({
    super.key,
    required this.formGroup,
    required this.formValues,
    required this.inputFields,
  });

  final FormGroup formGroup;
  final Map<String, dynamic> formValues;
  final List<InputField> inputFields;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectUpdatingFormState();
}

class _ObjectUpdatingFormState extends ConsumerState<ObjectUpdatingForm> {
  @override
  void initState() {
    if (widget.formValues.isNotEmpty) {
      widget.formGroup.patchValue(widget.formValues);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ObjectUpdatingForm oldWidget) {
    if (oldWidget.formValues != widget.formValues) {
      if (widget.formValues.isNotEmpty) {
        widget.formGroup.patchValue(widget.formValues);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: widget.formGroup,
      child: Wrap(
        runSpacing: 16,
        children:
            widget.inputFields.map((e) => FormFieldBase(field: e)).toList(),
      ),
    );
  }
}
