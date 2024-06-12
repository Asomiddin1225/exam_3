import 'package:exam_3/services/categories_http_services.dart';

import 'package:exam_3/widgets/restaran_column.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Recommended extends StatefulWidget {
  const Recommended({super.key});

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final CategoriesHttpServices categoriesHttpServices =
        CategoriesHttpServices();

    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: IconButton(
        //       onPressed: () {}, icon: const Icon(Icons.menu, size: 30)),
        // ),
        centerTitle: true,
        title: Text(
          "Recommended",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.dm,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: categoriesHttpServices.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map<Widget>((category) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // Navigator.pushNamed(context, '/home');
                            },
                            child: Chip(label: Text(category["name"])),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return Center(child: Text('No categories found'));
                }
              },
            ),

            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Row(
            //     children: [
            //       const Text(
            //         'Recommended',
            //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            //       ),
            //       Spacer(),
            //       TextButton(
            //         onPressed: () {
            //           Navigator.pushReplacement(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => RecommendedV2(),
            //             ),
            //           );
            //         },
            //         child: const Text(
            //           'View all',
            //           style: TextStyle(fontSize: 24, color: Colors.grey),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            RestaurantFutureBuilder2(searchQuery: _searchQuery)
          ],
        ),
      ),
      // bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
