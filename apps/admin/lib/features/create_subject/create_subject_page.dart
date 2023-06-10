import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared/components/app_theme.dart';
import 'package:shared/components/common_content_page.dart';
import 'create_subject_controller.dart';

class CreateSubjectPage extends GetView<CreateSubjectController> {
  const CreateSubjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
      onInit: controller.init,
      content: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create subject", style: AppTextTheme.pageTitleTheme),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: controller.idController,
              decoration: const InputDecoration(
                labelText: "Subject ID",
              ),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: controller.subjectNameController,
              decoration: const InputDecoration(
                labelText: "Subject name",
              ),
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s0-9]")),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextField(
              controller: controller.creditsController,
              decoration: const InputDecoration(
                labelText: "Number of credits",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            ElevatedButton(
              onPressed: controller.isValid.value ? controller.createSubject : null,
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}
