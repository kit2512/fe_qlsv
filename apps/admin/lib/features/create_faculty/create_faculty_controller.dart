import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class CreateFacultyController extends GetxController {
  final _loadingController = Get.find<LoadingController>();
  final _facultyRepository = Get.find<FacultyRepository>();

  RxString facultyName = ''.obs;

  final formKey = GlobalKey<FormState>();


  void createFaculty({required String name}) async {
    _loadingController.startLoading();
    final res = await _facultyRepository.createFaculty(name: name);
    res.fold(
      (l) {
        _loadingController.endLoading();
        Get.showSnackbar(GetSnackBar(
          title: l.message ?? "Error creating faculty",
          message: l.errorCode,
        ));
      },
      (r) {
        _loadingController.endLoading();
        Get.context!.goNamed(GoRoutes.faculties);
      },
    );
  }
}
