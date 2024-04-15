import 'package:hive/hive.dart';
import 'package:uts/model/category.dart';

class LocalCategoryService {
  late Box<Category> _popularCategoryBox;
  late Box<Category> _categoryBox;

  Future<void> init() async {
    _popularCategoryBox = await Hive.openBox<Category>('PopularCategories');
    _categoryBox = await Hive.openBox<Category>('categories');
  }

  Future<void> assignAllPopularCategories({required List<Category> popularCategories}) async {
    await _popularCategoryBox.clear();
    await _popularCategoryBox.addAll(popularCategories);
  }

  Future<void> assignAllCategories({required List<Category> categories}) async {
    await _categoryBox.clear();
    await _categoryBox.addAll(categories);
  }

  List<Category> getAllPopularCategories() => _popularCategoryBox.values.toList();
  List<Category> getAllCategories() => _categoryBox.values.toList();
}