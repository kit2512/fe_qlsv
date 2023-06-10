import 'package:shared/shared.dart';

import 'subjects_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin DeleteSubjectMixin on GetxController {
  final _subjectRespository = Get.find<SubjectRepository>();
  final _loadingController = Get.find<LoadingController>();
  RxBool isDeleting = false.obs;

  Future<void> deleteSubject(String subjectId) async {
    final result = await Get.dialog(
        AlertDialog(
          title: const Text("Confirm delete"),
          content: const Text("Are you sure want to delete this subject?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: const Text("Delete"),
            ),
          ],
        )
    );
    if (result) {
      _loadingController.startLoading();
      final res = await _subjectRespository.deleteSubject(subjectId);
      res.fold((l) {
        logger.e(l.message);
        Get.snackbar("Error", l.message ?? "Unknown error");
      }, (r) {
        Get.snackbar("Success", "Delete subject successfully");
        Get.find<SubjectsController>().getSubjects();
      });
      _loadingController.endLoading();
    }
  }
}