import 'package:apprm/typedefs/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExternalObjectDetailCard extends ConsumerWidget {
  const ExternalObjectDetailCard({
    super.key,
    required this.externalObjectType,
    required this.externalObjectId,
    required this.displayFields,
    this.objectItem,
  });

  final String externalObjectType;
  final String externalObjectId;
  final List<DisplayField> displayFields;
  final Map<String, dynamic>? objectItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 12,
          children: [
            ...displayFields.map(
              (e) => SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      e.label,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      objectItem?[e.key] ?? '--',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
