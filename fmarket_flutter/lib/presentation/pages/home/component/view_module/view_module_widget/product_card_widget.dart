import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/theme/constant/app_icons.dart';
import '../../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../domain/model/display/product_info/product_info.model.dart';
import 'add_cart_button.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductInfo productInfo;
  final double imageAspect;
  final TextStyle? titleStyle;
  final TextStyle? priceStyle;
  final TextStyle? originalPricesStyle;
  final TextStyle? reviewStyle;
  final bool needShowReviewCount;

  const ProductCardWidget({
    super.key,
    required this.productInfo,
    required this.imageAspect,
    this.titleStyle,
    this.priceStyle,
    this.originalPricesStyle,
    this.reviewStyle,
    required this.needShowReviewCount,
  });

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
          style: titleStyle?.titleCopyWith(),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        Row(
          children: [
            Text(
              '${productInfo.discrountRate}%',
              style: priceStyle?.discountRateCopyWith(),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              productInfo.price.toWon(),
              style: priceStyle?.priceCopyWith(),
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          productInfo.originalPrice.toWon(),
          style: originalPricesStyle?.originalPriceCopyWith(),
        ),
        if (needShowReviewCount)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Row(
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
                Text(
                  '후기 ${productInfo.reviewCount.toReview()}',
                  style: reviewStyle?.reviewCountCopyWith(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

extension TextStyleEx on TextStyle {
  TextStyle? titleCopyWith() {
    return copyWith(
      color: CustomTheme.colorScheme.contentPrimary,
    ).regular;
  }

  TextStyle? discountRateCopyWith() {
    return copyWith(
      color: CustomTheme.colorScheme.secondary,
    ).bold;
  }

  TextStyle? priceCopyWith() {
    return copyWith(
      color: CustomTheme.colorScheme.contentPrimary,
    ).bold;
  }

  TextStyle? originalPriceCopyWith() {
    return copyWith(
      color: CustomTheme.colorScheme.contentFourth,
      decoration: TextDecoration.lineThrough,
    ).regular;
  }

  TextStyle? reviewCountCopyWith() {
    return copyWith(
      color: CustomTheme.colorScheme.contentTertiary,
    ).regular;
  }
}
