class Caregiver {
  final int? id;
  final String name;
  final String phoneNumber;
  final bool isPrimary;

  const Caregiver({
    this.id,
    required this.name,
    required this.phoneNumber,
    this.isPrimary = false,
  });

  Caregiver copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    bool? isPrimary,
  }) {
    return Caregiver(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.trim(),
      'phoneNumber': phoneNumber.trim(),
      'isPrimary': isPrimary ? 1 : 0,
    };
  }

  factory Caregiver.fromMap(Map<String, dynamic> map) {
    return Caregiver(
      id: map['id'] as int?,
      name: (map['name'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      isPrimary: ((map['isPrimary'] ?? 0) as int) == 1,
    );
  }
}