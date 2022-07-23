import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/infinite_list_bloc.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({Key? key}) : super(key: key);

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final controller = ScrollController();
  late InfiniteListBloc _infiniteListBloc;

  @override
  void initState() {
    _infiniteListBloc = InfiniteListBloc();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        _infiniteListBloc.add(LoadMore());
      }
    });
    _infiniteListBloc.add(LoadMore());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scroll View'),
      ),
      body: BlocBuilder<InfiniteListBloc, InfiniteListState>(
        bloc: _infiniteListBloc,
        builder: (context, state) {
          return ListView.builder(
              controller: controller,
              itemBuilder: (context, index) {
                if (index < state.listItem.length) {
                  return ListTile(
                    title: Text('Item ${state.listItem[index].id}'),
                  );
                } else {
                  return Center(
                    child: state.hasMore
                        ? const CircularProgressIndicator()
                        : const Text('No more data'),
                  );
                }
              },
              itemCount: state.listItem.length + 1);
        },
      ),
    );
  }
}
