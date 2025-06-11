import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mustakim_snack/barang.dart';

class KeranjangController extends GetxController {
  var keranjang = <Barang>[].obs;
  final formatCurrency = NumberFormat('#,###', 'id_ID');
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
}
