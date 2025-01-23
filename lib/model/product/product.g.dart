// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      offer: json['offer'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'category': instance.category,
      'description': instance.description,
      'image': instance.image,
      'name': instance.name,
      'offer': instance.offer,
      'price': instance.price,
    };
