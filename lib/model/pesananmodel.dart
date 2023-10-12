import 'dart:convert';

class PesananModel {
  String? id;
  final String selectedDate;
  final String namapemilik;
  final String notelepon;
  final String sepatu;
  final String harga;
  final String status;
  final String listitem;
  PesananModel({
    this.id,
    required this.selectedDate,
    required this.namapemilik,
    required this.notelepon,
    required this.sepatu,
    required this.harga,
    required this.status,
    required this.listitem,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'selectedDate': selectedDate,
      'namapemilik': namapemilik,
      'notelepon': notelepon,
      'sepatu': sepatu,
      'harga': harga,
      'status': status,
      'listitem': listitem,
    };
  }

  factory PesananModel.fromMap(Map<String, dynamic> map) {
    return PesananModel(
      id: map['id'],
      selectedDate: map['selectedDate'] ?? '',
      namapemilik: map['namapemilik'] ?? '',
      notelepon: map['notelepon'] ?? '',
      sepatu: map['sepatu'] ?? '',
      harga: map['harga'] ?? '',
      status: map['status'],
      listitem: map['listitem'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PesananModel.fromJson(String source) =>
      PesananModel.fromMap(json.decode(source));
}
