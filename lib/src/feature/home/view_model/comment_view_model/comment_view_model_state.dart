part of 'comment_view_model_cubit.dart';

@immutable
abstract class CommentViewModelState {}

class CommentViewModelInitial extends CommentViewModelState {}

class CommentViewModelLoading extends CommentViewModelState {}

class CommentViewModelSuccess extends CommentViewModelState {}

class CommentViewModelError extends CommentViewModelState {
  final String message;
  CommentViewModelError({required this.message});
}
