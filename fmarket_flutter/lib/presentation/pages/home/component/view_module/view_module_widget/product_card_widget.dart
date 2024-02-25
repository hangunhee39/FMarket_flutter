import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/theme/constant/app_colors.dart';
import '../../../../../../core/theme/constant/app_icons.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../domain/model/display/display.model.dart';
import '../../../../../../domain/model/display/product_info/product_info.model.dart';
import 'add_cart_button.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductInfo productInfo;
  final double imageAspect;

  const ProductCardWidget(
      {super.key, required this.productInfo, required this.imageAspect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: imageAspect,
              child: Image.network(productInfo.imageUrl, fit: BoxFit.cover),
            ),
            AddCartButton(),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Text(
          productInfo.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Row(
          children: [
            Text('${productInfo.discrountRate}%'),
            SizedBox(
              width: 4,
            ),
            Text(productInfo.price.toWon()),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Text(productInfo.originalPrice.toWon()),
        SizedBox(
          height: 2,
        ),
        Row(
          children: [
            SvgPicture.asset(
              AppIcons.chat,
              width: 13,
              height: 13,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.contentTertiary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text('후기 ${productInfo.reviewCount.toReview()}'),
          ],
        ),
      ],
    );
  }
}
