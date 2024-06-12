import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exam_3/models/restaurant_models.dart';

class RestaurantService {
  static const String url =
      'https://exam-3-6cd7d-default-rtdb.firebaseio.com/restaurants.json';

  static Future<List<Restaurant>> fetchRestaurants() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Restaurant> restaurants = [];

      data.forEach((key, value) {
        Restaurant restaurant = Restaurant.fromJson(value);
        restaurants.add(restaurant);
      });

      return restaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
