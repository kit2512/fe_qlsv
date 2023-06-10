import 'package:admin/features/subjects/controllers/delete_subject_mixin.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

class SubjectsController extends GetxController with DeleteSubjectMixin {
    final _subjectRepository = Get.find<SubjectRepository>();
    final _loadingController = Get.find<LoadingController>();

    RxList<SubjectModel> listSubject = <SubjectModel>[].obs;



    Future<void> getSubjects({
      String? keyword,
      int? majorId,
      int? facultyId,

  }) async {_loadingController.startLoading();
    final res = await _subjectRepository.getSubjectList(
      keyword: keyword,
      majorId: majorId,
      facultyId: facultyId,
    );

    res.fold((l) {
      logger.e(l.message);
    }, (r) {
      listSubject.value = r;
    });
    _loadingController.endLoading();
  }


}