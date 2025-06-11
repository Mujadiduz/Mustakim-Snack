import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mustakim_snack/barang.dart';
import 'package:http/http.dart' as http;
import 'package:mustakim_snack/home_page.dart';

class ProductController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final picker = ImagePicker();
  var isLoading = false.obs;
  var barangList = <Barang>[].obs;
  var nama = RxnString();
  var harga = RxnString();
  var imageUrl = RxnString();
  var keranjang = <Barang>[].obs;
  final formatCurrency = NumberFormat('#,###', 'id_ID');

  late String originalNama;
  late int originalHarga;
  late String originalImageUrl;
  late String documentId;

  @override
  void onInit() {
    super.onInit();
    final barang = Get.arguments as Barang;

    // Simpan data original
    originalNama = barang.nama;
    originalHarga = barang.harga;
    originalImageUrl = barang.imageUrl;
    documentId = barang.id;

    // Isi field observable (biar bisa diubah user)
    nama.value = barang.nama;
    harga.value = barang.harga.toString();
    imageUrl.value = barang.imageUrl;
  }

  // void tambahKeKeranjang(Barang barang) {
  //   bool sudahAda = keranjang.any((item) => item.nama == barang.nama);

  //   if (sudahAda) {
  //     Get.snackbar('Info', '${barang.nama} sudah ada di keranjang');
  //   } else {
  //     keranjang.add(barang);
  //     Get.snackbar('Sukses', '${barang.nama} ditambahkan ke keranjang');
  //     // totalItem.value = keranjang.length;
  //     // totalHarga.value = keranjang.length;
  //   }
  // }

  // double get totalHarga {
  //   return keranjang.fold(0.0, (total, item) => total + item.harga);
  // }

  // int get totalItem {
  //   return keranjang.length;
  // }

 

  Future<void> updateBarang() async {
    final newNama = nama.value ?? '';
    final newHarga = int.tryParse(harga.value ?? '') ?? 0;
    final newImage = imageUrl.value ?? '';

    final isNamaChanged = newNama != originalNama;
    final isHargaChanged = newHarga != originalHarga;
    final isImageChanged = newImage != originalImageUrl;

    if (!isNamaChanged && !isHargaChanged && !isImageChanged) {
      Get.snackbar('Gagal', 'Tidak ada perubahan data');
      return;
    }

    try {
      await firestore.collection('barang').doc(documentId).update({
        'namaBarang': newNama,
        'hargaBarang': newHarga,
        'imageUrl': newImage,
      });
      Get.snackbar('Berhasil', 'Barang berhasil diupdate');
      Get.offAll(() => HomePage());
    } catch (e) {
      Get.snackbar('Error', 'Gagal update data barang');
      print('Error update: $e');
    }
  }

 

  Future<void> uploadImageToCloudinary() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);

    try {
      isLoading.value = true;

      String cloudName = 'dadxyaako';
      String uploadPreset = 'jadid-upload';

      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );

      final req =
          http.MultipartRequest('POST', url)
            ..fields['upload_preset'] = uploadPreset
            ..files.add(
              await http.MultipartFile.fromPath('file', imageFile.path),
            );

      final response = await req.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode != 200) {
        throw Exception('Upload ke Cloudinary gagal');
      }

      final data = json.decode(responseBody);
      print(data);
      final uploadedUrl = data['secure_url'];

      imageUrl.value = uploadedUrl;

      Get.snackbar('Berhasil', 'Gambar berhasil diupload dan disimpan');
    } catch (e) {
      print('$e');
      Get.snackbar('Error', 'Terjadi kesalaha');
    } finally {
      isLoading.value = false;
    }
  }
}
