import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/constant/app_icons.dart';
import '../../../../core/theme/custom/custom_font_weight.dart';
import '../../cubit/mall_type_cubit.dart';
import 'widgets/svg_icon_button.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          color: state.theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: AppBar(
              leading: SvgIconButton(
                icon: AppIcons.mainLogo,
                color: state.theme.logoColor,
                padding: 8,
              ),
              title: AnimatedContainer(
                decoration: BoxDecoration(
                  color: (state.isMarket)
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: SizedBox(
                  height: 28,
                  child: DefaultTabController(
                    length: MallType.values.length,
                    initialIndex: state.index,
                    child: TabBar(
                      tabs: List.generate(
                        MallType.values.length,
                        (index) => Tab(text: MallType.values[index].toName),
                      ),
                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: state.theme.indicatorColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: state.theme.labelColor,
                      labelStyle: Theme.of(context).textTheme.labelLarge.bold,
                      labelPadding: EdgeInsets.symmetric(horizontal: 12),
                      unselectedLabelColor: state.theme.unselectedLabelColor,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.labelMedium,
                      onTap: (index) =>
                          context.read<MallTypeCubit>().changeIndex(index),
                      splashBorderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                duration: Duration(milliseconds: 400),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    AppIcons.location,
                    colorFilter: ColorFilter.mode(
                      (state.isMarket)
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SvgIconButton(
                  icon: AppIcons.cart,
                  color: (state.isMarket)
                      ? Theme.of(context).colorScheme.background
                      : Theme.of(context).colorScheme.primary,
                  padding: 4,
                ),
              ],
              backgroundColor: Colors.transparent,
              centerTitle: true,
              leadingWidth: 86,
            ),
          ),
          duration: const Duration(milliseconds: 400),
        );
      },
    );
  }

//테마 리팩토링
// @override
// Widget build(BuildContext context) {
//   return BlocBuilder<MallTypeCubit, MallType>(
//     builder: (_, state) {
//       return AnimatedContainer(
//         color: (state.isMarket)
//             ? Theme.of(context).colorScheme.primary
//             : Theme.of(context).colorScheme.background,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//           child: AppBar(
//             leading: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SvgPicture.asset(
//                 AppIcons.mainLogo,
//                 colorFilter: ColorFilter.mode(
//                   (state.isMarket)
//                       ? Theme.of(context).colorScheme.onPrimary
//                       : Theme.of(context).colorScheme.primary,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//             title: AnimatedContainer(
//               decoration: BoxDecoration(
//                 color: (state.isMarket)
//                     ? Theme.of(context).colorScheme.primaryContainer
//                     : Theme.of(context).colorScheme.surface,
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//               ),
//               child: SizedBox(
//                 height: 28,
//                 child: DefaultTabController(
//                   length: MallType.values.length,
//                   initialIndex: state.index,
//                   child: TabBar(
//                     tabs: List.generate(
//                       MallType.values.length,
//                       (index) => Tab(text: MallType.values[index].toName),
//                     ),
//                     isScrollable: true,
//                     indicator: BoxDecoration(
//                       color: (state.isMarket)
//                           ? Theme.of(context).colorScheme.background
//                           : Theme.of(context).colorScheme.primary,
//                       borderRadius: BorderRadius.all(Radius.circular(30)),
//                     ),
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     dividerColor: Colors.transparent,
//                     labelColor: state.isMarket
//                         ? Theme.of(context).colorScheme.primary
//                         : Theme.of(context).colorScheme.background,
//                     labelStyle: Theme.of(context).textTheme.labelLarge.bold,
//                     labelPadding: EdgeInsets.symmetric(horizontal: 12),
//                     unselectedLabelColor: (state.isMarket)
//                         ? Theme.of(context).colorScheme.background
//                         : Theme.of(context).colorScheme.contentPrimary,
//                     unselectedLabelStyle:
//                         Theme.of(context).textTheme.labelMedium,
//                     onTap: (index) =>
//                         context.read<MallTypeCubit>().changeIndex(index),
//                     splashBorderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                 ),
//               ),
//               duration: Duration(milliseconds: 400),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: SvgPicture.asset(
//                   AppIcons.location,
//                   colorFilter: ColorFilter.mode(
//                     (state.isMarket)
//                         ? Theme.of(context).colorScheme.background
//                         : Theme.of(context).colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: SvgPicture.asset(
//                   AppIcons.cart,
//                   colorFilter: ColorFilter.mode(
//                     (state.isMarket)
//                         ? Theme.of(context).colorScheme.background
//                         : Theme.of(context).colorScheme.primary,
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ],
//             backgroundColor: Colors.transparent,
//             centerTitle: true,
//             leadingWidth: 86,
//           ),
//         ),
//         duration: const Duration(milliseconds: 400),
//       );
//     },
//   );
// }
}
