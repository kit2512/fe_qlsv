import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

import 'faculty_details_controller.dart';

class FacultyDetailsPage extends GetView<FacultyDetailsController> {
  const FacultyDetailsPage({
    super.key,
  });

  Widget buildDetailsItem(String title, String value) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.getData,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Faculty details",
            style: AppTextTheme.pageTitleTheme,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(
                () => Get.find<LoadingController>().isLoading.value ? const SizedBox.shrink() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildDetailsItem("Name",
                                    controller.faculty.value!.facultyName!),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                buildDetailsItem("ID",
                                    controller.faculty.value!.id.toString()),
                                const SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text("Majors", style: AppTextTheme.pageTitleTheme.copyWith(fontSize: 20.0)),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Obx(
                      () => DataTable(
                              columns: const [
                                  DataColumn(
                                    label: Text("ID"),
                                  ),
                                  DataColumn(
                                    label: Text("Name"),
                                  ),
                                  DataColumn(
                                    label: Text("Action"),
                                  ),
                                ],
                              rows: controller.listMajor.map((major) {
                                return DataRow(
                                  cells: [
                                    DataCell(Text(major.id.toString())),
                                    DataCell(Text(major.majorName)),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              // controller.deleteMajor(major.id!);
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // controller.editMajor(major);
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(growable: false)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
