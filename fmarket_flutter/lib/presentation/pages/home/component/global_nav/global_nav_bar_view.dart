import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/model/display/menu.model.dart';
import '../../../../../service_locator.dart';
import '../../../../main/cubit/mall_type_cubit.dart';
import '../../bloc/view_module_bloc/view_module_bloc.dart';
import '../view_module/view_module_list.dart';

class GlobalNavBarView extends StatelessWidget {
  const GlobalNavBarView(this.mallType, this.menus, {super.key});

  final List<Menu> menus;
  final MallType mallType;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(
          menus.length,
          (index) => BlocProvider(
            // add : 이벤트 등
            create: (_) => locator<ViewModuleBloc>()
              ..add(ViewModuleInitialized(tabId: menus[index].tabId)),
            child: ViewModuleList(),
          ),
        ),
      ),
    );
  }
}
