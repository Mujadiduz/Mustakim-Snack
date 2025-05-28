import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustakim_snack/create_barang.dart';
import 'package:mustakim_snack/edit_barang.dart';
import 'package:mustakim_snack/homepage_controller.dart';
import 'package:mustakim_snack/keranjang_view.dart';
import 'package:mustakim_snack/product_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomepageController());
    final ProductController controller = Get.put(ProductController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'pasar winongan, pasuruan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => TambahBarangPage()),
            icon: Icon(Icons.add_business, color: Colors.white),
          ),
          IconButton(onPressed: () => Get.to(() => KeranjangView()), icon: Icon(Icons.add_shopping_cart_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.fetchBarang,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: Colors.grey,
                  // controller: homeC.searchC, // asumsi kamu pakai controller dari controller-mu
                  // onChanged: (value) => homeC.filterProduk(value),
                  decoration: InputDecoration(
                    hintText: 'Cari produk...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xff303030),
                      ), // Saat tidak fokus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: const Color(0xff303030),
                        width: 2,
                      ), // Saat fokus
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.red,
              //   height: 100,
              //   child: ListView.builder(
              //     itemCount: 3,
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder:
              //         (context, index) => Padding(
              //           padding: const EdgeInsets.only(left: 5),
              //           child: Container(width: 100, color: Colors.amber),
              //         ),
              //   ),
              // ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Kategori',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ShortingItem(
                    'snack',
                    "https://i.pinimg.com/736x/ea/04/fb/ea04fbb2a6ca2feb62678b4de17ad8b8.jpg",
                  ),
                  ShortingItem(
                    'minuman',
                    "https://i.pinimg.com/736x/2b/9b/b3/2b9bb3aa488ca50ccc4e3dc4c492355c.jpg",
                  ),
                  ShortingItem(
                    'mie instan',
                    "https://i.pinimg.com/736x/c2/ba/38/c2ba38d4f341cfa0501319559b5776eb.jpg",
                  ),
                ],
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Special Offer',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() {
                if (controller.barangList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: Get.height * .34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.barangList.length,
                    itemBuilder: (context, index) {
                      // final data = homeC.product[index];
                      final data = controller.barangList[index];
                      log('id: ${data.id}');
                      return Row(
                        children: [
                          SizedBox(width: index == 0 ? 20 : 0),
                          InkWell(
                            onTap: () {
                              controller.tambahKeKeranjang(data);
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 110,
                                    // width: double.infinity,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(data.imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    data.nama,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${data.harga}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.to(
                                            () => EditBarang(),
                                            arguments: data,
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          await controller.deleteBarang(data.id);
                                          controller.fetchBarang();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                controller.barangList.length - 1 == index
                                    ? 20
                                    : 0,
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
              SizedBox(height: 50),
              Obx(() {
                if (controller.barangList.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  height: Get.height * .34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.barangList.length,
                    itemBuilder: (context, index) {
                      // final data = homeC.product[index];
                      final data = controller.barangList[index];
                      return Row(
                        children: [
                          SizedBox(width: index == 0 ? 20 : 0),
                          Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 110,
                                  // width: double.infinity,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(data.imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  data.nama,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Rp ${data.harga}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width:
                                controller.barangList.length - 1 == index
                                    ? 20
                                    : 0,
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),

              // Expanded(
              //   child: GridView.builder(
              //     itemCount: homeC.product.length,
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //     ),
              //     itemBuilder: (context, index) {
              //       final data = homeC.product[index];
              //       return Card(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               height: 110,
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 color: Colors.black,
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(10),
              //                   topRight: Radius.circular(10),
              //                 ),
              //                 image: DecorationImage(
              //                   image: NetworkImage(data['gambar']),
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(height: 20),
              //             Text(
              //               data['nama'],
              //               style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             Text(
              //               data['harga'],
              //               style: TextStyle(
              //                 fontSize: 20,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Column ShortingItem(String text, String img) {
    return Column(
      children: [
        Card(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(img)),
            ),
          ),
        ),
        Text(text),
      ],
    );
  }
}
