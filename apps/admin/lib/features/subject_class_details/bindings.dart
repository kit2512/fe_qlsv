import 'package:get/get.dart';

import 'subject_class_details_controller.dart';

class SubjectClassDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectClassDetailsController>(() => SubjectClassDetailsController(), fenix: true);
  }
}