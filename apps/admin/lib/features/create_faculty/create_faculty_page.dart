import 'package:admin/features/create_faculty/create_faculty_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared/components/app_theme.dart';
import 'package:shared/components/common_content_page.dart';

class CreateFacultyPage extends GetView<CreateFacultyController> {
  const CreateFacultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
        content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create faculty",
          style: AppTextTheme.pageTitleTheme,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 24.0,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Faculty name",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextFormField(
                    onChanged: (value) => controller.facultyName.value = value,
                    decoration: const InputDecoration(
                        hintText: "Faculty name", border: OutlineInputBorder(),),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Please enter faculty name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.createFaculty(name: controller.facultyName.value);
                    },
                    child: Text("Create faculty"),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
