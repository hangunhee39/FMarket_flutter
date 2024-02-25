import 'package:flutter/material.dart';

import '../../../../../domain/model/display/display.model.dart';
import 'view_module_factory/view_module_widget.dart';
import 'view_module_widget/product_card_widget.dart';

class ScrollViewModule extends StatelessWidget  with ViewModuleWidget{
  final ViewModule info;
  const ScrollViewModule({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return ProductCardWidget(
      productInfo: info.products[0],
      imageAspect: 150/ 195,
    );
  }
}
