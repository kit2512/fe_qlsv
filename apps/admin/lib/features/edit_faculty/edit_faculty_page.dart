import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared/shared.dart';
import 'edit_faculty_controller.dart';
import 'package:get/get.dart';

class EditFacultyPage extends GetView<EditFacultyController> {
  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.initData,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit Faculty',
            style: AppTextTheme.pageTitleTheme,
          ),
          const SizedBox(
            height: 24.0,
          ),
          Expanded(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller.facultyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Faculty Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter faculty name';
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                      FilteringTextInputFormatter(RegExp(r"[A-Za-z\s]"),
                          allow: true),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text('Major Name'),
                          ),
                          DataColumn(
                            label: Text('Action'),
                          ),
                        ],
                        rows: [
                          ...controller.listMajor
                              .map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(e.majorName),
                                    ),
                                    DataCell(
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteMajor(e);
                                            },
                                            icon: const Icon(Icons.delete),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.editMajor(e);
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                          DataRow(
                            cells: [
                              DataCell(
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      controller.addMajor();
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.transparent),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add Major'),
                                  ),
                                ),
                              ),
                              const DataCell(
                                SizedBox(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.updateFaculty(controller.faculty.value);
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
