import 'package:admin/features/facuties/faculties.dart';
import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class FacultiesPage extends GetView<FacultiesController> {
  const FacultiesPage({super.key});

  @override
  build(BuildContext context) {
    return CommonContentPage(
      onInit: () => controller.getFaculties(),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Manage faculties",
            textAlign: TextAlign.start,
            style: AppTextTheme.pageTitleTheme,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: InteractiveViewer(
                scaleEnabled: false,
                child: Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Name")),
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: controller.listFaculty
                          .map(
                            (faculty) => DataRow(
                              cells: [
                                DataCell(Text(faculty.facultyName!)),
                                DataCell(Text(faculty.id.toString())),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          context.goNamed(
                                            GoRoutes.editFaculty,
                                            pathParameters: {"id": faculty.id.toString()},
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.deleteFaculty(faculty.id!);
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(GoRoutes.createFaculty);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
