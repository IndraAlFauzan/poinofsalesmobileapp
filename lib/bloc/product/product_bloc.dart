import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/product_model_response.dart';
import 'package:posmobile/data/repository/product_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

EventTransformer<E> _throttle<E>(Duration d) =>
    (events, mapper) => droppable<E>().call(events.throttle(d), mapper);

EventTransformer<E> _debounceRestartable<E>(Duration d) =>
    (events, mapper) => restartable<E>().call(events.debounce(d), mapper);

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _repo;

  // Cache all products agar filter/search lokal cepat
  List<Product> _all = [];

  // Filter state
  int _selectedCategoryId = 0; // 0 = Semua
  String _query = '';

  ProductBloc(this._repo) : super(const ProductState.initial()) {
    on<_Started>((e, emit) => add(const ProductEvent.fetchProducts()));
    on<_FetchProducts>(
      _onFetch,
      transformer: _throttle(const Duration(milliseconds: 300)),
    );
    on<_FilterProductsByCategory>(_onFilterCategory);
    on<_SearchProducts>(
      _onSearch,
      transformer: _debounceRestartable(const Duration(milliseconds: 350)),
    );
  }

  Future<void> _onFetch(
    _FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductState.loading());
    final result = await _repo
        .fetchProduct(); // Future<Either<String, ProductModelResponse>>

    result.fold((err) => emit(ProductState.failure(err)), (res) {
      _all = res.data;
      emit(ProductState.success(_applyFilters()));
    });
  }

  Future<void> _onFilterCategory(
    _FilterProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    _selectedCategoryId = event.categoryId;
    _query = ''; // Reset search query ketika filter kategori

    // Jika cache kosong, fetch dulu
    if (_all.isEmpty) {
      emit(const ProductState.loading());
      final result = await _repo.fetchProduct();
      result.fold((err) => emit(ProductState.failure(err)), (res) {
        _all = res.data;
        final filtered = _applyFilters();
        if (filtered.isEmpty) {
          emit(const ProductState.failure('No Products'));
        } else {
          emit(ProductState.success(filtered));
        }
      });
      return;
    }

    final filtered = _applyFilters();
    if (filtered.isEmpty) {
      emit(const ProductState.failure('No Products'));
    } else {
      emit(ProductState.success(filtered));
    }
  }

  Future<void> _onSearch(
    _SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    _query = event.query.trim();

    // Search lokal berdasarkan cache + filter kategori
    if (_all.isNotEmpty) {
      emit(ProductState.success(_applyFilters()));
      return;
    }

    // Kalau belum ada cache, fetch dulu lalu terapkan filter+search
    emit(const ProductState.loading());
    final result = await _repo.fetchProduct();
    result.fold((err) => emit(ProductState.failure(err)), (res) {
      _all = res.data;
      emit(ProductState.success(_applyFilters()));
    });
  }

  List<Product> _applyFilters() {
    Iterable<Product> list = _all;

    // Category 0 = Semua → tidak filter
    if (_selectedCategoryId != 0) {
      list = list.where((p) => p.categoryId == _selectedCategoryId);
    }

    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q));
    }

    return List<Product>.from(list);
  }
}
