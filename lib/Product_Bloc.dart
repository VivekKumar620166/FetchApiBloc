import 'dart:async';
import 'package:bloc/bloc.dart';
import 'FetchingProductApi.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>(_onFetchProduct);
  }

  Future<void> _onFetchProduct(
      FetchProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    await Future.delayed(Duration(seconds: 4)); // 4-second delay
    try {
      final products = await fetchProductFetching();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}