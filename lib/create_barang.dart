import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/barang_controller.dart';
import 'package:mustakim_snack/home_page.dart';
import 'package:mustakim_snack/product_view.dart';

class TambahBarangPage extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController hargaCtrl = TextEditingController();
  final TextEditingController imageCtrl = TextEditingController(); // URL gambar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaCtrl,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: hargaCtrl,
              decoration: InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: imageCtrl,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final nama = namaCtrl.text;
                final harga = int.tryParse(hargaCtrl.text) ?? 0;
                final imageUrl = imageCtrl.text;

                if (nama.isNotEmpty && imageUrl.isNotEmpty && harga > 0) {
                  controller.addBarang(nama, harga, imageUrl);
                  Get.to(()=>HomePage()); // Kembali ke halaman sebelumnya setelah tambah
                } else {
                  Get.snackbar('Gagal', 'Isi semua field dengan benar');
                }
              },
              child: Text('Simpan Barang'),
            ),
          ],
        ),
      ),
    );
  }
}