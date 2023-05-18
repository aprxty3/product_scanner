part of 'product_bloc.dart';

abstract class ProductState {}

class ProductStateInitial extends ProductState {}

class ProductStateAdd extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateError extends ProductState {
  ProductStateError({required this.message});
  final String message;
}

class ProductStateComplete extends ProductState {}

class ProductStateEdit extends ProductState {}

class ProductStateDelete extends ProductState {}
