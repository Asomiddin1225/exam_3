



import 'package:exam_3/services/categories_http_services.dart';

import 'package:exam_3/widgets/bottom_navigation.dart';
import 'package:exam_3/widgets/restaran_column.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageV2 extends StatefulWidget {
  const HomePageV2({super.key});

  @override
  State<HomePageV2> createState() => _HomePageV2State();
}

class _HomePageV2State extends State<HomePageV2> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final CategoriesHttpServices categoriesHttpServices = CategoriesHttpServices();
    

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, size: 30),
          ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search food',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
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
                    'Recommended',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View all',
                      style: TextStyle(fontSize: 24, color: Color(0xFFFFC34A)),
                    ),
                  ),
                ],
              ),
            ),
            RestaurantFutureBuilder2(searchQuery: _searchQuery),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
