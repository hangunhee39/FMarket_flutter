import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/snack_bar/common_snack_bar.dart';
import 'utils/bottom_sheet/cart/cart_bottom_sheet.dart';

import '../pages/category/category_page.dart';
import '../pages/home/home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/user/user_page.dart';
import 'bloc/cart_bloc/cart_bloc.dart';
import 'component/top_app_bar/top_app_bar.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'cubit/mall_type_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //하나면 BlocProvider 로 사용
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => MallTypeCubit()),
      ],
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bottom Nav index 상태 관리 (Bloc) - appBar,body,bottomNav
      appBar: TopAppBar(),
      ///전역적으로 bottomSheet 사용
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) async {
          final bottomSheet = await CartBottomSheet(context)
              .whenComplete(() => context.read<CartBloc>().add(CartClosed()));
          final isSuccess = bottomSheet ?? false;

          if (isSuccess) {
            CommonSnackBar.addCartSnackBar(context);
          }
        },
        //카드가 닫힘에서 열림으로 바뀔때만
        listenWhen: (prev, cur) => prev.status.isClose && cur.status.isOpen,
        child: BlocBuilder<BottomNavCubit, BottomNav>(
          builder: (_, state) {
            switch (state) {
              case BottomNav.home:
                return const HomePage();
              case BottomNav.category:
                return const CategoryPage();
              case BottomNav.search:
                return const SearchPage();
              case BottomNav.user:
                return const UserPage();
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNav>(
        builder: (_, state) {
          return BottomNavigationBar(
            items: List.generate(
              BottomNav.values.length,
              (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(BottomNav.values[index].icon),
                label: BottomNav.values[index].toName,
                activeIcon:
                    SvgPicture.asset(BottomNav.values[index].activeIcon),
              ),
            ),
            onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          );
        },
      ),
    );
  }
}
