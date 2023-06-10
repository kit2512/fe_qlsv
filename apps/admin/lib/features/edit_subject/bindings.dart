import 'package:get/get.dart';

import 'edit_subject_controller.dart';

class EditSubjectBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditSubjectController(), fenix: true);
  }
}