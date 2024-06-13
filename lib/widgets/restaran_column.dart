import 'package:exam_3/models/restaurant_models.dart';

import 'package:flutter/material.dart';
import 'package:exam_3/services/restaurant_http_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantFutureBuilder2 extends StatelessWidget {
  final String searchQuery;

  const RestaurantFutureBuilder2({required this.searchQuery, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: RestaurantService.fetchRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final restaurants = snapshot.data!
              .where((restaurant) => restaurant.name
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: restaurants.map<Widget>((restaurant) {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                       InkWell(
                        onTap: ()  {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FoodScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          height: 150.h,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              restaurant.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 180.h),
                            Text(
                              "⭐️${restaurant.yulduz}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return Center(child: Text('No restaurants found'));
        }
      },
    );
  }
}

