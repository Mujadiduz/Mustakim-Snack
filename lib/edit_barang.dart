import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/barang.dart';
import 'package:mustakim_snack/barang_controller.dart';
import 'package:mustakim_snack/home_page.dart';
import 'package:mustakim_snack/product_controller.dart';
import 'package:mustakim_snack/product_view.dart';

class EditBarang extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final Barang data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              // controller: namaCtrl,
              onChanged: (value) => controller.nama.value = value,
              initialValue: data.nama,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextFormField(
              // controller: hargaCtrl
              onChanged: (value) => controller.harga.value = value,
              initialValue: data.harga.toString(),
              decoration: InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              // controller: imageCtrl
              onChanged: (value) => controller.imageUrl.value = value,
              initialValue: data.imageUrl,
              decoration: InputDecoration(labelText: 'URL Gambar'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final nama = controller.nama.value ?? data.nama;
                final harga = controller.harga.value ?? data.harga.toString();
                // int.tryParse(
                  
                // );
                final imageUrl =
                    controller.imageUrl.value ?? data.imageUrl;
                final id = data.id;

                log('ini namanya: $nama');
                log('ini harga: $harga');
                log('ini imageUrl: $imageUrl');

                if (nama.isNotEmpty || imageUrl.isNotEmpty || harga.isNotEmpty) {
                  controller.updateBarang(nama, int.tryParse(harga), imageUrl, id);
                  Get.to(
                    () => HomePage(),
                  ); // Kembali ke halaman sebelumnya setelah tambah
                } else {
                  Get.snackbar(
                    'Gagal',
                    'Tidak ada data yang berubah, silahkan diubah datanya',
                  );
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
