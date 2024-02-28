import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/snack_bar/common_snack_bar.dart';
import '../../../../pages/cart_list/bloc/cart_list/cart_list_bloc.dart';
import 'widget/add_cart_btn.dart';
import 'widget/cart_benefit.dart';
import 'widget/cart_price_info.dart';
import 'widget/cart_product_info.dart';

Future<bool?> CartBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        ///BlocListener : 상태에 따른 widget 관리 x, 1번 호출 목적
        child: BlocListener<CartListBloc, CartListState>(
          listener: (_, state) {

            //이미 존재하는 재품일때 스낵바
            if (state.status.isError) {
              CommonSnackBar.errorSnackBar(context, error: state.error);
            }

            //성공시 스낵바 -> main_screen
            if (context.canPop()) {
              context.pop(!state.status.isError);
            }

          },
          listenWhen: (prev, cur) => prev.status != cur.status && !cur.status.isLoading,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CartProductInfo(),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                CartPriceInfo(),
                CartBenefit(),
                SizedBox(height: 24),
                AddCartBtn(),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      );
    },
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(12.0),
      ),
    ),
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
  );
}
