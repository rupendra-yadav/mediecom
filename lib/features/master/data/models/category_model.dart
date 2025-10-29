import 'package:mediecom/features/master/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.m1Code,
    required super.m1Name,
    required super.m1Bt,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      m1Code: json['M1_CODE'] ?? '',
      m1Name: json['M1_NAME'] ?? '',
      m1Bt: json['M1_BT'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'M1_CODE': m1Code, 'M1_NAME': m1Name, 'M1_BT': m1Bt};
  }
}
