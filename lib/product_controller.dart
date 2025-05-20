import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mustakim_snack/barang.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var barangList = <Barang>[].obs;
  var nama = RxnString();
  var harga = RxnString();
  var imageUrl = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
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
