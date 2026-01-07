import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mustakim_snack/home_page.dart';

class BarangController extends GetxController {
  final picker = ImagePicker();
  var imageUrl = ''.obs;
  var isFormValid = false.obs;
  var isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController namaCtrl = TextEditingController();
  final TextEditingController hargaCtrl = TextEditingController();
  final TextEditingController imageCtrl = TextEditingController(); // URL gambar

  @override
  void onInit() {
    super.onInit();
    namaCtrl.addListener(validateForm);
    hargaCtrl.addListener(validateForm);
    ever(imageUrl, (_) => validateForm());
  }

  void validateForm() {
    final namaValid = namaCtrl.text.trim().isNotEmpty;
    final hargaValid =
        int.tryParse(hargaCtrl.text.trim()) != null &&
        int.parse(hargaCtrl.text.trim()) > 0;

    if (imageUrl.isEmpty) {
      // Gambar opsional, tapi nama & harga wajib
      isFormValid.value = namaValid && hargaValid;
    } else {
      // Kalau gambar ada, maka semua wajib
      isFormValid.value = namaValid && hargaValid && imageUrl.isNotEmpty;
    }
  }

  Future<void> addBarang() async {
    try {
      final nama = namaCtrl.text.trim();
      final harga = int.tryParse(hargaCtrl.text.trim()) ?? 0;
      // final imageUrl = imageCtrl.text;
      if (nama.isNotEmpty && imageUrl.isNotEmpty && harga > 0) {
        await FirebaseFirestore.instance.collection('barang').add({
          'namaBarang': nama,
          'hargaBarang': harga,
          'imageUrl': imageUrl.value.isEmpty ? null : imageUrl.value,
          'createdAt': Timestamp.now(),
        });
        print('Barang berhasil ditambahkan');
        Get.snackbar('Sukses', 'Produk berhasil ditambahkan', backgroundColor: Colors.green);
        Get.to(
          () => HomePage(),
        ); // Kembali ke halaman sebelumnya setelah tambah
        // Get.snackbar('Success', 'Success menambahkan ')
        // Get.back();
      } else {
        Get.snackbar('Gagal', 'Isi semua field dengan benar', backgroundColor: Colors.red);
      }
    } catch (e, stackTrace) {
      print('Gagal menambahkan barang: $e');
      print('StackTrace: $stackTrace');
      // Kamu bisa tampilkan error ke user atau log ke service monitoring di sini
      rethrow; // opsional, kalau mau error dilempar lagi
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
