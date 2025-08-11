part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.fetchProducts() = _FetchProducts;
  const factory ProductEvent.filterProductsByCategory(int categoryId) =
      _FilterProductsByCategory;
  const factory ProductEvent.searchProducts(String query) = _SearchProducts;
}
