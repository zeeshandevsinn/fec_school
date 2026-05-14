class DropDownModel {
  String label;
  String value;
  bool selected;

  DropDownModel(
      {required this.label, required this.value, required this.selected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
      'selected': selected,
    };
  }

  factory DropDownModel.fromMap(Map<String, dynamic> map) {
    return DropDownModel(
      label: map['label'],
      value: map['value'],
      selected: map['selected'] ?? false,
    );
  }
}
