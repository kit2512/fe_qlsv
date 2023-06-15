import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'subject_classes_controller.dart';
import 'package:get/get.dart';

class SubjectClassesPage extends GetView<SubjectClassesController> {
  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      content: Column(
        children: [
          Text(
            "Manage subject classes",
            style: AppTextTheme.pageTitleTheme,
          ),
          const SizedBox(height: 24.0),
          Expanded(child: SizedBox(
            width: double.infinity,
            child: InteractiveViewer(
              scaleEnabled: false,
              panEnabled: true,
              constrained: false,
              child: Obx(
                  () => DataTable(
                  columns: [
                    const DataColumn(label: Text("ID")),
                    const DataColumn(label: Text("Subject ID")),
                    const DataColumn(label: Text("Class Name")),
                    const DataColumn(label: Text("Lecturer")),
                    const DataColumn(label: Text("Action")),
                  ],
                  rows:
                    List.generate(controller.subjectClasses.length, (index) {
                      final subjectClass = controller.subjectClasses[index];
                      return DataRow(
                        cells: [
                          DataCell(Text(subjectClass.id!)),
                          DataCell(Text(subjectClass.subjectId!)),
                          DataCell(Text(subjectClass.className!)),
                          DataCell(Text(subjectClass.lecturerId!)),
                          DataCell(Row(
                            children: [
                              IconButton(
                                onPressed: () => Get.toNamed("/subject-classes/edit", arguments: subjectClass),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => controller.deleteSubjectClass(subjectClass.id!),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )),
                        ]
                    );
                    })

                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
