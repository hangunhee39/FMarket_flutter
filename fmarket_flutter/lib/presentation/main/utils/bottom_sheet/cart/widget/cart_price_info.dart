import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/theme/constant/app_icons.dart';
import '../../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../core/utils/widgets/counter_btn.dart';
import '../../../../../../domain/model/display/product_info/product_info.model.dart';
import '../../../../../pages/home/component/view_module/view_module_widget/product_card_widget.dart';
import '../../../../bloc/cart_bloc/cart_bloc.dart';
import '../../../../component/top_app_bar/widgets/svg_icon_button.dart';

const double _counterHeight = 36;
const double _counterWidth = 96;
const double _iconSize = 16;
const double _iconPadding = 8;

class CartPriceInfo extends StatelessWidget {
  const CartPriceInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartBloc>().state;
    final cartBloc = context.read<CartBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.productInfo.title,
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    state.productInfo.price.toWon(),
                    style:
                        Theme.of(context).textTheme.titleSmall?.priceCopyWith(),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    state.productInfo.originalPrice.toWon(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.originalPriceCopyWith(),
                  ),
                ],
              ),
              CounterBtn(
                quantity: state.quantity,
                increased: () => cartBloc.add(CartQuantityIncreased()),
                decreased: () => cartBloc.add(CartQuantityDecreased()),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Theme.of(context).colorScheme.outline),
              //     borderRadius: const BorderRadius.all(Radius.circular(4)),
              //   ),
              //   width: _counterWidth,
              //   height: _counterHeight,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       SvgIconButton(
              //         icon: AppIcons.subtract,
              //         color: state.quantity == 1
              //             ? Theme.of(context).colorScheme.contentFourth
              //             : Theme.of(context).colorScheme.contentPrimary,
              //         padding: _iconPadding,
              //         size: _iconSize,
              //         onPressed: () => cartBloc.add(CartQuantityDecreased()),
              //       ),
              //       Text(
              //         '${state.quantity}',
              //         style: Theme.of(context).textTheme.labelLarge.semiBold?.copyWith(
              //               color: Theme.of(context).colorScheme.contentPrimary,
              //             ),
              //       ),
              //       SvgIconButton(
              //         icon: AppIcons.add,
              //         color: Theme.of(context).colorScheme.contentPrimary,
              //         padding: _iconPadding,
              //         size: _iconSize,
              //         onPressed: () => cartBloc.add(CartQuantityIncreased()),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
