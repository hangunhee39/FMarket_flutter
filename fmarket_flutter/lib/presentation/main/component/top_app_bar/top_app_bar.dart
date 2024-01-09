import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/bottom_nav_cubit.dart';
import 'default_app_bar.dart';
import 'home_app_bar.dart';

//AppBar padding 주는법 : PreferredSize (앱바를 받을 수 있는 widget) -> Container (배경색) -> Padding -> AppBar
class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNav>(builder: (_,state){
      switch(state){
        case BottomNav.home:
          return const HomeAppbar();
        case BottomNav.category:
        case BottomNav.search:
        case BottomNav.user:
          return  DefaultAppBar(state);
      }
    });
  }

  @override
  Size get preferredSize => Size.fromHeight(44);
}
