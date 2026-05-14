class StudentInfoModel {
  StudentInfoModel({
    required this.childrenName,
    required this.className,
  });

  final List<String> childrenName;
  final List<String> className;

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      childrenName: json["children_name"] == null
          ? []
          : List<String>.from(json["children_name"]!.map((x) => x)),
      className: json["class_name"] == null
          ? []
          : List<String>.from(json["class_name"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "children_name": childrenName.map((x) => x).toList(),
        "class_name": className.map((x) => x).toList(),
      };
}
