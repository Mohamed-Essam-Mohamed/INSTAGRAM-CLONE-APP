part of 'profile_view_model_cubit.dart';

@immutable
abstract class ProfileViewModelState {}

class ProfileViewModelInitial extends ProfileViewModelState {}

class ProfileViewModelSuccess extends ProfileViewModelState {}

class ProfileViewModelError extends ProfileViewModelState {
  final String message;
  ProfileViewModelError({required this.message});
}

class ProfileViewModelLoading extends ProfileViewModelState {}
