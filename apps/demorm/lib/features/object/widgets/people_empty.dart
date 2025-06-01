import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';

class PeopleEmpty extends ConsumerWidget {
  const PeopleEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'assets/images/img_people_empty.png',
            width: 120,
            height: 120,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              'Ready to populate your people list?',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Add people information to stay connected and collaborate effectively.',
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
