class LecturerModel {
  final String? id;
  final String? lecturerName;
  final int? facultyId;

  LecturerModel({
    required this.id,
    required this.lecturerName,
    required this.facultyId,
  });

  factory LecturerModel.fromJson(Map<String, dynamic> json) {
    return LecturerModel(
      id: json["id"],
      lecturerName: json["lecturer_name"],
      facultyId: json["faculty_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "lecturer_name": lecturerName,
        "faculty_id": facultyId,
      };
}
