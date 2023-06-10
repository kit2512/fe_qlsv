import 'subject_details_controller.dart';
import 'package:get/get.dart';

class SubjectDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectDetailsController(), fenix: true);
  }
}