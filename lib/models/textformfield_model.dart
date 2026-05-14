class TextFormFieldModel {
  String studentName;

  TextFormFieldModel({required this.studentName});

  factory TextFormFieldModel.fromMap(map) =>
      TextFormFieldModel(studentName: map['studentName']);
  Map<String, dynamic> toMap() {
    return {"studentName": studentName};
  }
}

class TextFormFieldClassModel {
  String className;

  TextFormFieldClassModel({required this.className});

  factory TextFormFieldClassModel.fromMap(map) =>
      TextFormFieldClassModel(className: map['className']);
  Map<String, dynamic> toMap() {
    return {"className": className};
  }
}
