import 'package:flutter/material.dart';
import 'package:fmarket_flutter/service_locator.dart';

import 'core/theme/theme_data.dart';
import 'data/data_source/remote/display.api.dart';
import 'dependency_injection.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'domain/usecase/display/menu/get_menus.usecase.dart';
import 'presentation/main/cubit/mall_type_cubit.dart';
import 'presentation/routes/routes.dart';

void main()  {
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
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
