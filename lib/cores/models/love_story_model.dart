class LoveStoryModel {
  late final String id;
  late final String description;
  late final String image;
  late final String date;

  LoveStoryModel({
    required this.id,
    required this.description,
    this.image = '',
    required this.date,
  });

  LoveStoryModel.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? '';
    image = json['image'] ?? '';
    id = json['id'] ?? '';
    date = json['date'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['image'] = image;
    data['id'] = id;
    data['date'] = date;
    return data;
  }

  LoveStoryModel copyWith({
    String? id,
    String? description,
    String? image,
    String? date,
  }) {
    return LoveStoryModel(
      id: id ?? this.id,
      description: description ?? this.description,
      image: image ?? this.image,
      date: date ?? this.date,
    );
  }
}
