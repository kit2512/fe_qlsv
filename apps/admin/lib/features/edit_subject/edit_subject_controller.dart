import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class EditSubjectController extends GetxController {
  final _loadingController = Get.find<LoadingController>();
  final _subjectRepository = Get.find<SubjectRepository>();

  RxBool isError = RxBool(false);
  RxBool isValid = RxBool(false);
  Rx<SubjectModel?> subject = Rx<SubjectModel?>(null);

  final subjectNameController = TextEditingController();
  final creditsController = TextEditingController();
  final idController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    subjectNameController.clear();
    creditsController.clear();
    idController.clear();
    subjectNameController.addListener(_isValid);
    creditsController.addListener(_isValid);
    idController.addListener(_isValid);
    getSubject();
    super.onInit();
  }

  void reset() {
    subjectNameController.clear();
    creditsController.clear();
    idController.clear();
    subjectNameController.removeListener(_isValid);
    creditsController.removeListener(_isValid);
    idController.removeListener(_isValid);
  }

  void _isValid() {
    isValid.value = subjectNameController.text.isNotEmpty &&
        creditsController.text.isNotEmpty;
  }

  void getSubject() async {
    _loadingController.startLoading();
    final id = GoRoutes.pathParameters["id"];
    final res = await _subjectRepository.getSubject(id);
    res.fold((l) {
      isError.value = true;
      _loadingController.endLoading();
      return Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message ?? "Something went wrong",
      ));
    }, (r) {
      _loadingController.endLoading();
      subject.value = r;
      idController.text = r.id;
      subjectNameController.text = r.subjectName;
      creditsController.text = r.credits.toString();
      isError.value = false;
    });
  }

  void updateSubject() async {
    final SubjectModel subjectModel = SubjectModel(
      id: idController.text,
      subjectName: subjectNameController.text,
      credits: int.parse(creditsController.text),
    );
    _loadingController.startLoading();
    final res = await _subjectRepository.updateSubject(subjectModel);
    res.fold((l) {
      _loadingController.endLoading();
      return Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message ?? "Something went wrong",
      ));
    }, (r) {
      _loadingController.endLoading();
      Get.showSnackbar(const GetSnackBar(
        title: "Success",
        message: "Subject updated successfully",
      ));
      Get.context!.goNamed(
        GoRoutes.subjects,
      );
    });
  }
}
