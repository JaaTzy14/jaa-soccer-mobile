Nama: Mirza Radithya Ramadhana<br>
Kelas: PBP - B<br>
NPM: 2406405563

## Tugas 7: Elemen Dasar Flutter
### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
**Widget tree** adalah struktur dari seluruh widget dalam aplikasi Flutter. Setiap elemen di layar (seperti teks dan tombol) merupakan bagian dari widget tree. Setiap widget membentuk struktur **parent-child**.

*Parent widget* adalah elemen yang berfungsi sebagai pembungkus dan pengatur layout, sedangkan *child widget* adalah elemen yang berada di dalam parent tersebut dan akan ditampilkan sesuai pengaturan dari parentnya.

Contoh yang saya pakai:
```dart
MaterialApp(
    title: 'Jaa Soccer',
    theme: ThemeData(
        colorScheme: ColorScheme.light(
            primary: Color(0xFF172554),
            secondary: Color(0xFF2563EB),
        ),
        useMaterial3: true,
    ),
    home: MyHomePage(),
);
```

`MaterialApp` adalah parent dari `ThemeData`.

-----

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

Berikut widget-widget yang saya gunakan dan fungsinya:

  * `MaterialApp`: **root** yang menyediakan tema dan navigasi.
  * `Scaffold`: **Kerangka utama halaman** (app bar, body, dan sebagainya).
  * `AppBar`: Bagian atas halaman,
  * `Column`: Menyusun widget secara **vertikal**.
  * `Row`: Menyusun widget secara **horizontal**.
  * `InfoCard`: **Widget buatan** untuk menampilkan nama, NPM, dan kelas dalam bentuk card.
  * `Card`: Memberi tampilan seperti **kartu**.
  * `GridView.count`: Menampilkan `ItemCard` dalam bentuk **grid 3 kolom**.
  * `ItemCard`: **Widget buatan** yang menampilkan ikon, teks, dan warna background dari list `ItemHomepage`.
  * `Material`: Memberi efek **Material Design** pada setiap card.
  * `InkWell`: Memberi efek **klik** saat ditekan.
  * `SnackBar`: Menampilkan **notifikasi** (seperti toast) setelah tombol ditekan.
  * `Icon` dan `Text`: Menampilkan **ikon dan tulisan** di dalam setiap item.
  * `SizedBox`, `Padding`, `Container`, `Center`: Widget **layout** untuk mengatur posisi dan jarak antar elemen.

-----

### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

`MaterialApp` adalah widget utama yang menjadi **root** dari aplikasi Flutter berbasis Material Design.

Fungsi: 
  * Menyediakan *Theme* dan *ColorScheme* aplikasi.
  * Mengatur navigasi antar halaman.
  * Memberi judul aplikasi.

-----

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?

**`StatelessWidget`:**

  * Tidak memiliki *state* (data yang berubah).
  * Tampilan tetap selama aplikasi berjalan.

**`StatefulWidget`:**

  * Memiliki *state* yang dapat berubah.
  * Ketika data berubah, `build()` akan dipanggil untuk memperbarui tampilan.

**Kapan digunakan:**

  * Gunakan `StatelessWidget` jika tampilan **tidak berubah** (seperti gambar atau judul).
  * Gunakan `StatefulWidget` jika tampilan **berubah** berdasarkan interaksi pengguna atau data baru (seperti field input).

-----

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

`BuildContext` adalah objek yang menjadi **alamat widget di dalam widget tree**. Objek ini dapat memberikan akses ke widget parent.

Contoh yang saya pakai:

```dart
ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
    );
```
`BuildContext` digunakan untuk mencari `Scaffold` terdekat dan menampilkan `SnackBar` ketika tombol pada `ItemCard` ditekan

-----

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

`Hot Reload` adalah fitur untuk memperbarui tampilan aplikasi **tanpa kehilangan state**. Prosesnya cepat karena tidak menjalankan ulang aplikasi. Sedangkan, `Hot Restart` adalah fitur untuk menjalankan ulang seluruh aplikasi dari awal. Fitur ini menyebabkan **state hilang** dan aplikasi dimulai dari kondisi awal.