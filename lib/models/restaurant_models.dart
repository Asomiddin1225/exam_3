class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final double yulduz;
  final List<Map<String, dynamic>> foods;

  Restaurant(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.yulduz,
      required this.foods});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      name: json['name'],
      imageUrl: json['imageUrl'],
      yulduz:json['yulduz'],
      foods: [json['foods']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'yulduz':yulduz,
      'foods': foods,
    };
  }
}
