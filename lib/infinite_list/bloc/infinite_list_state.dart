part of 'infinite_list_bloc.dart';

@immutable
class InfiniteListState extends Equatable {
  final bool hasMore;
  final List<InfiniteListModel> listItem;
  final int page;
  final bool isLoading;

  const InfiniteListState(
      {this.hasMore = true,
      this.listItem = const [],
      this.page = 1,
      this.isLoading = false});

  InfiniteListState copyWith({
    bool? hasMore,
    List<InfiniteListModel>? listItem,
    int? page,
    bool? isLoading,
  }) {
    return InfiniteListState(
      hasMore: hasMore ?? this.hasMore,
      listItem: listItem ?? this.listItem,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [hasMore, listItem, page, isLoading];
}
