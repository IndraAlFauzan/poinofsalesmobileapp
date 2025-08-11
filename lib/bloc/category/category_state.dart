part of 'category_bloc.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.success({
    required List<Category> categories,
    required int selectedCategoryId,
  }) = _Success;
  const factory CategoryState.failure(String message) = _Failure;
}
