import 'controllers/subjects_controller.dart';
import 'package:get/get.dart';

class SubjectsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectsController(), fenix: true);
  }
}