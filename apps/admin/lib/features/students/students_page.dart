import 'package:admin/routes/go_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared/shared.dart';

import 'presentation/controllers/students_controller.dart';

class StudentPage extends GetView<StudentsController> {
  const StudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Manage student",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
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
              )
            ],
          ),
          const SizedBox(height: 24.0),
          Expanded(
            child: InteractiveViewer(
              // panEnabled: false,
              scaleEnabled: false,
              constrained: false,
              child: Scrollbar(
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
                    DataColumn(label: Text("Year of admission")),
                    DataColumn(label: Text("Graduation year")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Phone number")),
                    DataColumn(label: Text("Citizen ID")),
                    DataColumn(label: Text("Address")),
                    DataColumn(label: Text("Nation")),
                    DataColumn(label: Text("Religion")),
                  ],
                  rows: List.generate(
                    20,
                    (index) => DataRow(
                      onSelectChanged: (value) {},
                      color: index.isEven
                          ? MaterialStatePropertyAll(
                              AppColors.outline.withOpacity(0.1))
                          : null,
                      cells: const [
                        DataCell(Text("CT050222")),
                        DataCell(Text("Nguyen")),
                        DataCell(Text("Van A")),
                        DataCell(Text("CT")),
                        DataCell(Text("D")),
                        DataCell(Text("Male")),
                        DataCell(Text("01/01/2001")),
                        DataCell(Text("2020")),
                        DataCell(Text("2024")),
                        DataCell(Text("dannamdinh49@gmail.com")),
                        DataCell(Text("0123456789")),
                        DataCell(Text("123456789")),
                        DataCell(Text("123 Nguyen Van Linh")),
                        DataCell(Text("Kinh")),
                        DataCell(Text("Khong")),
                      ],
                    ),
                  ),
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
}
