import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/constant/app_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/custom/custom_font_weight.dart';
import '../../../core/theme/custom/custom_theme.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../domain/model/display/cart/cart.model.dart';
import '../../main/component/payment/payment_btn.dart';
import '../../main/component/top_app_bar/widgets/svg_icon_button.dart';
import 'bloc/cart_list/cart_list_bloc.dart';
import 'cmponent/cart_product_card.dart';
import 'cmponent/cart_total_price.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ///이미 main 에서 있기때문에 blocProvider.value 에 등록
    return BlocProvider.value(
      value: BlocProvider.of<CartListBloc>(context)..add(CartListInitialized()),
      child: const CartListView(),
    );
  }
}

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: SvgIconButton(
            icon: AppIcons.close,
            color: colorScheme.contentPrimary,
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
          ),
        ),
        title: Text(
          '장바구니',
          style: textTheme.titleMedium.semiBold
              ?.copyWith(color: colorScheme.contentPrimary),
        ),

        ///전체 선택 부분 스크롤 시 고정 (appBar bottom)
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorScheme.outline)),
            ),
            child: BlocBuilder<CartListBloc, CartListState>(
              builder: (context, state) {
                final bool isSelectedAll =
                    state.selectedProduct.length == state.cartList.length &&
                        state.cartList.isNotEmpty;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SvgIconButton(
                        icon: (isSelectedAll)
                            ? AppIcons.checkMarkCircleFill
                            : AppIcons.checkMarkCircle,
                        color: (isSelectedAll)
                            ? colorScheme.primary
                            : colorScheme.contentFourth,
                        onPressed: () => context
                            .read<CartListBloc>()
                            .add(CartListSelectedAll()),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '전체 선택 (${state.selectedProduct.length}/${state.cartList.length})',
                        style: textTheme.titleSmall
                            ?.copyWith(color: colorScheme.contentPrimary),
                      ),
                    ]),
                    GestureDetector(
                      child: Text(
                        '선택 삭제',
                        style: textTheme.titleSmall.semiBold
                            ?.copyWith(color: colorScheme.contentSecondary),
                      ),
                      onTap: () => context.read<CartListBloc>().add(
                          CartListDeleted(productIds: state.selectedProduct)),
                    ),
                  ],
                );
              },
            ),
          ),
          preferredSize: Size.fromHeight(48),
        ),
        backgroundColor: colorScheme.background,
        centerTitle: true,
      ),
      body: BlocBuilder<CartListBloc, CartListState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
            case Status.error:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return ListView(
                children: [
                  Divider(
                    height: 8,
                    thickness: 8,
                    color: colorScheme.surface,
                  ),
                  Column(
                    children: List.generate(
                      state.cartList.length,
                      (index) => CartProductCard(
                        cart: state.cartList[index],
                      ),
                    ),
                  ),
                  CartTotalPrice(isEmpty: state.cartList.isEmpty),
                ],
              );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: BlocBuilder<CartListBloc, CartListState>(
            builder: (context, state) {
              /// fold 전체를 순환하면서 리스트의 값을 바꿈
              List<Cart> selectedCartList = state.cartList.fold(
                [],
                (previousValue, cart) {
                  if (state.selectedProduct.contains(cart.prodcut.productId)) {
                    previousValue.add(cart);
                  }

                  return previousValue;
                },
              );

              return state.status.isSuccess
                  ? PaymentButton(
                      selectedCartList: selectedCartList,
                      totalPrice: state.totalPrice,
                    )
                  : SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
