import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Fetch all categories
  Future<List<Category>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List categoriesJson = data['categories'];
        return categoriesJson.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch meals by category
  Future<List<Meal>> fetchMealsByCategory(String category) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/filter.php?c=$category')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List mealsJson = data['meals'] ?? [];
        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Search meals by name
  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/search.php?s=$query')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List? mealsJson = data['meals'];

        if (mealsJson == null) {
          return [];
        }

        return mealsJson.map((json) => Meal.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search meals');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch meal details by ID
  Future<MealDetail> fetchMealDetail(String mealId) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/lookup.php?i=$mealId')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List mealsJson = data['meals'];
        return MealDetail.fromJson(mealsJson[0]);
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch random meal
  Future<MealDetail> fetchRandomMeal() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List mealsJson = data['meals'];
        return MealDetail.fromJson(mealsJson[0]);
      } else {
        throw Exception('Failed to load random meal');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
