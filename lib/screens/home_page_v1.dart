import 'package:exam_3/screens/recommended_page.dart';
import 'package:exam_3/services/categories_http_services.dart';

import 'package:exam_3/widgets/bottom_navigation.dart';
import 'package:exam_3/screens/home_page_v2.dart';
import 'package:exam_3/widgets/restaran_column.dart';
import 'package:exam_3/widgets/restaran_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final CategoriesHttpServices categoriesHttpServices =
        CategoriesHttpServices();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: IconButton(
              onPressed: () {}, icon: const Icon(Icons.menu, size: 30)),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Current location",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13.dm,
              ),
            ),
            Text(
              "123 Dream Avenue, NYC",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.dm,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageV2(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.search,
                  size: 30,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFFE9BE),
                ),
                child: Image.asset("assets/reclama.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text(
                    'Top categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageV2(),
                        ),
                      );
                    },
                    child: const Text(
                      'View all',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text(
                    'Popular',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePageV2(),
                        ),
                      );
                    },
                    child: const Text(
                      'View all',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            RestaurantFutureBuilder(),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Text(
                    'Recommended',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Recommended(),
                        ),
                      );
                    },
                    child: const Text(
                      'View all',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            RestaurantFutureBuilder2(searchQuery: _searchQuery)
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
