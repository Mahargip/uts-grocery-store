import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uts/model/product.dart';
import 'package:uts/service/remote_service/remote_product_service.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;
  RxList<Product> productList = List<Product>.empty(growable: true).obs;
  RxBool isProductLoading = false.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().get();
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
    }
  }

  void getProductByName({required String keyword}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByName(keyword: keyword);
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
      print(productList.length);
    }
  }

  void getProductByCategory({required int id}) async {
    try {
      isProductLoading(true);
      var result = await RemoteProductService().getByCategory(id: id);
      if (result != null) {
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      isProductLoading(false);
      print(productList.length);
    }
  }
}
