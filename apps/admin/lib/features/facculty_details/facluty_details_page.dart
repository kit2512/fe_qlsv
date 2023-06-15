import 'package:admin/routes/go_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
                () => Get.find<LoadingController>().isLoading.value
                    ? const SizedBox.shrink()
                    : Column(
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
                          Text("Majors",
                              style: AppTextTheme.pageTitleTheme
                                  .copyWith(fontSize: 20.0)),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: DataTable(
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
                                  rows: controller.listMajor.map(
                                    (major) {
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
                                    },
                                  ).toList(growable: false)),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text("Lecturers",
                              style: AppTextTheme.pageTitleTheme
                                  .copyWith(fontSize: 20.0)),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('ID')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Action')),
                                ],
                                rows: controller.listLecturer
                                    .map(
                                      (lecturer) => DataRow(
                                        cells: [

                                          DataCell(Text(lecturer.id.toString())),
                                          DataCell(Text(
                                              lecturer.lecturerName.toString())),
                                          DataCell(
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.context!.goNamed(
                                                      GoRoutes.lecturerDetails,
                                                      pathParameters: {
                                                        "id":
                                                            lecturer.id.toString()
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.info_rounded),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () {
                                                    Get.context!.goNamed(
                                                      GoRoutes.editLecturer,
                                                      queryParameters: {
                                                        "id":
                                                            lecturer.id.toString()
                                                      },
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.delete),
                                                  onPressed: () async {
                                                    final result =
                                                        await Get.dialog(
                                                      AlertDialog(
                                                        title: const Text(
                                                            'Delete Lecturer'),
                                                        content: const Text(
                                                            'Are you sure you want to delete this lecturer?'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(
                                                                    result:
                                                                        false),
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () =>
                                                                Get.back(
                                                                    result: true),
                                                            child: const Text(
                                                                'Delete'),
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
                            ),
                          ),

                          const SizedBox(
                            height: 24.0,
                          ),
                          Text("Students",
                              style: AppTextTheme.pageTitleTheme
                                  .copyWith(fontSize: 20.0)),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Obx(
                            () => SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                showCheckboxColumn: true,
                                columns: const [
                                  DataColumn(label: Text("Student code")),
                                  DataColumn(label: Text("First name")),
                                  DataColumn(label: Text("Last name")),
                                  DataColumn(label: Text("Major ID")),
                                  DataColumn(label: Text("Class ID")),
                                  DataColumn(label: Text("Gender")),
                                  DataColumn(label: Text("Date of birth")),
                                  DataColumn(
                                      label: Text("Year of admission")),
                                  DataColumn(label: Text("Graduation year")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Phone number")),
                                  DataColumn(label: Text("Citizen ID")),
                                  DataColumn(label: Text("Address")),
                                  DataColumn(label: Text("Nation")),
                                  DataColumn(label: Text("Religion")),
                                  DataColumn(label: Text("Actions")),
                                ],
                                rows: List.generate(
                                  controller.listStudent.length ?? 0,
                                  (index) {
                                    final student =
                                        controller.listStudent![index];
                                    return buildDataRow(student, index);
                                  },
                                  growable: false,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow buildDataRow(StudentModel student, int index) {
    return DataRow(
      color: index.isEven
          ? MaterialStatePropertyAll(AppColors.outline.withOpacity(0.1))
          : null,
      cells: [
        DataCell(Text(student.studentCode.trim())),
        DataCell(Text(student.firstName.trim())),
        DataCell(Text(student.lastName.trim())),
        DataCell(Text(student.majorId.toString())),
        DataCell(Text(student.classId.toString())),
        DataCell(Text(student.gender.name)),
        DataCell(Text(DateFormat("DD/MM/yyyy").format(student.dateOfBirth))),
        DataCell(Text(student.yearOfAdmission.toString())),
        DataCell(Text(student.graduationYear.toString())),
        DataCell(Text(student.email)),
        DataCell(Text(student.phoneNumber)),
        DataCell(Text(student.citizenId)),
        DataCell(Text(student.address)),
        DataCell(Text(student.nation)),
        DataCell(Text(student.religion)),
        DataCell(ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
            onPressed: () {
              Get.dialog(AlertDialog(
                title: Text("Delete student"),
                content: Text(
                    "Are you sure you want to delete ${student.firstName} ${student.lastName}?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      // controller.deleteStudent(student.studentCode);
                    },
                    child: Text("Delete"),
                  ),
                ],
              ));
            },
            icon: const Icon(Icons.delete),
            label: const Text("Delete")))
      ],
    );
  }
}
