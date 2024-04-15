import 'package:get/get.dart';
import 'package:uts/controller/auth/auth_controller.dart';
import 'package:uts/controller/category/category_controller.dart';
import 'package:uts/controller/dashboard/dashboard_controller.dart';
import 'package:uts/controller/homepage/homepage_controller.dart';
import 'package:uts/controller/product/product_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(ProductController());
    Get.put(CategoryController());
    Get.put(AuthController());
  }

}
