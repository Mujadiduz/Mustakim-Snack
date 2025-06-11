import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/barang_controller.dart';

class TambahBarangPage extends StatelessWidget {
  final BarangController controller = Get.put(BarangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => ElevatedButton.icon(
                onPressed:
                    controller.isLoading.value
                        ? null // Tombol disable kalau sedang upload
                        : controller.uploadImageToCloudinary,
                icon: Icon(Icons.image),
                label: Text(
                  controller.isLoading.value ? 'Uploading...' : 'Kirim Gambar',
                ),
              ),
            ),

            TextField(
              controller: controller.namaCtrl,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: controller.hargaCtrl,
              decoration: InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isFormValid.value ? controller.addBarang : null,
                child: Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
