class SubjectModel {
  String id;
  String subjectName;
  int credits;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.credits,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json["id"],
        subjectName: json["subject_name"],
        credits: json["credits"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "credits": credits,
      };
}
