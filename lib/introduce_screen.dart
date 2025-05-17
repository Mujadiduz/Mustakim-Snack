import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mustakim_snack/create_barang.dart';
import 'package:mustakim_snack/home_page.dart';

class IntroduceScreen extends StatelessWidget {
  const IntroduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            child: Image.network(
              'https://i.pinimg.com/736x/ee/c0/33/eec0336d41170c4fd920447b50683baf.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                left: 50,
              ), // atur nilai ini sesuai kebutuhan
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Container(
                  decoration: BoxDecoration(
                color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Mustakim Snack',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bebasNeue(textStyle: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold,)),
                      // style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 50,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600),
            child: Container(
              // color: Colors.green,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Selamat Datang di Mustakim Aneka Snack',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoCondensed(textStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold,)),
                        // style: TextStyle(
                        //   color: Colors.black,
                        //   fontSize: 30,
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => TambahBarangPage());
                      },
                      child: Text(
                        'Pesan Sekarang',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
