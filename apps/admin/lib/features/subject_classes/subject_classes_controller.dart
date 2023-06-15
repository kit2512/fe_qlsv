import 'package:get/get.dart';
import 'package:shared/shared.dart';

class SubjectClassesController extends GetxController {
    final _subjectClassRepository = Get.find<SubjectClassRepository>();
    final _loadingController = Get.find<LoadingController>();
    RxList<SubjectClassModel> subjectClasses = <SubjectClassModel>[].obs;

    @override
  void onInit() {
    getSubjectClasses();
    super.onInit();

  }

    void getSubjectClasses() async {
      _loadingController.startLoading();
      final res = await Get.find<SubjectClassRepository>().getSubjectClasses();
      res.fold(
        (l) => Get.snackbar("Error", l.message!),
        (r) => subjectClasses.value = r,
      );
      _loadingController.endLoading();
    }

  deleteSubjectClass(String s) {

  }
}