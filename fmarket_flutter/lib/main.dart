import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/theme_data.dart';
import 'data/entity/display/cart/cart.entity.dart';
import 'data/entity/display/product_info/product_info.entity.dart';
import 'dependency_injection.dart';
import 'presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'presentation/routes/routes.dart';

void main() async {
  //하이브 초기화
  await Hive.initFlutter();
  //hive entity 등록
  Hive.registerAdapter(ProductInfoEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());

  //bloc 등록 (의존성)
  configureDependencies();
  //final menus = await DisplayUsecase(DisplayRepositoryImpl(DisplayMockApi())).execute(usecase: GetMenuUsecase(MallType.market));
  //get_it(의존성) 사용
  //final data = await locator<DisPlayApi>().getMenuModuleByTabId(10001,0);
  // print(data);
  //
  // final menus = await locator<DisplayUsecase>()
  //     .execute(usecase: GetMenuUsecase(mallType:MallType.market));
  // print(menus);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //bloc 등록 (의존성)
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartBloc>()..add(CartInitialized())),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: CustomThemeData.themeData,
      ),
    );
  }
}
