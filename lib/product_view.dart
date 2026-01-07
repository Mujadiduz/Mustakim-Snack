import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/product_controller.dart';

class ListBarangPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Barang')),
      body: Obx(() {
        if (controller.barangList.isEmpty) {
          return Center(child: Text('Belum ada barang'));
        }

        return ListView.builder(
          itemCount: controller.barangList.length,
          itemBuilder: (context, index) {
            final barang = controller.barangList[index];
            return ListTile(
              leading: Image.network(barang.imageUrl, width: 50, height: 50),
              title: Text(barang.nama),
              subtitle: Text('Rp ${barang.harga}'),
            );
          },
        );
      }),
    );
  }
}