import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final List<dynamic>? size;
  final String? description;
  final String? gender;
  final String? collectionSeason;
  final String? image;
  final String? creator;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const Product({
    this.id,
    this.name,
    this.price,
    this.size,
    this.description,
    this.gender,
    this.collectionSeason,
    this.image,
    this.creator,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        size: json['size'] as List<dynamic>?,
        description: json['description'] as String?,
        gender: json['gender'] as String?,
        collectionSeason: json['collectionSeason'] as String?,
        image:  'http://chicwardrobe-znz5.onrender.com/${json['image'] as String?}',
        creator: json['creator'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'price': price,
        'size': size,
        'description': description,
        'gender': gender,
        'collectionSeason': collectionSeason,
        'image': image,
        'creator': creator,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      size,
      description,
      gender,
      collectionSeason,
      image,
      creator,
      createdAt,
      updatedAt,
      v,
    ];
  }
}
