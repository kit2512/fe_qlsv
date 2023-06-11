import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class FacultiesController extends GetxController {
  final _facultyRepository = Get.find<FacultyRepository>();
  final _loadingController = Get.find<LoadingController>();

  final RxList<FacultyModel> listFaculty = RxList<FacultyModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void getFaculties({String? keyword}) async {
    _loadingController.startLoading();
    final res = await _facultyRepository.getFacultiesList(keyword: keyword);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: l.message ?? "Error loading faculties",
        message: l.errorCode,
      ));
      _loadingController.endLoading();
    }, (r) {
      listFaculty.assignAll(r);
      _loadingController.endLoading();
    });
  }

  void deleteFaculty(int id) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Faculty"),
        content: const Text("Are you sure you want to delete this faculty?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              _loadingController.startLoading();
              final res = await _facultyRepository.deleteFaculty(id: id);
              res.fold((l) {
                Get.showSnackbar(GetSnackBar(
                  title: l.message ?? "Error deleting faculty",
                  message: l.errorCode,
                ));
                _loadingController.endLoading();
              }, (r) {
                Get.showSnackbar(const GetSnackBar(
                  title: "Success deleting major",
                  message: "",
                ));
                listFaculty.removeWhere((element) => element.id == id);
              });
              _loadingController.endLoading();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
