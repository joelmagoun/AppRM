import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';

class GenericListEmpty extends ConsumerWidget {
  const GenericListEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'assets/images/img_generic_empty.png',
            width: 256,
            height: 256,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              'Your inventory is empty!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Add data to make the app useful :)',
            textAlign: TextAlign.center,
          ),
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
