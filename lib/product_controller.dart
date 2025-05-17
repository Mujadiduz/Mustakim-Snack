import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mustakim_snack/barang.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBarang();
  }

  void fetchBarang() async {
    try {
      final snapshot = await firestore.collection('barang').get();
      final items = snapshot.docs.map((doc) => Barang.fromFirestore(doc)).toList();
      barangList.value = items;
    } catch (e) {
      print('Gagal ambil data barang: $e');
    }
  }
}