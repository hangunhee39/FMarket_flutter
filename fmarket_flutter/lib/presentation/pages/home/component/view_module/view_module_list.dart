
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant.dart';
import '../../bloc/view_module_bloc/view_module_bloc.dart';

class ViewModuleList extends StatelessWidget {
  const ViewModuleList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModuleBloc, ViewModuleState>(builder: (_, state) {
      switch (state.status) {
        case Status.initial:
        case Status.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case Status.success:
          return Column(
            children: [
              Container(
                color: Colors.deepOrangeAccent,
                height: 50,
                child: Center(child: Text("${state.tabId} 99")),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (_, index) {
                    return state.viewModules[index];
                  },
                  separatorBuilder: (_, index) => Divider(
                    thickness: 4,
                  ),
                  itemCount: state.viewModules.length,
                ),
              ),
            ],
          );
        case Status.error:
          return const Center();
      }
    });
  }
}
