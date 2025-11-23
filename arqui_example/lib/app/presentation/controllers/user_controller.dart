import 'package:get/get.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_all_users.dart';
import '../../domain/usecases/get_user_by_id.dart';
import '../../domain/usecases/create_user.dart';

class UserController extends GetxController {
  final GetAllUsers getAllUsersUseCase;
  final GetUserById getUserByIdUseCase;
  final CreateUser createUserUseCase;

  // ESTADO
  var isLoading = false.obs;
  var users = <UserEntity>[].obs;
  var selectedUser = Rxn<UserEntity>();
  var errorMessage = ''.obs;

  UserController(this.getAllUsersUseCase, this.getUserByIdUseCase, this.createUserUseCase);

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  // -----------------------------
  // 1. OBTENER TODOS LOS USUARIOS
  // -----------------------------
  Future<void> loadUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getAllUsersUseCase();
      users.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // 2. OBTENER USUARIO POR ID
  // -----------------------------
  Future<void> loadUserById(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final user = await getUserByIdUseCase(id);
      selectedUser.value = user;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // -----------------------------
  // 3. CREAR USUARIO
  // -----------------------------
  Future<void> createUser(UserEntity newUser) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await createUserUseCase(newUser);

      // después de crear, actualizamos la lista
      await loadUsers();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
