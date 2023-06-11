import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class LecturersController extends GetxController {
  final _lecturerRepository = Get.find<LecturerRepository>();
  final _loadingController = Get.find<LoadingController>();

  final keywordController = TextEditingController();

  RxList<LecturerModel> listLecturer = <LecturerModel>[].obs;

  void getLecturers() async {
    _loadingController.startLoading();
    listLecturer.clear();
    final res = await _lecturerRepository.getLecturers(
      keyword: keywordController.text.trim().isEmpty
          ? null
          : keywordController.text.trim(),
    );
    res.fold(
      (l) => Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Unable to get lecturer list ${l.errorCode}, ${l.message}",
        ),
      ),
      (r) => listLecturer.value = r,
    );
    _loadingController.endLoading();
  }

  void deleteLecture(String id) async {
    _loadingController.startLoading();
    final res = await _lecturerRepository.deleteLecturer(id);
    res.fold(
      (l) => Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: "Unable to delete lecturer ${l.errorCode}, ${l.message}",
          duration: const Duration(seconds: 3),
        ),
      ),
      (r) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Success",
            message: "Lecturer deleted successfully",
          ),
        );
        getLecturers();
      },
    );
    _loadingController.endLoading();
  }
}
