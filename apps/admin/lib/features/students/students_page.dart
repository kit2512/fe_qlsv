import 'package:admin/routes/go_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'students_controller.dart';

class StudentPage extends GetView<StudentsController> {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.getStudentList,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Manage student",
            style: AppTextTheme.pageTitleTheme,
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text("Faculty:"),
                  const SizedBox(width: 12.0),
                  SizedBox(
                    width: 120.0,
                    child: DropdownButtonFormField(
                        hint: const Text("Faculty"),
                        items: const [
                          DropdownMenuItem(child: Text("All")),
                        ],
                        onChanged: (value) {}),
                  ),
                ],
              ),
              const SizedBox(width: 24.0),
              Row(
                children: [
                  const Text("Faculty:"),
                  const SizedBox(width: 12.0),
                  SizedBox(
                    width: 120.0,
                    child: DropdownButtonFormField(
                        hint: const Text("Faculty"),
                        items: const [
                          DropdownMenuItem(child: Text("All")),
                        ],
                        onChanged: (value) {}),
                  ),
                ],
              ),
              const SizedBox(width: 24.0),
              Row(
                children: [
                  const Text("Faculty:"),
                  const SizedBox(width: 12.0),
                  SizedBox(
                    width: 120.0,
                    child: DropdownButtonFormField(
                        hint: const Text("Faculty"),
                        items: const [
                          DropdownMenuItem(child: Text("All")),
                        ],
                        onChanged: (value) {}),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(
                width: 200.0,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search student",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 24.0),
              ElevatedButton.icon(
                onPressed: () {
                  context.goNamed(GoRoutes.addStudent);
                },
                icon: const Icon(Icons.add),
                label: const Text("Add student"),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Expanded(
            child: InteractiveViewer(
              // panEnabled: false,
              scaleEnabled: false,
              constrained: false,
              child: Scrollbar(
                child: Obx(
                  () => DataTable(
                      showCheckboxColumn: true,
                      columns: const [
                        DataColumn(label: Text("Student code")),
                        DataColumn(label: Text("First name")),
                        DataColumn(label: Text("Last name")),
                        DataColumn(label: Text("Major ID")),
                        DataColumn(label: Text("Class ID")),
                        DataColumn(label: Text("Gender")),
                        DataColumn(label: Text("Date of birth")),
                        DataColumn(label: Text("Year of admission")),
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
                        controller.listStudent.value.items?.length ?? 0,
                        (index) {
                          final student =
                              controller.listStudent.value.items![index];
                          return buildDataRow(student, index);
                        },
                        growable: false,
                      )),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          const Center(
            child: SizedBox(
                height: 48.0, width: 500, child: CommonNumberPaginator()),
          ),
        ],
      ),
    );
  }

  DataRow buildDataRow(StudentModel student, int index) {
    return DataRow(
      selected: controller.selectedStudentId.value == student.uid,
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
        DataCell(
          ElevatedButton.icon(
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
                      controller.deleteStudent(student.studentCode);
                    },
                    child: Text("Delete"),
                  ),
                ],
              ));
            },
            icon: const Icon(Icons.delete),
            label: const Text("Delete"),
          ),
        ),
      ],
    );
  }
}
