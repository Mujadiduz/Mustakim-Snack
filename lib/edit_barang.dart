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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => ElevatedButton.icon(
                onPressed: controller.isLoading.value
                    ? null
                    : controller.uploadImageToCloudinary,
                icon: Icon(Icons.image),
                label: Text(
                  controller.isLoading.value ? 'Uploading...' : 'Kirim Gambar',
                ),
              ),
            ),
            Obx(() => TextFormField(
              onChanged: (value) => controller.nama.value = value,
              initialValue: controller.nama.value,
              decoration: InputDecoration(labelText: 'Nama Barang'),
            )),
            Obx(() => TextFormField(
              onChanged: (value) => controller.harga.value = value,
              initialValue: controller.harga.value,
              decoration: InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            )),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.updateBarang();
              },
              child: Text('Simpan Barang'),
            ),
          ],
        ),
      ),
    );
  }
}

