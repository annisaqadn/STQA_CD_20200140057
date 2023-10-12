import 'dart:convert';

class PengeluaranModel {
  String? id;
  final String selectedDate;
  final String namabarang;
  final String hargabarang;
  PengeluaranModel({
    this.id,
    required this.selectedDate,
    required this.namabarang,
    required this.hargabarang,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'selectedDate': selectedDate,
      'namabarang': namabarang,
      'hargabarang': hargabarang,
    };
  }

  factory PengeluaranModel.fromMap(Map<String, dynamic> map) {
    return PengeluaranModel(
      id: map['id'],
      selectedDate: map['selectedDate'] ?? '',
      namabarang: map['namabarang'] ?? '',
      hargabarang: map['hargabarang'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PengeluaranModel.fromJson(String source) =>
      PengeluaranModel.fromMap(json.decode(source));
}
