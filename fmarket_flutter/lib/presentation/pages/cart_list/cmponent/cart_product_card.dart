import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/constant/app_icons.dart';
import '../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../core/theme/custom/custom_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/widgets/counter_btn.dart';
import '../../../../domain/model/display/cart/cart.model.dart';
import '../../../main/component/top_app_bar/widgets/svg_icon_button.dart';
import '../bloc/cart_list/cart_list_bloc.dart';

const double _imageHeight = 78;

const double _imageWidth = 60;

class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key, required this.cart});

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final productId = cart.prodcut.productId;

    ///select : 내의 특정 속성의 '변화'를 감지하여 재빌드
    final isSelected = context.select(
      (CartListBloc bloc) => bloc.state.selectedProduct.contains(productId),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///개별 선택
          SvgIconButton(
            icon: (isSelected)
                ? AppIcons.checkMarkCircleFill
                : AppIcons.checkMarkCircle,
            color:
                (isSelected) ? colorScheme.primary : colorScheme.contentFourth,
            onPressed: () =>
                context.read<CartListBloc>().add(CartListSelected(cart: cart)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        cart.prodcut.title,
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorScheme.contentPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Center(
                      ///개별 삭제
                      child: SvgIconButton(
                        icon: AppIcons.close,
                        color: colorScheme.contentTertiary,
                        onPressed: () => context
                            .read<CartListBloc>()
                            .add(CartListDeleted(productIds: [productId])),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                Row(
                  children: [
                    /// 상품 이미지
                    Image.network(
                      cart.prodcut.imageUrl,
                      width: _imageWidth,
                      height: _imageHeight,
                    ),
                    const SizedBox(width: 20),

                    /// 가격 + 수량
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (cart.prodcut.price * cart.quantity).toWon(),
                          style: textTheme.titleMedium.bold?.copyWith(
                            color: colorScheme.contentPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CounterBtn(
                          quantity: cart.quantity,
                          increased: ()=>context.read<CartListBloc>().add(CartListQtyIncreased(cart: cart)),
                          decreased: ()=>context.read<CartListBloc>().add(CartListQtyDecreased(cart: cart)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
