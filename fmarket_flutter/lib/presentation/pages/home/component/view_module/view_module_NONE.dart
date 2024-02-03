import 'package:flutter/material.dart';

import 'view_module_factory/view_module_widget.dart';

class ViewModuleNONE extends StatelessWidget with ViewModuleWidget {
  const ViewModuleNONE({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      height: 200,
      child: Center(child: Text('viewModuleB'),),
    );
  }
}
