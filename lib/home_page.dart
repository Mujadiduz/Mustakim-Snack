import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mustakim_snack/homepage_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomepageController());
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
      ),
      body: Column(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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

          Expanded(
            child: GridView.builder(
              itemCount: homeC.product.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final data = homeC.product[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(data['gambar']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        data['nama'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['harga'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
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
