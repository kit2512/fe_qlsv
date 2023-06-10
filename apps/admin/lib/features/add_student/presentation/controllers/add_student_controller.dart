import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/models/models.dart';
import 'package:shared/shared.dart';

class AddStudentController extends GetxController {
  final StudentRepository _studentRepository = Get.find();

  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString address = "".obs;
  RxString dateOfBirth = "".obs;
  RxString citizenId = "".obs;
  RxString nation = "".obs;
  RxString religion = "".obs;
  RxString nationality = "".obs;
  RxString studentCode = "".obs;
  RxString classId = "".obs;
  RxString password = "".obs;
  RxInt majorId = 0.obs;
  RxInt yearOfAdmission = 0.obs;
  RxInt graduationYear = 0.obs;

  Rx<UserGender> gender = UserGender.female.obs;

  final formKey = GlobalKey<FormState>();

  bool get isValid {
    if (firstName.isEmpty) {
      return false;
    }
    if (lastName.isEmpty) {
      return false;
    }
    if (email.isEmpty) {
      return false;
    }
    if (phoneNumber.isEmpty) {
      return false;
    }
    if (address.isEmpty) {
      return false;
    }
    if (dateOfBirth.isEmpty) {
      return false;
    }
    if (citizenId.isEmpty) {
      return false;
    }
    if (nation.isEmpty) {
      return false;
    }
    if (religion.isEmpty) {
      return false;
    }

    if (nationality.isEmpty) {
      return false;
    }

    if (studentCode.isEmpty) {
      return false;
    }

    if (classId.isEmpty) {
      return false;
    }

    if (password.isEmpty) {
      return false;
    }

    if (majorId.value == 0) {
      return false;
    }

    if (yearOfAdmission.value == 0) {
      return false;
    }

    return true;
  }

  void addStudent() async {
    try {
      Get.find<LoadingController>().startLoading();
      final res = await _studentRepository.createStudent(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        address: address.value,
        dateOfBirth: dateOfBirth.value,
        citizenId: citizenId.value,
        nation: nation.value,
        religion: religion.value,
        nationality: nationality.value,
        studentCode: studentCode.value,
        classId: classId.value,
        roleName: UserRole.student,
        gender: gender.value,
        majorId: majorId.value,
        yearOfAdmission: yearOfAdmission.value,
        graduationYear: graduationYear.value,
        password: password.value,
      );
      res.fold(
          (l) => Get.snackbar("Error", l.message ?? "Unable to create student"),
          (r) => Get.context!.goNamed(GoRoutes.students));
      Get.find<LoadingController>().endLoading();
    } catch (e) {
      logger.e(e.toString());
      Get.find<LoadingController>().endLoading();
    }
  }
}
