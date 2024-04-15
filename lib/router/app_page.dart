import 'package:get/get.dart';
import 'package:uts/router/app_route.dart';
import 'package:uts/view/dashboard/dashboard_binding.dart';
import 'package:uts/view/dashboard/dashboard_screen.dart';

class AppPage {
  static var list = [
    GetPage(
        name: AppRoute.dashboard,
        page: () => const DashboardScreen(),
        binding: DashboardBinding(),
    )
  ];
}
