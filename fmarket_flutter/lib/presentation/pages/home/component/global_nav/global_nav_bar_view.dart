import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../domain/model/display/menu.model.dart';
import '../../../../main/cubit/mall_type_cubit.dart';
import '../../bloc/menu_bloc/menu_bloc.dart';
import '../../bloc/view_module_bloc/view_module_bloc.dart';
import '../view_module/view_module_list.dart';

class GlobalNavBarView extends StatelessWidget {
  const GlobalNavBarView(this.mallType, this.menus, {super.key});

  final List<Menu> menus;
  final MallType mallType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.initial:
          case Status.loading:
            return const Expanded(child: Center(child: CircularProgressIndicator()));
          case Status.success:
            return Expanded(
              child: TabBarView(
                children: List.generate(
                  menus.length,
                      (index) {
                    final tabId = menus[index].tabId;

                    return BlocProvider(
                      // add : 이벤트 등
                      create: (_) =>
                      getIt<ViewModuleBloc>()
                        ..add(ViewModuleInitialized(tabId: menus[index].tabId)),
                      child: ViewModuleList(
                        tabId: tabId,
                      ),
                    );
                  },
                ),
              ),
            );
          case Status.error:
            return const Center(child: Text('menu_module_bloc error'));
        }
      },
    );
  }
}
