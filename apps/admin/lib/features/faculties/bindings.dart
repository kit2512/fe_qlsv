import 'package:get/get.dart';

import 'faculties_controller.dart';

class FacultiesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacultiesController>(
      () => FacultiesController(),
      fenix: true
    );
  }
}
