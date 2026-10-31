import 'package:flutter/material.dart';

class ReceiptPreviewScreen extends StatelessWidget {
  final String transactionNumber;
  final String date;
  final String type;
  final String productName;
  final String sku;
  final String quantity;
  final String status;

  const ReceiptPreviewScreen({
    super.key,
    required this.transactionNumber,
    required this.date,
    required this.type,
    required this.productName,
    required this.sku,
    required this.quantity,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isInbound = type == 'Stok Masuk';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF202124),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pratinjau Struk',
          style: TextStyle(
            color: Color(0xFF202124),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8EF),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFF20B968),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaksi Berhasil',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF168A4D),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Struk transaksi berhasil dibuat.',
                            style: TextStyle(
                              fontSize: 9,
                              color: Color(0xFF5F7568),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _receiptPaper(isInbound),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Struk siap untuk dicetak.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.print_outlined,
                    size: 19,
                  ),
                  label: const Text(
                    'Cetak Struk',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF587B55),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF587B55),
                    side: const BorderSide(
                      color: Color(0xFFD8E2D6),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Riwayat',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptPaper(bool isInbound) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFF101914),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                'stock.co',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF101914),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
            'SMART WAREHOUSE & INVENTORY',
            style: TextStyle(
              fontSize: 7,
              letterSpacing: 0.8,
              color: Color(0xFF8B93A1),
            ),
          ),
          const SizedBox(height: 18),
          const Divider(height: 1),
          const SizedBox(height: 14),
          Text(
            type.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isInbound
                  ? const Color(0xFF18A96B)
                  : const Color(0xFFFF5964),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            transactionNumber,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202124),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF8B93A1),
            ),
          ),
          const SizedBox(height: 17),
          const Divider(height: 1),
          const SizedBox(height: 14),
          _row('Barang', productName),
          _row('SKU', sku),
          _row('Jumlah', quantity),
          _row('Status', status),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Terima kasih. Simpan struk ini sebagai bukti transaksi gudang.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                height: 1.4,
                color: Color(0xFF777F89),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: Color(0xFF8B93A1),
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF8B93A1),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: Color(0xFF30343B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
