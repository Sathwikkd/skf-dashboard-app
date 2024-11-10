part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class FetchRecipeEvent extends RecipeEvent{
  final String drierId;
  FetchRecipeEvent({required this.drierId});
}


class StopRecipeFetchEvent extends RecipeEvent{}
