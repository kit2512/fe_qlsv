import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'edit_lecturer_controller.dart';

class EditLecturePage extends GetView<EditLecturerController> {
  const EditLecturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.onInit,
      content: Obx(
        () {
          if (controller.hasError.value) {
            return const Text("Error getting details");
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Lecturer information",
                style: AppTextTheme.pageTitleTheme,
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                enabled: false,
                controller: controller.idController,
                decoration: const InputDecoration(
                  labelText: "Lecturer ID",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: "Lecturer Name",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ChooseFacultyField(
                controller: controller.selectedFacultyController,
                onSuggestionSelected: (value) {
                  controller.selectedFacultyController.text =
                      value?.facultyName ?? "";
                  controller.selectedFaculty(value);
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.updateLecturer();
                    },
                    child: const Text("Update"),
                  ),
                  const SizedBox(width: 24.0,),
                  TextButton(
                    onPressed: () {
                      context.goNamed(GoRoutes.lecturers);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
