import 'package:get/get.dart';

// DATA
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';

// DOMAIN
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_user_by_id.dart';
import '../../domain/usecases/create_user.dart';

// PRESENTATION
import '../controllers/user_controller.dart';

class UserBindings extends Bindings {
  @override
  void dependencies() {
    // Datasource
    Get.lazyPut<UserRemoteDataSource>(() =>
        UserRemoteDataSourceImpl('https://jsonplaceholder.typicode.com'));

    // Repository Implementation
    Get.lazyPut<UserRepositoryImpl>(
          () => UserRepositoryImpl(Get.find<UserRemoteDataSource>()),
    );

    // Usecases
    Get.lazyPut(() => GetAllUsers(Get.find<UserRepositoryImpl>()));
    Get.lazyPut(() => GetUserById(Get.find<UserRepositoryImpl>()));
    Get.lazyPut(() => CreateUser(Get.find<UserRepositoryImpl>()));

    // Controller
    Get.lazyPut(() => UserController(
      Get.find<GetAllUsers>(),
      Get.find<GetUserById>(),
      Get.find<CreateUser>(),
    ));
  }
}
