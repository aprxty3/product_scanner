import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProductBloc() : super(ProductStateInitial()) {
    on<ProductEventAdd>((event, emit) async {
      try {
        emit(ProductStateLoading());
        var hasil = await firestore.collection('products').add({
          'name': event.name,
          'qty': event.qty,
          'code': event.code,
        });

        await firestore.collection('products').doc(hasil.id).update({
          'id': hasil.id,
        });
        emit(ProductStateComplete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(
            message: e.message ?? 'Tidak dapat menambahkan product'));
      } catch (e) {
        emit(ProductStateError(message: e.toString()));
      }
    });
    on<ProductEventEdit>((event, emit) {});
    on<ProductEventDelete>((event, emit) {});
  }
}
