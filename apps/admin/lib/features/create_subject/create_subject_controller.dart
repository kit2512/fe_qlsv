import 'package:admin/routes/go_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class CreateSubjectController extends GetxController {
  final _loadingController = Get.find<LoadingController>();
  final _subjectRepository = Get.find<SubjectRepository>();

  final subjectNameController = TextEditingController();
  final creditsController = TextEditingController();
  final idController = TextEditingController();
  
  RxBool isValid = false.obs;

  void _isValid() {
    isValid.value = subjectNameController.text.isNotEmpty && idController.text.isNotEmpty && creditsController.text.isNotEmpty;
  }

  void reset() {
    subjectNameController.clear();
    creditsController.clear();
    idController.clear();
    isValid.value = false;
    subjectNameController.removeListener(_isValid);
    creditsController.removeListener(_isValid);
    idController.removeListener(_isValid);
  }

  void init() {
    subjectNameController.clear();
    creditsController.clear();
    idController.clear();


    isValid.value = false;
    subjectNameController.addListener(_isValid);
    creditsController.addListener(_isValid);
    idController.addListener(_isValid);
  }

  void createSubject() async {
    _loadingController.startLoading();
    final res = await _subjectRepository.createSubjcet(
        subjectName: subjectNameController.text,
        credits: int.parse(creditsController.text),
        id: idController.text);
    res.fold((l) {
      _loadingController.endLoading();
      Get.showSnackbar(GetSnackBar(title:"Error", message:l.message ?? "Something went wrong"));
    }, (r)  {
      _loadingController.endLoading();
      Get.showSnackbar(const GetSnackBar(title:"Success", message:"Subject created successfully"));
      reset();
      Get.context!.goNamed(GoRoutes.subjects);
    });
  }
}
