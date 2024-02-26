import 'package:flutter/material.dart';

import '../../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';

class CartBenefit extends StatelessWidget {
  const CartBenefit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0xFFF5C142),
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
            child: Text(
              '적립',
              style: Theme.of(context).textTheme.labelSmall.semiBold
                  ?.copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '로그인 후, 할인 및 적립 혜택 적용',
            style: Theme.of(context).textTheme.labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.contentTertiary),
          ),
        ],
      ),
    );
  }
}