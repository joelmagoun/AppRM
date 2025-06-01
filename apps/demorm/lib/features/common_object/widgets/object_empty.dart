import 'package:apprm/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ObjectEmpty extends ConsumerWidget {
  const ObjectEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Icon(
            PhosphorIconsRegular.empty,
            size: 96,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              'Not found!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const Text('Add your item to keep track of information.'),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(PhosphorIconsBold.plus),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
