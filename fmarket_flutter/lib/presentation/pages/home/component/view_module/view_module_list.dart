import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/extensions.dart';
import '../../bloc/view_module_bloc/view_module_bloc.dart';

//stful 이유 : 스크롤 컨트롤러 사용하기 위해
class ViewModuleList extends StatefulWidget {
  const ViewModuleList({super.key});

  @override
  State<ViewModuleList> createState() => _ViewModuleListState();
}

class _ViewModuleListState extends State<ViewModuleList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isEnd) {
      context.read<ViewModuleBloc>().add(ViewModuleFetched());
    }
  }

  bool get _isEnd {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final curScroll = scrollController.offset;

    return curScroll >= maxScroll * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewModuleBloc, ViewModuleState>(builder: (_, state) {
      return (state.status.isInitial || state.viewModules.isEmpty)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              controller: scrollController,
              children: [
                ...state.viewModules,
                if (state.status.isLoading) LoadingWidget(),
              ],
            );
      // switch (state.status) {
      //   case Status.initial:
      //   case Status.loading:
      //     return const Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   case Status.success:
      //     return Column(
      //       children: [
      //         Container(
      //           color: Colors.deepOrangeAccent,
      //           height: 50,
      //           child: Center(child: Text("${state.tabId} 99")),
      //         ),
      //         Expanded(
      //           child: ListView.separated(
      //             itemBuilder: (_, index) {
      //               return state.viewModules[index];
      //             },
      //             separatorBuilder: (_, index) => Divider(
      //               thickness: 4,
      //             ),
      //             itemCount: state.viewModules.length,
      //           ),
      //         ),
      //       ],
      //     );
      //   case Status.error:
      //     return const Center();
      // }
    });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Center(
        child:
            SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
      ),
    );
  }
}
