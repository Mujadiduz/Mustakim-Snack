import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/barang.dart';

class HomepageController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var barangList = <Barang>[].obs;
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

   Future<void> deleteBarang(String id) async {
    await firestore.collection('barang').doc(id).delete();
  }
}
