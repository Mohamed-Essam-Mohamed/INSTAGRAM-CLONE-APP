part of 'selected_image_view_model_cubit.dart';

@immutable
abstract class SelectedImageViewModelState {}

class SelectedImageViewModelInitial extends SelectedImageViewModelState {}

class SelectedImageViewModelLoading extends SelectedImageViewModelState {}

class SelectedImageViewModelSuccess extends SelectedImageViewModelState {
  // final Uint8List image;
  // SelectedImageViewModelSuccess({required this.image});
}

class SelectedImageViewModelError extends SelectedImageViewModelState {
  final String errorMessage;
  SelectedImageViewModelError({required this.errorMessage});
}
