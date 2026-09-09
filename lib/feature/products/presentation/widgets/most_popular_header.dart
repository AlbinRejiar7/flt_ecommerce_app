import 'package:flutter/material.dart';

import '../../../../core/constants/app_spacing.dart';

class MostPopularHeader extends StatelessWidget {
  const MostPopularHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Most Popular', style: theme.textTheme.titleLarge),

          TextButton(onPressed: () {}, child: const Text('See All')),
        ],
      ),
    );
  }
}
