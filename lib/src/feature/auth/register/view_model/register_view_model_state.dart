part of 'register_view_model_cubit.dart';

@immutable
abstract class RegisterViewModelState {}

class RegisterViewModelInitial extends RegisterViewModelState {}

class RegisterViewModelLoading extends RegisterViewModelState {}

class RegisterViewModelSuccess extends RegisterViewModelState {}

class RegisterViewModelError extends RegisterViewModelState {
  final String errorMessage;
  RegisterViewModelError({required this.errorMessage});
}
