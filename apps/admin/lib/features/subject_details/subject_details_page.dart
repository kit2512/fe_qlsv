import 'package:flutter/material.dart';
import 'package:shared/components/common_content_page.dart';
import 'package:shared/shared.dart';

import 'subject_details_controller.dart';
import 'package:get/get.dart';

class SubjectDetailsPage extends GetView<SubjectDetailsController> {
  Widget buildInfoItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Subject name: ",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonContentPage(
        content: Obx(
      () => Column(
        children: [
          Text("Subject details", style: AppTextTheme.pageTitleTheme),
          const SizedBox(
            height: 24.0,
          ),
          buildInfoItem("Subject id:", controller.subject.value?.id ?? ""),
          const SizedBox(
            height: 16.0,
          ),
          buildInfoItem("Name:", controller.subject.value?.subjectName ?? ""),
          const SizedBox(
            height: 16.0,
          ),
          buildInfoItem("Number of credits:",
              controller.subject.value?.credits.toString() ?? ""),
        ],
      ),
    ));
  }
}
