import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'brand')
  String? brand;

  @JsonKey(name: 'category')
  String? category;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'offer')
  bool? offer;

  @JsonKey(name: 'price')
  double? price;

  Product({
    this.id,
    this.brand,
    this.category,
    this.description,
    this.image,
    this.name,
    this.offer,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
