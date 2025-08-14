# Dokumentasi Sistem Transaksi dan Pembayaran POS Mobile

## Perubahan Major

Sistem telah diubah dari sistem transaksi langsung menjadi sistem order-payment yang terpisah. Berikut adalah alur kerja yang baru:

### Alur Kerja Baru

1. **Buat Pesanan (Create Order)**

   - Pilih produk dan tambahkan ke cart
   - Klik FAB "Buat Pesanan"
   - Masukkan detail pelanggan (nama, nomor meja, tipe layanan)
   - Pesanan dibuat dengan status "pending"

2. **Kelola Pesanan Pending**

   - Lihat semua pesanan pending di sidebar kanan
   - Edit pesanan jika diperlukan (ubah quantity, note, atau hapus item)
   - Status tetap "pending" sampai dibayar

3. **Proses Pembayaran**
   - Pilih pesanan yang akan dibayar (bisa satu atau beberapa sekaligus)
   - Pilih metode pembayaran
   - Untuk cash: masukkan jumlah uang diterima
   - Pesanan otomatis berubah status menjadi "completed"

### API Endpoints Yang Digunakan

#### Transaksi Management

- `POST /api/transactions` - Buat transaksi baru
- `PUT /api/transactions/{id}` - Edit transaksi existing
- `GET /api/transactions` - Ambil transaksi dengan status pending
- `GET /api/all-transactions` - Ambil semua transaksi (untuk history)

#### Payment Management

- `GET /api/payments` - Ambil riwayat pembayaran
- `POST /api/payment-settle` - Settle pembayaran untuk transaksi

### Struktur Model Baru

#### Create Transaction Request

```json
{
  "table_id": 2,
  "customer_name": "Indra",
  "user_id": 13,
  "service_type": "dine_in",
  "details": [
    {
      "product_id": 2,
      "quantity": 2,
      "note": "Tanpa bawang",
      "flavor_id": 1,
      "spicy_level_id": 2
    }
  ]
}
```

#### Payment Settle Request

```json
{
  "payment_method_id": 1,
  "transaction_ids": [77, 79],
  "tendered_amount": 100000,
  "note": "Bayar bareng Budi & Sari"
}
```

### Fitur UI Baru

#### ProductMainPage

- **Sidebar kanan**: Menampilkan pending orders
- **FAB dinamis**: Muncul ketika ada item di cart
- **Edit order**: Dialog untuk mengubah detail pesanan
- **Payment dialog**: Interface untuk memproses pembayaran

#### Pending Orders Widget

- List semua pesanan pending
- Tombol edit dan bayar untuk setiap pesanan
- Real-time update ketika ada perubahan

#### Payment Dialogs

- **Create Order Dialog**: Form input detail pelanggan
- **Payment Dialog**: Interface pembayaran multi-transaksi
- **Edit Transaction Dialog**: Form edit pesanan existing

### State Management

#### New Blocs

- **PendingTransactionBloc**: Mengelola CRUD transaksi pending
- **PaymentSettlementBloc**: Mengelola proses pembayaran

#### Events

- `PendingTransactionEvent.createTransaction`
- `PendingTransactionEvent.editTransaction`
- `PendingTransactionEvent.fetchPendingTransactions`
- `PaymentSettlementEvent.settlePayment`
- `PaymentSettlementEvent.fetchPayments`

### Benefits

1. **Separated Concerns**: Order dan payment dipisah
2. **Better Tracking**: Status pesanan yang jelas
3. **Flexible Payment**: Bisa bayar satu atau gabung beberapa pesanan
4. **Edit Capability**: Pesanan bisa diedit sebelum dibayar
5. **Payment History**: Riwayat pembayaran yang detail

### Migration Notes

- Model `TransactionModelRequest` lama masih ada untuk backward compatibility
- Repository diperluas dengan method baru tanpa breaking existing
- UI di-refactor untuk mendukung workflow baru
- BlocProvider baru ditambahkan di main.dart

### Testing

Untuk testing fitur baru:

1. Jalankan aplikasi
2. Tambah beberapa produk ke cart
3. Klik "Buat Pesanan" dan isi form
4. Lihat pesanan muncul di sidebar
5. Edit pesanan jika perlu
6. Proses pembayaran
7. Cek riwayat pembayaran

### Future Enhancements

- [ ] Notifikasi real-time untuk kitchen
- [ ] Print receipt setelah payment
- [ ] Multi-table management
- [ ] Inventory tracking integration
- [ ] Advanced reporting per payment period
