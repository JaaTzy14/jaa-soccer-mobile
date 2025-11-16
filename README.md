Nama: Mirza Radithya Ramadhana<br>
Kelas: PBP - B<br>
NPM: 2406405563

## Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter
### 1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Dengan menggunakan model Dart, setiap field dapat memiliki tipe data yang jelas, sehingga compiler dapat melakukan pengecekan tipe sejak awal. Model juga memaksa kita menangani kemungkinan null sesuai aturan null-safety, sehingga mengurangi kemungkinan crash saat runtime. Selain itu, model membuat kode lebih maintainable. Jika kita ingin menambah atau mengubah sebuah field, kita hanya perlu memperbarui satu file model, bukan seluruh bagian aplikasi yang menggunakan data tersebut.

Hal-hal seperti kejelasan tipe, null-safety, dan kemudahan pemeliharaan ini tidak diperoleh jika kita menggunakan `Map<String, dynamic>`, karena Map bersifat bebas tipe, rawan typo, dan error baru muncul saat runtime, bukan saat compile.

-----

### 2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
`http` digunakan untuk melakukan HTTP request seperti GET, POST, dan DELETE. Sementara itu, `CookieRequest` digunakan untuk menyimpan dan mengelola cookie session Django. Jadi, `http` berfungsi untuk mengakses endpoint biasa, sedangkan `CookieRequest` digunakan untuk endpoint yang memerlukan session, seperti autentikasi.

-----

### 3.  Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Instance `CookieRequest` perlu dibagikan ke semua komponen agar seluruh komponen aplikasi menggunakan session yang sama. Keuntungan utama `CookieRequest` adalah menyimpan cookie session Django, sehingga backend dapat mengenali user yang sudah login. Jika setiap komponen membuat instance sendiri, masing-masing akan memiliki session berbeda dan autentikasi tidak akan berjalan.

-----

### 4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
`10.0.2.2` harus ditambahkan pada `ALLOWED_HOSTS` karena emulator Android Flutter menggunakan alamat tersebut untuk mengakses localhost. Jika tidak ditambahkan, Django akan menganggap request dari Flutter tidak sah karena host tidak terdaftar. `CORS` dan pengaturan `SameSite/cookie` juga diperlukan agar aplikasi Django dapat berbagi resource dan mengirim cookie ke aplikasi Flutter yang berasal dari origin berbeda. Tanpa pengaturan ini, aplikasi web dan mobile tidak dapat saling berkomunikasi. Selain itu, izin akses internet pada Android diperlukan agar aplikasi Flutter dapat melakukan request ke backend Django atau database online lainnya. Tanpa izin ini, aplikasi tidak dapat mengambil data dari internet.

-----

### 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Ketika pengguna mengisi form pembuatan produk dan menekan tombol submit, Flutter akan membaca state dari setiap field pada form tersebut. Setelah itu, Flutter mengirimkan data tersebut ke backend Django melalui sebuah HTTP POST request. Di Django, data diterima oleh `views.py`, divalidasi, lalu disimpan ke database.

Setelah data berhasil tersimpan, Flutter dapat menampilkannya kembali. Saat halaman daftar produk dibuka, Flutter mengirim HTTP GET request ke endpoint Django untuk mengambil seluruh data produk terbaru. Django mengembalikan data dalam bentuk JSON, dan Flutter akan memproses JSON tersebut menjadi model Dart lalu merendernya sebagai card produk.

-----

### 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Saat aplikasi Flutter dibuka, pengguna diminta untuk login. Jika belum memiliki akun, pengguna dapat menuju halaman register. Pada halaman register, pengguna mengisi data yang diperlukan dan menekan tombol register. Flutter kemudian mengirimkan HTTP POST request ke backend Django. Django memvalidasi data tersebut, dan jika valid, akun baru akan disimpan ke database.

Setelah akun berhasil dibuat, pengguna dapat melakukan login. Flutter akan mengirim HTTP POST request berisi username dan password ke Django. Django memvalidasi input tersebut. Jika benar, Django akan membuat cookie session dan mengembalikan informasi autentikasi tersebut ke Flutter melalui `CookieRequest`. Cookie ini digunakan untuk menandai bahwa pengguna telah login.

Setelah Flutter menerima session dari Django, aplikasi akan menampilkan halaman menu utama. Ketika pengguna ingin logout, pengguna dapat melakukannya melalui left drawer. Flutter akan mengirim HTTP POST request logout ke Django. Django kemudian menghapus session pengguna, dan Flutter mengarahkan kembali pengguna ke halaman login.

-----

### 7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
#### – Memastikan deployment proyek Django berjalan dengan baik
Saya melakukan git add, git commit, dan git push ke PWS agar perubahaan pada proyek Django terdeploy. Setelah itu, saya mengecek seluruh halaman dan fungsionalitas untuk memastikan bahwa perubahan berjalan sesuai dengan yang saya mau.
#### – Mengimplementasikan fitur registrasi akun pada Flutter
Saya membuat halaman register di Flutter dan menambahkan endpoint register baru di Django agar Flutter dapat mengirim data dengan POST request. Dengan begitu, pengguna dapat membuat akun langsung dari aplikasi Flutter dan datanya tersimpan di database Django.
#### – Membuat halaman login pada Flutter
Saya membuat halaman login di Flutter dan menyediakan endpoint login di Django. Hal ini memungkinkan Flutter mengirimkan input dari pengguna dan menerima session cookie dari Django, sehingga pengguna dapat masuk ke aplikasi.
#### – Mengintegrasikan autentikasi Django dengan Flutter
Saya membuat aplikasi autentikasi di Django yang berisi views register, login, dan logout. Saya juga menggunakan CookieRequest di Flutter agar session yang dibuat Django dapat dipakai di seluruh komponen Flutter. Dengan begitu, sistem login/logout dapat bekerja.
#### – Membuat model kustom sesuai model Django
Saya membuat model Dart pada `product_entry.dart` yang strukturnya disesuaikan dengan model produk yang saya buat di Django. Ini saya lakukan agar Flutter bisa dengan mudah memparsing JSON dari Django menjadi objek Dart yang terstruktur dan konsisten.
#### – Membuat halaman daftar item dari endpoint JSON Django
Saya membuat halaman daftar produk di Flutter dan menambahkan endpoint JSON pada Django untuk menyediakan data produk tersebut. Setelah itu, saya membuat widget card khusus yang digunakan untuk merender setiap produk yang diterima dari backend. Card ini saya desain agar dapat menampilkan informasi penting mengenai produk, seperti nama, harga, gambar, dan kategori.
#### – Membuat halaman detail untuk setiap item
Saya menambahkan fitur `onTap` pada setiap card sehingga ketika card ditekan, Flutter akan membuka halaman `product_detail.dart` dan mengirimkan objek produk sebagai argumen. Saya juga merancang halaman tersebut agar menampilkan seluruh informasi terkait produk secara lengkap. Navigasi dilakukan menggunakan `Navigator.push()`, sehingga pengguna dapat kembali ke halaman daftar dengan menekan tombol back bawaan Flutter di pojok kiri atas.
#### – Menambahkan fitur filter produk berdasarkan user yang login
Saya menambahkan tombol filter pada halaman daftar produk dan membuat state filter untuk menentukan apakah yang ditampilkan adalah seluruh produk atau hanya produk milik pengguna yang login. Saya menggunakan metode where untuk memfilter data berdasarkan username.

-----

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