import 'package:equatable/equatable.dart';

import 'rating_model.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String? image;
  final RatingModel? rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    this.image,
    this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final id = (json['id'] as num?)?.toInt();
    final title = json['title'] as String?;
    final price = (json['price'] as num?)?.toDouble();
    final description = json['description'] as String?;
    final category = json['category'] as String?;
    final image = json['image'] as String?;
    final ratingJson = json['rating'];

    if (id == null ||
        title == null ||
        price == null ||
        description == null ||
        category == null) {
      throw const FormatException('Invalid product data');
    }

    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: ratingJson is Map<String, dynamic>
          ? RatingModel.fromJson(ratingJson)
          : null,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    price,
    description,
    category,
    image,
    rating,
  ];
}
