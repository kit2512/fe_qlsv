import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presentation/controllers/students_controller.dart';

class StudentPage extends GetView<StudentsController> {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Student page");
  }
}
