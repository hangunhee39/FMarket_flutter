import 'package:flutter/material.dart';

import '../../../presentation/main/component/top_app_bar/widgets/svg_icon_button.dart';
import '../../theme/constant/app_icons.dart';
import '../../theme/custom/custom_font_weight.dart';
import '../../theme/custom/custom_theme.dart';

const double _counterHeight = 36;
const double _counterWidth = 96;
const double _iconSize = 16;
const double _iconPadding = 8;

class CounterBtn extends StatelessWidget {
  const CounterBtn({
    super.key,
    required this.quantity,
    this.increased,
    this.decreased,
  });

  final int quantity;
  final VoidCallback? increased;
  final VoidCallback? decreased;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      width: _counterWidth,
      height: _counterHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgIconButton(
            icon: AppIcons.subtract,
            color: quantity == 1
                ? Theme.of(context).colorScheme.contentFourth
                : Theme.of(context).colorScheme.contentPrimary,
            padding: _iconPadding,
            size: _iconSize,
            onPressed: decreased,
          ),
          Text(
            '${quantity}',
            style: Theme.of(context).textTheme.labelLarge.semiBold?.copyWith(
                  color: Theme.of(context).colorScheme.contentPrimary,
                ),
          ),
          SvgIconButton(
            icon: AppIcons.add,
            color: Theme.of(context).colorScheme.contentPrimary,
            padding: _iconPadding,
            size: _iconSize,
            onPressed: increased,
          ),
        ],
      ),
    );
  }
}
