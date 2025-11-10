Nama: Mirza Radithya Ramadhana<br>
Kelas: PBP - B<br>
NPM: 2406405563

## Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements
### 1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
`Navigator.push()` akan menambahkan (menumpuk) halaman baru di atas stack. Artinya, halaman sebelumnya tetap tersimpan, sehingga pengguna masih bisa kembali ke halaman sebelumnya. Sementara, `Navigator.pushReplacement()` akan mengganti halaman paling atas di stack dengan halaman baru. Jadi, halaman sebelumnya dihapus dari stack, sehingga pengguna tidak bisa kembali ke halaman tersebut.

`Navigator.push()` bagus digunakan jika halaman sebelumnya masih diperlukan, seperti saat memencet tombol Add Product dari main page. `Navigator.pushReplacement()` bagus jika halaman lama sudah tidak perlu diakses lagi, seperti berpindah halaman via drawer.

-----

### 2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?

Setiap halaman pada tugas saya menggunakan `Scaffold` sebagai kerangka utama, dengan `AppBar` di bagian atas. Saya juga memanfaatkan `left_drawer.dart` sebagai Drawer dari setiap `Scaffold` di tiap halaman agar tampilan dan navigasi aplikasi tetap konsisten. Dengan membuat komponen `Drawer` terpisah, saya tidak perlu menulis ulang di setiap halaman. Saya cukup memanggil `LeftDrawer()` di properti drawer milik Scaffold. Hal ini membuat semua halaman memiliki struktur yang mirip dan membuat tiap halaman konsisten.

-----

### 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
`Padding` digunakan untuk memberi jarak antar elemen form agar tampilan lebih rapi dan tidak saling menempel.<br>
Contoh yang saya gunakan:
```dart
Padding(
  padding: EdgeInsets.all(8.0),
  ...
)
```


`SingleChildScrollView` digunakan agar form dapat di-scroll, sehingga pengguna tetap bisa mengisi seluruh form tanpa terpotong layar.<br>
Contoh yang saya gunakan:
```dart
SingleChildScrollView(
  child: Column(
    ...
  ),
)
```

`ListView` saya gunakan pada Left Drawer untuk menampilkan daftar menu navigasi secara vertikal dan dapat di-*scroll* jika kontennya melebihi tinggi layar.<br>
Contohnya yang saya gunakan:
```dart
Drawer(
  child: ListView(
    children: [
      DrawerHeader(...),
      ListTile(
        leading: Icon(Icons.home_outlined),
        title: Text('Home'),
        onTap: () { ... },
      ),
      ListTile(
        leading: Icon(Icons.add_box_outlined),
        title: Text('Add Product'),
        onTap: () { ... },
      ),
    ],
  ),
)
```

-----

### 4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Saya menggunakan `ColorScheme` pada `ThemeData` di `main.dart` untuk menentukan warna tema aplikasi saya. Dalam aplikasi saya, warna utama (`primary`) menggunakan kode `Color(0xFF172554)` (biru tua) dan warna sekunder (`secondary`) menggunakan `Color(0xFF2563EB)` (biru terang).
Warna-warna dari ColorScheme ini kemudian digunakan secara konsisten di seluruh aplikasi.<br>
Contoh pemakaian di kode saya:
```dart
appBar: AppBar(
  ...
  backgroundColor: Theme.of(context).colorScheme.primary,
  ...
)
```

-----

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