import 'package:get/get.dart';
import 'package:uts/model/category.dart';
import 'package:uts/service/local_service/local_category_service.dart';
import 'package:uts/service/remote_service/remote_category_service.dart';

class CategoryController extends GetxController {
  static CategoryController instance = Get.find();
  RxList<Category> categoryList = List<Category>.empty(growable: true).obs;
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  RxBool isCategoryLoading = false.obs;

  @override
  void onInit() async {
    await _localCategoryService.init();
    getCategory();
    super.onInit();
  }

  void getCategory() async {
    try {
      isCategoryLoading(true);
      if (_localCategoryService.getAllCategories().isNotEmpty) {
        categoryList.assignAll(_localCategoryService.getAllCategories());
      }
      var result = await RemoteCategoryService().get();
      if (result != null) {
        categoryList.assignAll(categoryListFromJson(result.body));
        _localCategoryService.assignAllCategories(
            categories: categoryListFromJson(result.body));
      }
    } finally {
      isCategoryLoading(false);
    }
  }
}
