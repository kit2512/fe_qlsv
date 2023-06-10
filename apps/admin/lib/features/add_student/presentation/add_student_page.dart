import 'package:adaptive_layout/adaptive_layout.dart';
import 'package:admin/features/add_student/presentation/controllers/add_student_controller.dart';
import 'package:admin/routes/go_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

class AddStudentPage extends GetView<AddStudentController> {
  const AddStudentPage({Key? key}) : super(key: key);

  List<Widget> buildFields(BuildContext context) {
    return [
      TextFormField(
        decoration: const InputDecoration(
          label: Text("First name"),
        ),
        onChanged: (value) => controller.firstName.value = value,
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Last name"),
        ),
        onChanged: (value) => controller.lastName.value = value,
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Citizen ID"),
        ),
        onChanged: (value) => controller.citizenId.value = value,
      ),
      // const SizedBox(height: 16.0),
      Obx(() => Row(
            children: [
              const Text(
                "Date of birth",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              const SizedBox(width: 16.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                alignment: Alignment.center,
                height: 44.0,
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.dateOfBirth.value,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        size: 18.0,
                      ),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1999),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          controller.dateOfBirth.value =
                              DateFormat("yyyy-MM-DD").format(picked);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          )),
      Obx(
        () => Row(
          children: [
            const Text(
              "Gender",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Radio<UserGender>(
              value: UserGender.female,
              groupValue: controller.gender.value,
              onChanged: (val) {
                controller.gender.value = val ?? UserGender.female;
              },
            ),
            const Text(
              "Male",
              style: TextStyle(fontSize: 16.0),
            ),
            Radio<UserGender>(
              value: UserGender.male,
              groupValue: controller.gender.value,
              onChanged: (val) {
                controller.gender.value = val ?? UserGender.female;
              },
            ),
            const Text(
              "Male",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Email"),
        ),
        onChanged: (value) => controller.email.value = value,
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Phone"),
        ),
        onChanged: (value) => controller.phoneNumber.value = value,
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Address"),
        ),
        onChanged: (value) => controller.address.value = value,
      ),
      // const SizedBox(height: 16.0),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Nation"),
        ),
        onChanged: (value) => controller.nation.value = value,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Student Code"),
        ),
        onChanged: (value) => controller.studentCode.value = value,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Password"),
        ),
        obscureText: true,
        onChanged: (value) => controller.password.value = value,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Class ID"),
        ),
        onChanged: (value) => controller.classId.value = value,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Major ID"),
        ),
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (val) => controller.majorId.value = int.parse(val),
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Year of admission"),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: (val) => controller.yearOfAdmission.value = int.parse(val),
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Religion"),
        ),
        onChanged: (val) => controller.religion.value = val,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Nationality"),
        ),
        onChanged: (val) => controller.nationality.value = val,
      ),
      TextFormField(
        decoration: const InputDecoration(
          label: Text("Year of graduation"),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: (val) => controller.graduationYear.value = int.parse(val),
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
              key: controller.formKey,
              child: AdaptiveLayout(
                mediumLayout: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildFields(context)[index],
                  separatorBuilder: (context, inddex) =>
                      const SizedBox(height: 16.0),
                  itemCount: buildFields(context).length,
                ),
                // largeLayout: GridView.count(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   crossAxisSpacing: 16.0,
                //   mainAxisSpacing: 16.0,
                //   crossAxisCount: 2,
                //   childAspectRatio: (Get.width - 200).toDouble() / 2 / 40,
                //   children: buildFields(context),
                // ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.addStudent();
                }
              },
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
