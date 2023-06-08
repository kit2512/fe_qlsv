import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:admin/features/add_student/presentation/controllers/add_student_controller.dart';
import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AddStudentPage extends GetView<AddStudentController> {
  const AddStudentPage({Key? key}) : super(key: key);

  List<Widget> buildFields(BuildContext context) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          label: Text("First name"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Last name"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Citizen ID"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
            label: Text("Date of birth"), disabledBorder: OutlineInputBorder()),
        onTap: () {
          showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 20)),
              firstDate: DateTime(1990),
              lastDate: DateTime.now());
        },
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Email"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Phone"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Address"),
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Nation"),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add student",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              child: AdaptiveLayout(
                mediumLayout: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildFields(context)[index],
                  separatorBuilder: (context, inddex) =>
                      const SizedBox(height: 16.0),
                  itemCount: buildFields(context).length,
                ),
                largeLayout: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  crossAxisCount: 2,
                  childAspectRatio: (Get.width - 200).toDouble() / 2 / 40,
                  children: buildFields(context),
                ),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Save"),
            ),
            const SizedBox(width: 16.0),
            TextButton(
              onPressed: () => context.goNamed(GoRoutes.students),
              child: const Text("Cancel"),
            ),
          ],
        )
      ],
    );
  }
}
