// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  final String name;
  final int price;
  final int stock;
  final String category;
  final int isBestSeller;
  final XFile image;
  ProductRequestModel({
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.isBestSeller,
    required this.image,
  });

  Map<String, String> toMap() {
    return {
      'name': name,
      'price': price.toString(),
      'stock': stock.toString(),
      'category': category,
      'is_best_seller': isBestSeller.toString(),
      //'image': image.toMap(), DIBUAT TERPISAH
    };
  }

  //TIDAK DIGUNAKAN
  // factory ProductRequestModel.fromMap(Map<String, dynamic> map) {
  //   return ProductRequestModel(
  //     name: map['name'] as String,
  //     price: map['price'] as int,
  //     stock: map['stock'] as int,
  //     category: map['category'] as String,
  //     isBestSeller: map['isBestSeller'] as int,
  //     image: XFile.fromMap(map['image'] as Map<String,dynamic>),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ProductRequestModel.fromJson(String source) => ProductRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
