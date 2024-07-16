part of 'search_view_model_cubit.dart';

@immutable
abstract class SearchViewModelState {}

class SearchViewModelInitial extends SearchViewModelState {}

class SearchViewModelLoading extends SearchViewModelState {}

class SearchViewModelSuccess extends SearchViewModelState {}

class SearchViewModelError extends SearchViewModelState {
  final String message;
  SearchViewModelError({required this.message});
}

class SearchViewModelEmpty extends SearchViewModelState {}

class SearchViewModelGetAllPost extends SearchViewModelState {}
