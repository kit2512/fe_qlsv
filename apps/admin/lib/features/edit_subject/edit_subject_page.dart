import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared/shared.dart';

import 'edit_subject_controller.dart';

class EditSubjectPage extends GetView<EditSubjectController> {
  const EditSubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      content: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Edit subject", style: AppTextTheme.pageTitleTheme),
            const SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: controller.idController,
              decoration: const InputDecoration(
                labelText: "Subject ID",
              ),
              enabled: false,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: controller.subjectNameController,
              decoration: const InputDecoration(
                labelText: "Subject name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter subject name";
                }
                return null;
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
                FilteringTextInputFormatter(RegExp(r"[A-za-z\s]"), allow: true),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              controller: controller.creditsController,
              decoration: const InputDecoration(
                labelText: "Number of credits",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter number of credits";
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
                FilteringTextInputFormatter(RegExp(r"[1-6]"), allow: true),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.updateSubject();
                    },
                    child: const Text("Update"),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
