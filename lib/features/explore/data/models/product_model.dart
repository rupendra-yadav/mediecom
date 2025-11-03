import 'package:mediecom/features/explore/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.M1_CODE,
    super.M1_NAME,
    super.M1_LST,
    super.M1_CST,
    super.M1_IT,
    super.M1_VAL,
    super.M1_AMT1,
    super.M1_AMT2,
    super.M1_DT3,
    super.M1_DT4,
    super.M1_BT,
    super.M1_ADD1,
    super.M1_ADD2,
    super.M1_DT1,
    super.M1_GROUP,
    super.M1_PRINT,
    super.category_name,
    super.subcategory_name,
    super.image = const [],
    super.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      M1_CODE: json['M1_CODE'],
      M1_NAME: json['M1_NAME'],
      M1_LST: json['M1_LST'],
      M1_CST: json['M1_CST'],
      M1_IT: json['M1_IT'],
      M1_VAL: json['M1_VAL'],
      M1_AMT1: json['M1_AMT1'],
      M1_AMT2: json['M1_AMT2'],
      M1_DT3: json['M1_DT3'],
      M1_DT4: json['M1_DT4'],
      M1_BT: json['M1_BT'],
      M1_ADD1: json['M1_ADD1'],
      M1_ADD2: json['M1_ADD2'],
      M1_DT1: json['M1_DT1'],
      M1_GROUP: json['M1_GROUP'],
      M1_PRINT: json['M1_PRINT'],
      category_name: json['category_name'],
      subcategory_name: json['subcategory_name'],
      image: json['image'] != null ? List<String>.from(json['image']) : [],
    );
  }
}
