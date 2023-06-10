import 'package:admin/routes/go_routes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class LoginController extends GetxController {
  final UserService _userService = Get.find();
  final LoadingController _loadingController = Get.find();

  Rx<String?> errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    _userService.logout();
    super.onInit();
  }

  void login(
    String username,
    String password,
  ) async {
    _loadingController.startLoading();
    final res = await _userService.login(username, password);
    res.fold(
      (l) => errorMessage.value = l.message,
      (r) => Get.context!.goNamed(GoRoutes.home)
    );
    _loadingController.endLoading();
  }
}
