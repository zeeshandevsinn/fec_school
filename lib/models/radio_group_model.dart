class RadioGroupModel {
  String label;
  String value;
  bool selected;

  RadioGroupModel(
      {required this.label, required this.value, required this.selected});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'value': value,
      'selected': selected,
    };
  }

  factory RadioGroupModel.fromMap(Map<String, dynamic> map) {
    return RadioGroupModel(
      label: map['label'],
      value: map['value'],
      selected: map['selected'] ?? false,
    );
  }
}
