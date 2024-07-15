part of 'home_view_model_cubit.dart';

@immutable
abstract class HomeViewModelState {}

class HomeViewModelInitial extends HomeViewModelState {}

class HomeViewModelLoading extends HomeViewModelState {}

class HomeViewModelSuccess extends HomeViewModelState {}

class HomeViewModelError extends HomeViewModelState {
  final String message;
  HomeViewModelError({required this.message});
}
