import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posmobile/data/model/response/category_model_response.dart';
import 'package:posmobile/data/repository/category_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'category_event.dart';
part 'category_state.dart';
part 'category_bloc.freezed.dart';

EventTransformer<E> _droppableThrottle<E>(Duration d) =>
    (events, mapper) => droppable<E>().call(events.throttle(d), mapper);

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repo;

  // Cache biar gak fetch ulang saat select
  List<Category> _cache = [];

  CategoryBloc(this._repo) : super(const CategoryState.initial()) {
    on<_Started>((e, emit) => add(const CategoryEvent.fetchCategories()));
    on<_FetchCategories>(
      _onFetch,
      transformer: _droppableThrottle(const Duration(milliseconds: 300)),
    );
    on<_SelectCategory>(_onSelect);
  }

  Future<void> _onFetch(
    _FetchCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryState.loading());
    final result = await _repo
        .fetchCategories(); // Future<Either<String, CategoryModelResponse>>

    result.fold((err) => emit(CategoryState.failure(err)), (response) {
      final list = List<Category>.from(response.data);

      // Tambah "Semua" di index 0 sebagai default
      list.insert(0, Category(id: 0, name: 'Semua'));

      // Custom sorting berdasarkan urutan yang diinginkan
      list.sort(
        (a, b) => _getCustomOrder(a.name).compareTo(_getCustomOrder(b.name)),
      );

      _cache = list;

      emit(
        CategoryState.success(
          categories: _cache,
          selectedCategoryId: _cache.first.id, // default: "Semua"
        ),
      );
    });
  }

  Future<void> _onSelect(
    _SelectCategory event,
    Emitter<CategoryState> emit,
  ) async {
    // Re-emit success dengan selected baru (tanpa fetch ulang)
    if (_cache.isEmpty) {
      // Kalau belum pernah fetch, trigger fetch dulu
      add(const CategoryEvent.fetchCategories());
      return;
    }
    emit(
      CategoryState.success(
        categories: _cache,
        selectedCategoryId: event.categoryId,
      ),
    );
  }

  // Method untuk menentukan urutan custom kategori
  int _getCustomOrder(String categoryName) {
    switch (categoryName) {
      case 'Semua':
        return 0;
      case 'Prasmanan':
        return 1;
      case 'Toping':
        return 2;
      case 'Minuman':
        return 3;
      case 'Makanan':
        return 4;
      case 'Bakso & Mie Ayam':
        return 5;
      case 'Camilan':
        return 6;
      default:
        return 999; // Kategori lain diletakkan di akhir
    }
  }
}
