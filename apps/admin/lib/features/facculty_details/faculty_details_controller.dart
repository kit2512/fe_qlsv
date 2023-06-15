import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

import '../../routes/go_routes.dart';

class FacultyDetailsController extends GetxController
    with GetTickerProviderStateMixin {
  final _facultyRepository = Get.find<FacultyRepository>();
  final _subjectClassRepository = Get.find<SubjectClassRepository>();
  final _lecturerRepository = Get.find<LecturerRepository>();
  final _studentRepository = Get.find<StudentRepository>();
  final _majorRepository = Get.find<MajorRepository>();
  final _loadingController = Get.find<LoadingController>();

  final Rx<int?> id = Rx<int?>(null);
  Rx<FacultyModel?> faculty = Rx<FacultyModel?>(null);
  RxList<MajorModel> listMajor = <MajorModel>[].obs;
  RxList<StudentModel> listStudent = <StudentModel>[].obs;
  RxList<LecturerModel> listLecturer = <LecturerModel>[].obs;


  TabController? tabBarController;

  @override
  void onInit() {
    tabBarController = TabController(length: 4, vsync: this);
    super.onInit();
  }

  void getData() async  {
    _loadingController.startLoading();
    id.value = int.parse(GoRoutes.pathParameters["id"]!);
    await getFaculty(id.value!, isFirst: true);
    await getFacultyMajors(id.value!, isFirst: true);
    await getFacultyStudents(id.value!, isFirst: true);
    await getFacultyLecturers(id.value!, isFirst: true);
    _loadingController.endLoading();
  }

  Future<void> getFaculty(int id, {bool isFirst = false}) async {

    final res = await _facultyRepository.getFaculty(id: id);
    res.fold(
      (l) {
        Get.showSnackbar(GetSnackBar(
          title: "Error",
          message: l.message,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        ));
      },
      (r) {
        faculty.value = r;
      },
    );

  }

  Future<void> getFacultyMajors(int id, {bool isFirst = false}) async {

    final res = await _majorRepository.getFacultyMajors(id: id);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      ));
    }, (r) {
      listMajor.assignAll(r);
    });

  }

  Future<void> getFacultyStudents(int id, {bool isFirst = false}) async {

    final res = await _studentRepository.getFacultyStudents(id: id);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      ));
    }, (r) {
      listStudent.assignAll(r);
    });

  }

  Future<void> getFacultyLecturers(int id, {bool isFirst = false}) async {

    final res = await _lecturerRepository.getFacultyLecturers(id: id);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      ));
    }, (r) {
      listLecturer.assignAll(r);
    });
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
        getData();
      },
    );
    _loadingController.endLoading();
  }
}
