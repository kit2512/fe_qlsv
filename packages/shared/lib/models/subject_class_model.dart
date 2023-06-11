class SubjectClassModel {
  String? id;
  String? subjectId;
  String? scheduleId;
  String? lecturerId;
  String? className;

  SubjectClassModel({
    required this.id,
    required this.subjectId,
    required this.scheduleId,
    required this.lecturerId,
    required this.className,
  });

  factory SubjectClassModel.fromJson(Map<String, dynamic> json) =>
      SubjectClassModel(
        id: json["id"],
        subjectId: json["subject_id"],
        scheduleId: json["schedule_id"],
        lecturerId: json["lecturer_id"],
        className: json["class_name"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_id": subjectId,
    "schedule_id": scheduleId,
    "lecturer_id": lecturerId,
    "class_name": className,
  };
}
