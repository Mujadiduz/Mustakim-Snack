import 'package:adaptive_ticket_view/adaptive_ticket_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/keranjang_controller.dart';

class NotaPage extends StatelessWidget {
  const NotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final keranjangC = Get.find<KeranjangController>();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: AdaptiveTicketView(
            ticketBgColor: Colors.white,
            ticketBorderColor: Colors.grey,
            lineStyle: TicketLineStyle.dotted,
            lineColor: Colors.grey,
            ticketInfoWidget: _buildTicketContent(keranjangC),
            ticketBottomMessage: "Terima kasih telah berbelanja 🙏",
            ticketCode: "MS-001",
          ),
        ),
      ),
    );
  }

  Widget _buildTicketContent(KeranjangController c) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL
          const Center(
            child: Text(
              "MUSTAKIM SNACK",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 4),

          const Center(
            child: Text("NOTA PEMBELIAN", style: TextStyle(fontSize: 14)),
          ),

          const SizedBox(height: 12),
          const Divider(),

          // HEADER STRUK
          _rowHeader(),

          const Divider(),

          // LIST ITEM
          Column(
            children: List.generate(c.keranjang.length, (index) {
              final item = c.keranjang[index];
              print('ini harga: ${item.harga}');
              return _rowItem(item.nama, item.harga);
            }),
          ),

          const Divider(),

          // TOTAL
          _rowTotal(c.totalHarga.toInt()),

          const SizedBox(height: 12),

          const Center(
            child: Text(
              "Barang yang sudah dibeli\n"
              "tidak dapat dikembalikan",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      );
    });
  }

  Widget _rowHeader() {
    return const Row(
      children: [
        Expanded(
          child: Text("Item", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        // Expanded(
        //   flex: 1,
        //   child: Text(
        //     "Qty",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        // ),
        Text(
          "Harga",
          textAlign: TextAlign.right,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _rowItem(String nama, int harga) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(nama, style: const TextStyle(fontSize: 14)),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Text(
          //     "x$qty",
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(fontSize: 14),
          //   ),
          // ),
          Expanded(
            flex: 2,
            child: Text(
              _rupiah(harga),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // ================================
  Widget _rowTotal(int total) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "TOTAL",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            _rupiah(total),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _rupiah(int value) {
    return "Rp ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}";
  }
}
