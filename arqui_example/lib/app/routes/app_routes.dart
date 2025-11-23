import 'package:get/get.dart';
import '../presentation/pages/user_page.dart';
import '../presentation/bindings/user_bindings.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/users',
      page: () => const UserPage(),
      binding: UserBindings(),
    ),
  ];
}
