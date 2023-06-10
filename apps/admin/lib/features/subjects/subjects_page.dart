import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/components/app_theme.dart';
import 'package:shared/components/common_content_page.dart';

import 'controllers/subjects_controller.dart';

class SubjectsPage extends GetView<SubjectsController> {
  const SubjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(GoRoutes.createSubject);
        },
        child: const Icon(Icons.add),
      ),
      onInit: controller.getSubjects,
      content: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage subjects",
              style: AppTextTheme.pageTitleTheme,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Expanded(
                child: InteractiveViewer(
              panAxis: PanAxis.vertical,
              scaleEnabled: false,
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text("ID"),
                    ),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Number of credits")),
                    DataColumn(label: Text("Action"))
                  ],
                  rows: List.generate(
                    controller.listSubject.length,
                    (index) {
                      final subject = controller.listSubject[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(subject.id)),
                          DataCell(
                            Text(subject.subjectName),
                          ),
                          DataCell(
                            Text(
                              subject.credits.toString(),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => context.goNamed(GoRoutes.editSubject, pathParameters: {"id": subject.id}),
                                  icon: const Icon(Icons.edit_rounded),
                                ),
                                IconButton(
                                  onPressed: () => Get.context!.goNamed(
                                    GoRoutes.subjectDetails,
                                    pathParameters: {"id": subject.id},
                                  ),
                                  icon: const Icon(Icons.info_rounded),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.deleteSubject(subject.id);
                                  },
                                  icon: const Icon(Icons.delete_rounded),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
