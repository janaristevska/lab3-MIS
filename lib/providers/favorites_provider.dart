import 'package:flutter/material.dart';
import '../models/meal.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Meal> _favorites = [];

  List<Meal> get favorites => _favorites;

  bool isFavorite(String mealId) {
    return _favorites.any((meal) => meal.idMeal == mealId);
  }

  void toggleFavorite(Meal meal) {
    final exists = isFavorite(meal.idMeal);

    if (exists) {
      _favorites.removeWhere((m) => m.idMeal == meal.idMeal);
    } else {
      _favorites.add(meal);
    }

    notifyListeners();
  }
}
