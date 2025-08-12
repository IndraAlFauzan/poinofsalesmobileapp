import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posmobile/data/model/response/transaction_mode_response.dart';
import 'package:posmobile/shared/widgets/fortmat_datetime.dart';
import 'package:posmobile/shared/widgets/idr_format.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionTebelData extends DataGridSource {
  List<DataGridRow> _transactionData = [];
  final BuildContext context;
  final List<Transaction> transactions;

  TransactionTebelData(this.transactions, this.context) {
    _transactionData = transactions.asMap().entries.map<DataGridRow>((entry) {
      final transaction = entry.value;

      return DataGridRow(
        cells: [
          //DataGridCell(columnName: "No", value: entry.key + 1),
          DataGridCell<String>(
            columnName: 'ID',
            value: '#${transaction.transactionId}',
          ),
          DataGridCell<String>(
            columnName: 'Tanggal',
            value: formatDateTime(transaction.createdAt.toIso8601String()),
          ),
          DataGridCell<String>(columnName: 'Name', value: transaction.nameUser),

          DataGridCell<String>(
            columnName: 'Total Harga',
            value: idrFormat(transaction.total.toString()),
          ),

          DataGridCell<String>(
            columnName: 'Payment',
            value: transaction.paymentMethod,
          ),
          //Ubah ke huruf besar di awal kata dan hilangkan _ di antara kata

          //icon button untuk menampilkan detail transaksi
          DataGridCell<IconButton>(
            columnName: 'Detail',
            value: IconButton(
              icon: Icon(
                Icons.info_outline,
                size: 20,
              ), // Ukuran ikon lebih kecil agar sejajar
              padding: EdgeInsets
                  .zero, // Hapus padding default yang menyebabkan pergeseran
              constraints: BoxConstraints(),
              onPressed: () {
                //Pakai showDialog untuk menampilkan detail transaksi

                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('Detail Transaksi'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ID: #${transaction.transactionId}'),
                          SizedBox(height: 8),
                          //format tanggal, jam , tanggal, bulan, tahun
                          Text(
                            'Tanggal: ${formatDateTime(transaction.createdAt.toIso8601String())}',
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 8),

                          Text('Name: ${transaction.nameUser}'),
                          SizedBox(height: 8),
                          Text(
                            'Uang Bayar: ${idrFormat(transaction.paymentAmount.toString())}',
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Total Harga: ${idrFormat(transaction.total.toString())}',
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kembalian: ${idrFormat(transaction.changeAmount.toString())}',
                          ),
                          SizedBox(height: 8),
                          Text('Payment: ${transaction.paymentMethod}'),
                          SizedBox(height: 8),
                          Text(
                            'Tipe Service: ${transaction.serviceType.split('_').map((e) => e[0].toUpperCase() + e.substring(1)).join(' ')}',
                          ),
                          SizedBox(height: 16),
                          Text('Detail Pesanan:'),
                          SizedBox(height: 8),
                          ...transaction.details.map(
                            (detail) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Menu: ${detail.nameProduct}'),
                                SizedBox(height: 4),
                                Text('Jumlah: ${detail.quantity}'),
                                SizedBox(height: 4),
                                if (detail.flavor != null)
                                  Column(
                                    children: [
                                      Text('Rasa: ${detail.flavor}'),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                if (detail.spicyLevel != null)
                                  Column(
                                    children: [
                                      Text('Level Pedas: ${detail.spicyLevel}'),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                if (detail.note != null &&
                                    detail.note!.isNotEmpty)
                                  Column(
                                    children: [
                                      Text('Catatan: ${detail.note}'),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                Text(
                                  'Total Harga: ${idrFormat(detail.subtotal.toString())}',
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _transactionData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final rowIndex = _transactionData.indexOf(row);
    final isEvenRow = rowIndex % 2 == 0;
    final isFirstRow = rowIndex == 0;
    final isLastRow = rowIndex == _transactionData.length - 1;

    return DataGridRowAdapter(
      cells: row.getCells().asMap().entries.map<Widget>((entry) {
        final int columnIndex = entry.key;
        final dataCell = entry.value;

        // Atur border radius hanya untuk ujung kiri dan kanan
        BorderRadius borderRadius = BorderRadius.zero;
        if (isFirstRow && columnIndex == 0) {
          borderRadius = BorderRadius.only(topLeft: Radius.circular(8));
        } else if (isFirstRow && columnIndex == row.getCells().length - 1) {
          borderRadius = BorderRadius.only(topRight: Radius.circular(8));
        } else if (isLastRow && columnIndex == 0) {
          borderRadius = BorderRadius.only(bottomLeft: Radius.circular(8));
        } else if (isLastRow && columnIndex == row.getCells().length - 1) {
          borderRadius = BorderRadius.only(bottomRight: Radius.circular(8));
        }

        return Container(
          alignment: Alignment
              .center, // Pastikan semua cell memiliki alignment yang sama
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isEvenRow ? Colors.white : Colors.grey.shade100,
            borderRadius: borderRadius,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
          child: dataCell.value is IconButton
              ? SizedBox(
                  width: 24, // Sesuaikan ukuran agar ikon sejajar
                  height: 24,
                  child: dataCell.value,
                )
              : Row(
                  children: [
                    Expanded(
                      child: Text(
                        dataCell.value.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
        );
      }).toList(),
    );
  }
}
