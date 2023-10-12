import 'dart:convert';

class TreatmentModel {
  String? id;
  final String jenistreatment;
  final String harga;
  TreatmentModel({
    this.id,
    required this.jenistreatment,
    required this.harga,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jenistreatment': jenistreatment,
      'harga': harga,
    };
  }

  factory TreatmentModel.fromMap(Map<String, dynamic> map) {
    return TreatmentModel(
      id: map['id'],
      jenistreatment: map['jenistreatment'] ?? '',
      harga: map['harga'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TreatmentModel.fromJson(String source) =>
      TreatmentModel.fromMap(json.decode(source));
}
