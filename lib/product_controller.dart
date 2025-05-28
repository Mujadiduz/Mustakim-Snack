import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:mustakim_snack/barang.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var barangList = <Barang>[].obs;
  var nama = RxnString();
  var harga = RxnString();
  var imageUrl = RxnString();
  var keranjang = <Barang>[].obs;
  final formatCurrency = NumberFormat('#,###', 'id_ID');

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
  }

  void tambahKeKeranjang(Barang barang) {
    bool sudahAda = keranjang.any((item) => item.nama == barang.nama);

    if (sudahAda) {
      Get.snackbar('Info', '${barang.nama} sudah ada di keranjang');
    } else {
      keranjang.add(barang);
      Get.snackbar('Sukses', '${barang.nama} ditambahkan ke keranjang');
      // totalItem.value = keranjang.length;
      // totalHarga.value = keranjang.length;
    }
  }

  double get totalHarga {
    return keranjang.fold(0.0, (total, item) => total + item.harga);
  }

  int get totalItem {
    return keranjang.length;
  }

  Future<void> fetchBarang() async {
    try {
      final snapshot =
          await firestore
              .collection('barang')
              .orderBy('createdAt', descending: true)
              .get();
      final items =
          snapshot.docs.map((doc) => Barang.fromFirestore(doc)).toList();
      barangList.value = items;
    } catch (e) {
      print('Gagal ambil data barang: $e');
    }
  }

  Future<void> updateBarang(
    String? nama,
    int? harga,
    String? url,
    String? id,
  ) async {
    try {
      await firestore.collection('barang').doc(id).update({
        'namaBarang': nama,
        'hargaBarang': harga,
        'imageBarang': url,
        // ... field lainnya
      });
    } catch (e) {
      print('Gagal update barang: $e');
    }
  }

  Future<void> deleteBarang(String id) async {
    await firestore.collection('barang').doc(id).delete();
  }
}
