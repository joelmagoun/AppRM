import '../../common_object/widgets/managing/object_adding_wrapper.dart';
import 'package:flutter/material.dart';

class ApplicationAddingPage extends StatelessWidget {
  const ApplicationAddingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ObjectAddingWrapper(
      objectType: 'applications',
      objectLabel: 'application',
      inputFields: [
        (
          key: 'name',
          label: 'Name',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
        (
          key: 'description',
          label: 'Description',
          placeholder: null,
          displayMode: 'TEXT',
          options: null,
          asyncOptions: null,
        ),
      ],
    );
  }
}
