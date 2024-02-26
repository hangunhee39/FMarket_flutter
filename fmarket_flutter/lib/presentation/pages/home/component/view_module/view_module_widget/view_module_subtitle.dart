import 'package:flutter/material.dart';

import '../../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';

class ViewModuleSubtitle extends StatelessWidget {
  final String subtitle;

  const ViewModuleSubtitle({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.contentTertiary,
            ),
      ),
    );
  }
}
