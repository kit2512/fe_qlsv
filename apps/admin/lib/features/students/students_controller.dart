import 'package:get/get.dart';
import 'package:shared/shared.dart';

class StudentsController extends GetxController {
  final StudentRepository _studentRepository = Get.find();
  final LoadingController _loadingController = Get.find();

  Rx<ListStudentModel> listStudent = Rx<ListStudentModel>(ListStudentModel());

  Rx<String> selectedStudentId = Rx<String>("");


  void getStudentList() async {
    _loadingController.startLoading();
    final res = await _studentRepository.getStudent();
    res.fold(
      (l) => logger.e(l.message),
      (r) => listStudent.value = r,
    );
    _loadingController.endLoading();
  }

  void deleteStudent(String studentCode) async {
    _loadingController.startLoading();
    final res = await _studentRepository.deleteStudent(studentCode);
    res.fold((l) {
      logger.e(l.message);
      _loadingController.endLoading();

    }, (r) {
      getStudentList();
    });
    _loadingController.endLoading();
  }
}
