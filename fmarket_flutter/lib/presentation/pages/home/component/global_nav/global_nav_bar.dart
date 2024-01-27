import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../domain/model/display/menu.model.dart';
import '../../bloc/menu_bloc/menu_bloc.dart';

class GlobalNavBar extends StatelessWidget {
  const GlobalNavBar(this.menus, {super.key});

  final List<Menu> menus;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textScheme = Theme.of(context).textTheme;

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Stack(
          children: [
            TabBar(
              tabs: List.generate(
                menus.length,
                (index) => Tab(text: menus[index].title),
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: colorScheme.primary, width: 2),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: textScheme.titleSmall.semiBold,
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              unselectedLabelColor: colorScheme.contentSecondary,
              unselectedLabelStyle: textScheme.titleSmall,
            ),
            if (state.status == Status.loading)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.2),
                  child: Center(
                    child: Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
