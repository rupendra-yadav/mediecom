import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String m1Code;
  final String m1Name;
  final String m1Bt;

  CategoryEntity({
    required this.m1Code,
    required this.m1Name,
    required this.m1Bt,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
