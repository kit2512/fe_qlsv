class MajorModel {
  int id;
  String majorName;
  int facultyId;

  MajorModel({
    required this.id,
    required this.majorName,
    required this.facultyId,
  });

  factory MajorModel.fromJson(Map<String, dynamic> json) => MajorModel(
    id: json['id'] as int,
    majorName: json['major_name'] as String,
    facultyId: json['faculty_id'] as int,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'major_name': majorName,
    'faculty_id': facultyId,
  };
}