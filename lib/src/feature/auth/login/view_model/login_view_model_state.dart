part of 'login_view_model_cubit.dart';

@immutable
abstract class LoginViewModelState {}

class LoginViewModelInitial extends LoginViewModelState {}

class LoginViewModelLoading extends LoginViewModelState {}

class LoginViewModelSuccess extends LoginViewModelState {}

class LoginViewModelError extends LoginViewModelState {
  final String errorMessage;

  LoginViewModelError({required this.errorMessage});
}
