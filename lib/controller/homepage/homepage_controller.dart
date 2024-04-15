import 'package:get/get.dart';
import 'package:uts/model/ad_banner.dart';
import 'package:uts/model/category.dart';
import 'package:uts/model/product.dart';
import 'package:uts/service/local_service/local_ad_banner_service.dart';
import 'package:uts/service/local_service/local_category_service.dart';
import 'package:uts/service/local_service/local_product_service.dart';
import 'package:uts/service/remote_service/remote_banner_service.dart';
import 'package:uts/service/remote_service/remote_popular_category_service.dart';
import 'package:uts/service/remote_service/remote_popular_product_service.dart';

class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;
  RxList<Category> popularCategoryList = List<Category>.empty(growable: true).obs;
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;
  RxBool isBannerLoading = false.obs;
  RxBool isPopularCategoryLoading = false.obs;
  RxBool isPopularProductLoading = false.obs;
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();


  @override
  void onInit() async {
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();
    getAdBanners();
    getPopularCategories();
    getPopularProducts();
    super.onInit();
  }

  void getAdBanners() async {
    try {
      isBannerLoading(true);
      if (_localAdBannerService.getAllAdBanners().isNotEmpty) {
        bannerList.assignAll(_localAdBannerService.getAllAdBanners());
      }
      var result = await RemoteBannerService().get();
      if (result != null) {
        bannerList.assignAll(adBannerListFromJson(result.body));
        _localAdBannerService.assignAllAdBanners(adbanners: adBannerListFromJson(result.body));
      }
    } finally {
      isBannerLoading(false);
    }
  }
  void getPopularCategories() async {
    try {
      isPopularCategoryLoading(true);
      if (_localCategoryService.getAllPopularCategories().isNotEmpty) {
        popularCategoryList.assignAll(_localCategoryService.getAllPopularCategories());
      }
      var result = await RemotePopularCategoryService().get();
      if (result != null) {
        popularCategoryList.assignAll(popularCategoryListFromJson(result.body));
        _localCategoryService.assignAllPopularCategories(popularCategories: popularCategoryListFromJson(result.body));
      }
    } finally {
      isPopularCategoryLoading(false);
    }
  }
  void getPopularProducts() async {
    try {
      isPopularProductLoading(true);
      if (_localProductService.getAllPopularProducts().isNotEmpty) {
        popularProductList.assignAll(_localProductService.getAllPopularProducts());
      }
      var result = await RemotePopularProductService().get();
      if (result != null) {
        popularProductList.assignAll(popularProductListFromJson(result.body));
        _localProductService.assignAllPopularProducts(popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      isPopularProductLoading(false);
    }
  }
}