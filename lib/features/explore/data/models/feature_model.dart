import 'package:mediecom/features/explore/data/models/product_model.dart';
import 'package:mediecom/features/explore/domain/entities/featured_entity..dart';
import 'package:mediecom/features/master/data/models/category_model.dart';
import 'package:mediecom/features/master/domain/entities/category_entity.dart';

class FeaturesModel extends FeaturesEntity {
  const FeaturesModel({
    required super.name,
    required super.lname,
    super.categories,
    super.products,
  });

  factory FeaturesModel.fromJson(Map<String, dynamic> json) {
    final type = json['M1_LNAME']?.toString() ?? '';

    return FeaturesModel(
      name: json['M1_NAME']?.toString() ?? '',
      lname: json['M1_LNAME']?.toString() ?? '',

      // Map categories if type is 'ProductCategory'
      categories: type == 'ProductCategory'
          ? (json['list'] as List<dynamic>? ?? [])
                .map((e) => CategoryModel.fromJson(e))
                .toList()
          : null,

      // Map products if type is 'Product'
      products: type == 'Product'
          ? (json['list'] as List<dynamic>? ?? [])
                .map((e) => ProductModel.fromJson(e))
                .toList()
          : null,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'M1_NAME': name,
  //     'M1_LNAME': lname,
  //     if (categories != null)
  //       'list': categories!.map((e) => e.toJson()).toList(),
  //     if (products != null)
  //       'list': products!.map((e) => e.toJson()).toList(),
  //   };
  // }
}
