import 'package:english_order/controllers/cart_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:typed_data';
import 'package:printing/printing.dart';

Future<Uint8List> generatePdf(
    PdfPageFormat format, String title, CartController controll) async {
  final pdf = Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.courierPrimeRegular();

  pdf.addPage(
    Page(
      pageFormat: format,
      build: (context) {
        return Column(
          children: [
            createTable(controll, font),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Total' + totalCartPrice().toStringAsFixed(2) + '\$',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      font: font, fontWeight: FontWeight.bold, fontSize: 20)),
            )
          ],
        );
      },
    ),
  );

  return pdf.save();
}

Widget createTable(CartController controll, Font font) {
  int index = cart().length;
  List<TableRow> rows = [];
  rows.add(
    TableRow(
      children: [
        Text("Quantity", style: TextStyle(font: font)),
        Text("Description", style: TextStyle(font: font)),
        Text("Price", style: TextStyle(font: font)),
        Text("total", style: TextStyle(font: font)),
      ],
    ),
  );
  for (int i = 0; i < index; i++) {
    rows.add(
      TableRow(
        children: [
          Text(cart()[i].quantity.toString(), style: TextStyle(font: font)),
          Text(cart()[i].product!.title.toString(),
              style: TextStyle(font: font)),
          Text(cart()[i].product!.preis.toStringAsFixed(2) + '€',
              style: TextStyle(font: font)),
          Text(
              (cart()[i].product!.preis * cart()[i].quantity)
                      .toStringAsFixed(2) +
                  '\$',
              style: TextStyle(font: font)),
        ],
      ),
    );
  }
  return Table(
      children: rows,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.symmetric(outside: const BorderSide(width: 2)));
}
