part of 'recipe_bloc.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}


final class FetchRecipeSuccessState extends RecipeState{
  final dynamic data;
  final String topic;
  FetchRecipeSuccessState({required this.data , required this.topic});
}

final class FetchRecipeFailedState extends RecipeState{} 