import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'lecturers_controller.dart';

class LecturersPage extends GetView<LecturersController> {
  const LecturersPage({super.key});

  Widget buildTable() {
    return Obx(
      () => DataTable(
        columns: const [
          DataColumn(label: Text('Faculty ID')),
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Action')),
        ],
        rows: controller.listLecturer
            .map(
              (lecturer) => DataRow(
                cells: [
                  DataCell(Text(lecturer.facultyId.toString())),
                  DataCell(Text(lecturer.id.toString())),
                  DataCell(Text(lecturer.lecturerName.toString())),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.context!.goNamed(
                              GoRoutes.lecturerDetails,
                              pathParameters: {"id": lecturer.id.toString()},
                            );
                          },
                          icon: const Icon(Icons.info_rounded),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Get.context!.goNamed(
                              GoRoutes.editLecturer,
                              queryParameters: {"id": lecturer.id.toString()},
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final result = await Get.dialog(
                              AlertDialog(
                                title: const Text('Delete Lecturer'),
                                content: const Text(
                                    'Are you sure you want to delete this lecturer?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(result: false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(result: true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                            if (result) {
                              controller.deleteLecture(lecturer.id!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.getLecturers,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded),
        onPressed: () {
          context.goNamed(GoRoutes.createLecturer);
        },
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Manage Lectures', style: AppTextTheme.pageTitleTheme),
          const SizedBox(height: 24.0),
          InteractiveViewer(
            scaleEnabled: false,
            child: AdaptiveLayout(
              largeLayout: SizedBox(
                width: double.infinity,
                child: buildTable(),
              ),
              mediumLayout: buildTable(),
            ),
          ),
        ],
      ),
    );
  }
}
