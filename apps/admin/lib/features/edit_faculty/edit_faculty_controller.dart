import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class EditFacultyController extends GetxController {
  final _facultyRepository = Get.find<FacultyRepository>();
  final _majorRepository = Get.find<MajorRepository>();
  final _loadingController = Get.find<LoadingController>();

  final formKey = GlobalKey<FormState>();
  final facultyNameController = TextEditingController();
  final Rx<FacultyModel> faculty = FacultyModel().obs;
  final RxList<MajorModel> listMajor = <MajorModel>[].obs;

  int? facultyId;

  @override
  void onInit() {
    facultyId = int.parse(GoRoutes.params["id"]);
    facultyNameController.addListener(() {
      faculty.value.facultyName = facultyNameController.text;
    });
    super.onInit();
  }

  Future<void> getFaculty(int id) async {
    final res = await _facultyRepository.getFaculty(id: id);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: l.message ?? "Error loading faculty",
        message: l.errorCode,
      ));
    }, (r) {
      faculty.value = r;
    });
  }

  Future<void> getFacultyMajors(int id) async {
    final res = await _majorRepository.getFacultyMajor(facultyId: id);
    res.fold((l) {
      Get.showSnackbar(GetSnackBar(
        title: l.message ?? "Error loading faculty",
        message: l.errorCode,
      ));
    }, (r) {
      listMajor.assignAll(r);
    });
  }

  Future<void> updateFaculty(FacultyModel faculty) async {
    try {
      _loadingController.startLoading();
      final res = await _facultyRepository.updateFaculty(faculty);
      res.fold((l) {
        _loadingController.endLoading();
        Get.showSnackbar(GetSnackBar(
          title: l.message ?? "Error updating faculty",
          message: l.errorCode,
        ));
      }, (r) {
        _loadingController.endLoading();
        Get.showSnackbar(GetSnackBar(
          title: "Success updating faculty",
          message: r.facultyName,
        ));
        initData();
      });
    } catch (e) {
      _loadingController.endLoading();
      Get.showSnackbar(GetSnackBar(
        title: "Error updating faculty",
        message: e.toString(),
      ));
    }
    _loadingController.endLoading();
  }

  Future<void> initData() async {
    _loadingController.startLoading();
    await getFaculty(facultyId!);
    await getFacultyMajors(facultyId!);
    facultyNameController.text = faculty.value.facultyName ?? "";
    _loadingController.endLoading();
  }

  void deleteMajor(MajorModel e) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Major"),
        content: const Text("Are you sure want to delete this major?"),
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
              final res = await _majorRepository.deleteMajor(e.id);
              res.fold((l) {
                _loadingController.endLoading();
                Get.showSnackbar(GetSnackBar(
                  title: l.message ?? "Error deleting major",
                  message: l.errorCode,
                ));
              }, (r) {
                _loadingController.endLoading();
                Get.showSnackbar(GetSnackBar(
                  title: "Success deleting major",
                  message: r.majorName,
                ));
                initData();
              });
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void editMajor(MajorModel e) {}

  void addMajor() {
    Get.dialog(
      AlertDialog(
        title: const Text("Add Major"),
        content: Form(
          key: addMajorFormKey,
          child: TextFormField(
            controller: majorNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter major name";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Major name",
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (addMajorFormKey.currentState!.validate()) {
                Get.back();
                _loadingController.startLoading();
                final res = await _majorRepository.createMajor(name: majorNameController.text, facultyId: facultyId!);
                res.fold((l) {
                  _loadingController.endLoading();
                  Get.showSnackbar(GetSnackBar(
                    title: l.message ?? "Error adding major",
                    message: l.errorCode,
                  ));
                }, (r) {
                  _loadingController.endLoading();
                  Get.showSnackbar(GetSnackBar(
                    title: "Success adding major",
                    message: r.majorName,
                  ));
                  initData();
                });
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // add major
  final addMajorFormKey = GlobalKey<FormState>();
  final majorNameController = TextEditingController();
}
