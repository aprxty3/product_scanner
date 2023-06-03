import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_scanner/model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<ProductModel>> streamProduct() async* {
    yield* firestore
        .collection('products')
        .withConverter<ProductModel>(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        )
        .snapshots();
  }

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
    on<ProductEventDelete>((event, emit) async {
      try {
        emit(ProductStateLoading());
        await firestore.collection('products').doc(event.id).delete();

        emit(ProductStateComplete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(
            message: e.message ?? 'Tidak dapat menghapus product'));
      } catch (e) {
        emit(ProductStateError(message: e.toString()));
      }
    });
  }
}
