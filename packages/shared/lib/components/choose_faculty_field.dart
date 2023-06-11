import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:shared/models/faculty_model.dart';

import '../shared.dart';

class ChooseFacultyField extends StatefulWidget {
  const ChooseFacultyField({
    super.key,
    required this.onSuggestionSelected,
    required this.controller,
  });

  final void Function(FacultyModel?) onSuggestionSelected;
  final TextEditingController controller;

  @override
  State<ChooseFacultyField> createState() => _ChooseFacultyFieldState();
}

class _ChooseFacultyFieldState extends State<ChooseFacultyField> {
  final _facultyRepsitory = Get.find<FacultyRepository>();

  @override
  void initState() {
    _facultyRepsitory.getFacultiesList().then((result) => result.fold(
          (l) => null,
          (r) {
            setState(() {
              _facultyList.clear();
              _facultyList.addAll(r);
            });
          },
        ));
    super.initState();
  }

  final List<FacultyModel> _facultyList = [];

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<FacultyModel>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: const InputDecoration(
          labelText: "Faculty",
        ),
      ),
      suggestionsCallback: (pattern) async {
        return _facultyList.where((faculty) {
          return faculty.facultyName!.toLowerCase().contains(pattern) ||
              faculty.id!.toString().contains(pattern);
        }).toList();
      },
      onSuggestionSelected: widget.onSuggestionSelected,
      itemBuilder: (context, model) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(model.facultyName ?? "Unknown"),
        );
      },
    );
  }
}
