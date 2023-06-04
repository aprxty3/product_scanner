part of 'product_bloc.dart';

abstract class ProductState {}

class ProductStateInitial extends ProductState {}

class ProductStateAdd extends ProductState {}

class ProductStateLoading extends ProductState {}

class ProductStateError extends ProductState {
  ProductStateError({required this.message});
  final String message;
}

class ProductStateCompleteAdd extends ProductState {}

class ProductStateCompleteEdit extends ProductState {}

class ProductStateCompleteDelete extends ProductState {}

class ProductStateCompleteExport extends ProductState {}

class ProductStateEdit extends ProductState {}

class ProductStateDelete extends ProductState {}
