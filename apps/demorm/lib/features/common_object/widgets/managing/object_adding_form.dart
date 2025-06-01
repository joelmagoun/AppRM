import 'package:demorm/typedefs/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'form_field_base.dart';

class ObjectAddingForm extends ConsumerStatefulWidget {
  const ObjectAddingForm({
    super.key,
    required this.formGroup,
    required this.inputFields,
  });

  final FormGroup formGroup;
  final List<InputField> inputFields;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectAddingFormState();
}

class _ObjectAddingFormState extends ConsumerState<ObjectAddingForm> {
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
