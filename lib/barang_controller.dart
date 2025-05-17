import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BarangController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addBarang(String nama, int harga, String imageUrl) async {
    try {
      await firestore.collection('barang').add({
        'namaBarang': nama,
        'hargaBarang': harga,
        'imageBarang': imageUrl,
      });
      print('Barang berhasil ditambahkan');
    } catch (e, stackTrace) {
      print('Gagal menambahkan barang: $e');
      print('StackTrace: $stackTrace');
      // Kamu bisa tampilkan error ke user atau log ke service monitoring di sini
      rethrow; // opsional, kalau mau error dilempar lagi
    }
  }
}