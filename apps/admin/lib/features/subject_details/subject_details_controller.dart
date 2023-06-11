import 'package:admin/routes/go_routes.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class SubjectDetailsController extends GetxController {
  final _loadingController = Get.find<LoadingController>();
  final _subjectRepository = Get.find<SubjectRepository>();

  Rx<SubjectModel?> subject = Rx<SubjectModel?>(null);

  @override
  void onInit() {
    final id = GoRoutes.pathParameters["id"];
    getSubjectDetails(id);
    super.onInit();
  }

  void getSubjectDetails(String id) async {
    _loadingController.startLoading();
    final res = await _subjectRepository.getSubjectDetails(id);
    res.fold((l) {
      return Get.showSnackbar(GetSnackBar(
        title: "Error",
        message: l.message ?? "Something went wrong",
      ));
    }, (r) {
      subject.value = r;
    });
    _loadingController.endLoading();
  }
}
