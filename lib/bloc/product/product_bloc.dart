import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' hide Uint8List;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
        emit(ProductStateCompleteAdd());
      } on FirebaseException catch (e) {
        emit(ProductStateError(
            message: e.message ?? 'Tidak dapat menambahkan product'));
      } catch (e) {
        emit(ProductStateError(message: e.toString()));
      }
    });
    on<ProductEventEdit>((event, emit) async {
      try {
        emit(ProductStateLoading());

        await firestore.collection('products').doc(event.id).update({
          'name': event.name,
          'qty': event.qty,
        });

        emit(ProductStateCompleteEdit());
      } on FirebaseException catch (e) {
        emit(ProductStateError(
            message: e.message ?? 'Tidak dapat menambahkan product'));
      } catch (e) {
        emit(ProductStateError(message: e.toString()));
      }
    });
    on<ProductEventDelete>((event, emit) async {
      try {
        emit(ProductStateLoading());
        await firestore.collection('products').doc(event.id).delete();

        emit(ProductStateCompleteDelete());
      } on FirebaseException catch (e) {
        emit(ProductStateError(
            message: e.message ?? 'Tidak dapat menghapus product'));
      } catch (e) {
        emit(ProductStateError(message: e.toString()));
      }
    });
    on<ProductEventExportPdf>(
      (event, emit) async {
        try {
          emit(ProductStateLoading());
          var querySnap = await firestore
              .collection('products')
              .withConverter<ProductModel>(
                fromFirestore: (snapshot, _) =>
                    ProductModel.fromJson(snapshot.data()!),
                toFirestore: (value, _) => value.toJson(),
              )
              .get();

          List<ProductModel> allProduct = [];

          for (var element in querySnap.docs) {
            ProductModel product = element.data();
            allProduct.add(product);
          }

          final pdf = pw.Document();

          var data = await rootBundle.load("assets/OpenSans-Regular.ttf");
          var myFont = pw.Font.ttf(data);
          var myStyle = pw.TextStyle(font: myFont);

          pdf.addPage(
            pw.MultiPage(
              pageFormat: PdfPageFormat.a4,
              build: (context) {
                return [
                  pw.Text("HELLO", style: myStyle),
                ];
              },
            ),
          );

          Uint8List bytes = await pdf.save();

          final dir = await getApplicationDocumentsDirectory();
          File file = File("${dir.path}/myproducts.pdf");
          await file.writeAsBytes(bytes);

          await OpenFile.open(file.path);

          print(file.path);

          emit(ProductStateCompleteExport());
        } on FirebaseException catch (e) {
          emit(
            ProductStateError(
                message: e.message ?? 'Tidak dapat mengeksport product'),
          );
        } catch (e) {
          emit(
            ProductStateError(message: e.toString()),
          );
        }
      },
    );
  }
}
