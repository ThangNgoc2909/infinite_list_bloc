import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/infinite_list_model.dart';

part 'infinite_list_event.dart';

part 'infinite_list_state.dart';

class InfiniteListBloc extends Bloc<InfiniteListEvent, InfiniteListState> {
  InfiniteListBloc() : super(const InfiniteListState()) {
    on<LoadMore>(_onLoadMore);
  }

  void _onLoadMore(LoadMore event, Emitter<InfiniteListState> emit) async {
    bool onLoad = state.isLoading;
    if (onLoad) return;
    onLoad = true;
    const limit = 25;
    bool hasMore = true;
    int page = state.page;
    final response = await Dio().get(
        'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=${state.page}');
    if (response.statusCode == 200) {
      final List items = response.data;
      List<InfiniteListModel> res =
          items.map((e) => InfiniteListModel.fromJson(e)).toList();
      if (res.length < limit) {
        hasMore = false;
      } else {
        page++;
        onLoad = false;
      }
      emit(state.copyWith(
          listItem: [...state.listItem, ...res],
          hasMore: hasMore,
          page: page,
          isLoading: onLoad));
    }
  }
}
