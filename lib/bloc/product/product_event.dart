part of 'product_bloc.dart';

abstract class ProductEvent {}

class ProductEventAdd extends ProductEvent {
  final String name;
  final int qty;
  final String code;

  ProductEventAdd({required this.name, required this.qty, required this.code});
}

class ProductEventEdit extends ProductEvent {
  final String name;
  final int qty;
  final String id;

  ProductEventEdit({required this.name, required this.qty, required this.id});
}

class ProductEventDelete extends ProductEvent {
  final String id;
  ProductEventDelete(this.id);
}
