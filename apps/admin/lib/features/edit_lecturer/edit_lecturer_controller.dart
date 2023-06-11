import 'package:admin/routes/go_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class EditLecturerController extends GetxController {
  final _loadingController = Get.find<LoadingController>();
  final _lecturerRepository = Get.find<LecturerRepository>();

  final nameController = TextEditingController();
  final idController = TextEditingController();

  final selectedFacultyController = TextEditingController();
  Rx<FacultyModel?> selectedFaculty = Rx<FacultyModel?>(null);

  final RxBool hasError = false.obs;

  RxBool isValid = false.obs;

  _isValid() {
    isValid.value =
        selectedFaculty.value != null && nameController.text.trim().isNotEmpty;
  }

  @override
  void onInit() {
    nameController.clear();
    nameController.addListener(_isValid);
    final id = GoRoutes.params["id"];
    if (id == null) {
      hasError.value = true;
    } else {
      getLecturerInfo(id);
    }
    super.onInit();
  }

  void getLecturerInfo(String id) async {
    _loadingController.startLoading();
    final res = await _lecturerRepository.getLecturerDetails(id);
    res.fold((l) {
      hasError.value = true;
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message:
            "Unable to get information of lecturer: ${l.message} ${l.errorCode}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      ));
    }, (r) {
      hasError.value = false;
      nameController.text = r.lecturerName.toString();
      idController.text = r.id.toString();
      selectedFacultyController.text = r.facultyId.toString();
    });
    _loadingController.endLoading();
  }

  void updateLecturer() async {
    _loadingController.startLoading();
    final res = await _lecturerRepository.updateLecturer(
      LecturerModel(
          id: idController.text,
          lecturerName: nameController.text,
          facultyId: selectedFaculty.value!.id!),
    );
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: "Unable to update lecturer info",
        message: "${l.errorCode}: ${l.message}",
        duration: const Duration(seconds: 3),
      ));
    }, (r) {
      Get.showSnackbar(
          GetSnackBar(
            title: "Successfully update lecturer",
            message: r.lecturerName,
            duration: const Duration(seconds: 3),
          )
      );
    });
    _loadingController.endLoading();
  }
}
