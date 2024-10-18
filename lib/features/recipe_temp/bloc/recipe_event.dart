part of 'recipe_bloc.dart';

@immutable
sealed class RecipeEvent {}

class FetchRecipeEvent extends RecipeEvent{}


class StopRecipeFetchEvent extends RecipeEvent{}
