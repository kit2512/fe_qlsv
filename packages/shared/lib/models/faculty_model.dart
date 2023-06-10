class FacultyModel {
   int? id;
   String? facultyName;
   FacultyModel({
    this.id,
    this.facultyName,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) => FacultyModel(
        id: json['id'] as int,
        facultyName: json['faculty_name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'faculty_name': facultyName,
      };

  FacultyModel copyWith({
    int? id,
    String? facultyName,
  }) {
    return FacultyModel(
      id: id ?? this.id,
      facultyName: facultyName ?? this.facultyName,
    );
  }
}
