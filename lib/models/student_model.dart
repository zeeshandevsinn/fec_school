import 'package:fec_app2/models/students_model.dart';

class GetStudents {
  final List<AddStudent> data;

  GetStudents({required this.data});

  factory GetStudents.fromMap(map) => GetStudents(
        data: List<AddStudent>.from(map["data"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
