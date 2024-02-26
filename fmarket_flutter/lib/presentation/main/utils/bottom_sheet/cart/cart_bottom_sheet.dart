import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cart_bloc/cart_bloc.dart';
import 'widget/add_cart_btn.dart';
import 'widget/cart_benefit.dart';
import 'widget/cart_price_info.dart';
import 'widget/cart_product_info.dart';

Future<bool?> CartBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<CartBloc, CartState>(
            builder: (_, state) {
              return Column(
                children: [
                 CartProductInfo(productInfo: state.productInfo),
                  const Divider(height: 1, thickness: 1,),
                  CartPriceInfo(),
                  CartBenefit(),
                  SizedBox(height: 24),
                  AddCartBtn(),
                  SizedBox(height: 12),
                ],
              );
            },

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
