import 'package:exam_3/services/restaurant_http_service.dart';
import 'package:flutter/material.dart';
import 'package:exam_3/models/restaurant_models.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantFutureBuilder extends StatelessWidget {
  const RestaurantFutureBuilder({Key? key}) : super(key: key);

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
          final restaurants = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: restaurants.map<Widget>((restaurant) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigate to the details screen when the container is tapped
                          Navigator.pushNamed(context, '/details',
                              arguments: restaurant);
                        },
                        child: Container(
                          height: 100.h,
                          width: 200.w,
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
                                fontSize: 15.dm,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 60),
                            Text(
                              "⭐️${restaurant.yulduz}",
                              style: TextStyle(
                                fontSize: 13.dm,
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
