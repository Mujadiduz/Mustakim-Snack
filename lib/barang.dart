import 'package:cloud_firestore/cloud_firestore.dart';

class Barang {
  final String id;
  final String nama;
  final int harga;
  final String imageUrl;

  Barang({
    required this.id,
    required this.nama,
    required this.harga,
    required this.imageUrl,
  });

  factory Barang.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Barang(
      id: doc.id,
      nama: data['namaBarang'] ?? '',
      harga: data['hargaBarang'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}