import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:mustakim_snack/keranjang_controller.dart';
import 'package:mustakim_snack/product_controller.dart';

class KeranjangView extends StatelessWidget {
  const KeranjangView({super.key});

  @override
  Widget build(BuildContext context) {
    final keranjangC = Get.find<KeranjangController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: keranjangC.keranjang.length,
                itemBuilder: (context, index) {
                  final data = keranjangC.keranjang[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: index == 0 ? 20 : 0),
                      InkWell(
                        onTap: () {
                          keranjangC.tambahKeKeranjang(data);
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
                              // Row(
                              //   children: [
                              //     IconButton(
                              //       onPressed: () {
                              //         Get.to(() => EditBarang(), arguments: data);
                              //       },
                              //       icon: Icon(Icons.edit),
                              //     ),
                              //     IconButton(
                              //       onPressed: () async {
                              //         await homeC.deleteBarang(data.id);
                              //         homeC.fetchBarang();
                              //       },
                              //       icon: Icon(Icons.delete, color: Colors.red),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: keranjangC.keranjang.length - 1 == index ? 20 : 0,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                Text('total item:'),
                Spacer(),
                Text('${keranjangC.totalItem}'),
              ],
            ),
            Row(
              children: [
                Text('total harga:'),
                Spacer(),
                Text(keranjangC.formatCurrency.format(keranjangC.totalHarga)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('BAYAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
