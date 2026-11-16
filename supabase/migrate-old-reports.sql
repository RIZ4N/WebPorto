-- Moves the chapters of the 11 reports from the old site into the database.
-- Run once in Supabase > SQL Editor, after schema.sql.
-- It replaces the chapters of these 11 reports, so do not run it again after
-- editing them in the admin panel.

begin;

-- laprak_MobApp-1.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-01-input-widgets-basic-form');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum pertama Aplikasi Mobile ini membahas mengenai pembuatan basic form pada Flutter yang berfungsi untuk menerima inputan dari pengguna melalui keyboard. Basic form merupakan kumpulan widget input seperti TextField, TextFormField, CheckBox, Switch, Dropdown, dan sejenisnya yang digunakan untuk mengelola serta memvalidasi data masukan sebelum data tersebut diproses lebih lanjut oleh aplikasi. Melalui praktikum ini, mahasiswa diperkenalkan pada dua widget utama, yaitu TextField yang bersifat sederhana tanpa validasi otomatis, dan TextFormField yang sudah terintegrasi dengan logika validasi serta manajemen status form menggunakan GlobalKey dan FormState.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu membuat beberapa jenis input widgets pada aplikasi Flutter.</p></li><li><p>Mahasiswa mampu membuat dan mengontrol inputan yang diberikan oleh pengguna.</p></li><li><p>Mahasiswa memahami perbedaan penggunaan TextField dan TextFormField.</p></li><li><p>Mahasiswa mampu menerapkan validasi data menggunakan GlobalKey dan FormState.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-01-input-widgets-basic-form';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah kerja$wp$, $wp$<h3>A. Membuat Tampilan Basic Form dengan TextField</h3><img src="/images/legacy/MobApp/1.webp" alt="Kode Program: Tampilan Awal Basic Form TextField"><p style="text-align: center"><em>Kode Program: Tampilan Awal Basic Form TextField</em></p><p>Pada tahap ini dibuat file dart baru bernama form-textfield di dalam folder lib. Struktur halaman disusun menggunakan Scaffold dengan AppBar berjudul "Basic Form". Bagian isi halaman dibungkus dengan Padding dan Column agar susunan widget rapi dan sejajar ke kiri, terdiri dari widget Text sebagai label, widget TextField sebagai kolom inputan nama lengkap, serta ElevatedButton yang akan berfungsi sebagai pemicu aksi.</p><img src="/images/legacy/MobApp/1.webp" alt="Hasil Tampilan Basic Form TextField"><p style="text-align: center"><em>Hasil Tampilan Basic Form TextField</em></p><p>Hasil di atas menunjukkan tampilan form yang telah dijalankan pada browser/emulator, berupa kolom inputan nama lengkap beserta tombol "Tampilkan mama" yang belum memiliki fungsi apa pun karena onPressed masih dibiarkan kosong.</p><h3>B. Menambahkan TextEditingController</h3><img src="/images/legacy/MobApp/tambahtexteditingcontrol.webp" alt="Kode Program: Penambahan TextEditingController"><p style="text-align: center"><em>Kode Program: Penambahan TextEditingController</em></p><p>Pada class _MyFormState ditambahkan sebuah variabel bertipe TextEditingController yang bertugas mengambil serta mengelola nilai inputan dari pengguna. Bersamaan dengan itu, method dispose() dioverride untuk membersihkan controller tersebut dari memori ketika widget sudah tidak digunakan lagi, sehingga aplikasi terhindar dari kebocoran memori (memory leak).</p><h3>C. Menghubungkan Controller pada Widget TextField</h3><img src="/images/legacy/MobApp/tambahproperti.webp" alt="Kode Program: Properti TextField dengan Controller"><p style="text-align: center"><em>Kode Program: Properti TextField dengan Controller</em></p><p>Widget TextField yang sebelumnya dibuat dilengkapi dengan tiga properti tambahan, yaitu controller yang dihubungkan dengan _textEditingController, keyboardType untuk menentukan jenis papan ketik yang muncul, dan onChanged yang berfungsi sebagai event listener untuk mencetak teks yang sedang diketik pengguna secara langsung ke console setiap kali terjadi perubahan karakter.</p><h3>D. Menampilkan Inputan Menggunakan SnackBar</h3><img src="/images/legacy/MobApp/onpressed.webp" alt="Kode Program: Implementasi SnackBar pada onPressed"><p style="text-align: center"><em>Kode Program: Implementasi SnackBar pada onPressed</em></p><p>Method onPressed pada ElevatedButton diisi dengan kode yang mengambil nilai teks dari _textEditingController, kemudian nilai tersebut ditampilkan kepada pengguna melalui widget SnackBar, yaitu notifikasi singkat yang muncul pada bagian bawah layar aplikasi.</p><img src="/images/legacy/MobApp/2.webp" alt="Hasil Akhir Basic Form TextField Setelah Dijalankan"><p style="text-align: center"><em>Hasil Akhir Basic Form TextField Setelah Dijalankan</em></p><p>Hasil pengujian menunjukkan bahwa setelah nama lengkap diketikkan dan tombol ditekan, SnackBar muncul di bagian bawah layar menampilkan teks nama yang telah diinputkan sebelumnya, membuktikan bahwa controller berhasil mengambil nilai dari TextField dengan benar.</p><h3>E. Membuat Basic Form dengan TextFormField</h3><img src="/images/legacy/MobApp/kodeawalbasic.webp" alt="Kode Program: Tampilan Awal Basic Form TextFormField"><p style="text-align: center"><em>Kode Program: Tampilan Awal Basic Form TextFormField</em></p><p>Dibuat file dart baru bernama form-textformfield yang berisi tampilan form dengan dua buah widget TextFormField untuk kolom nama dan email, serta satu ElevatedButton bertuliskan "Submit" yang dibungkus SizedBox agar lebar tombol memenuhi layar. Berbeda dari TextField, TextFormField dirancang agar dapat bekerja sama dengan widget Form untuk keperluan validasi data.</p><img src="/images/legacy/MobApp/4.webp" alt="Hasil Tampilan Awal Basic Form TextFormField"><p style="text-align: center"><em>Hasil Tampilan Awal Basic Form TextFormField</em></p><p>Tampilan awal ini masih menunjukkan dua kolom input yang belum tersambung dengan controller maupun validator, sehingga tombol Submit belum dapat memicu proses apa pun.</p><h3>F. Menambahkan GlobalKey dan Controller</h3><img src="/images/legacy/MobApp/kodeglobalcontrolsubmit.webp" alt="Kode Program: GlobalKey, Controller, dan Method _submitForm"><p style="text-align: center"><em>Kode Program: GlobalKey, Controller, dan Method _submitForm</em></p><p>Pada class _MyFormTextState ditambahkan variabel _formKey bertipe GlobalKey&lt;FormState&gt; untuk mengakses status Form secara global, beserta dua buah TextEditingController untuk menampung inputan nama dan email. Dibuat pula method _submitForm() yang memanggil _formKey.currentState!.validate() untuk menjalankan seluruh fungsi validator pada setiap TextFormField; apabila seluruh validasi bernilai true, nilai nama dan email akan ditampilkan melalui SnackBar.</p><h3>G. Membungkus Tampilan dengan Widget Form dan Menambahkan Validator</h3><img src="/images/legacy/MobApp/widgetformdanvalidator.webp" alt="Kode Program: Widget Form dan Validator pada TextFormField"><p style="text-align: center"><em>Kode Program: Widget Form dan Validator pada TextFormField</em></p><p>Tampilan Column dibungkus menggunakan widget Form dan diberi properti key: _formKey agar terhubung dengan GlobalKey yang telah dibuat. Setiap TextFormField dilengkapi controller masing-masing beserta fungsi validator: kolom nama akan menampilkan pesan error apabila dikosongkan, sedangkan kolom email memvalidasi dua kondisi sekaligus, yaitu memastikan email tidak kosong dan memastikan formatnya mengandung karakter "@".</p><h3>H. Menghubungkan Method _submitForm ke ElevatedButton</h3><img src="/images/legacy/MobApp/penghubungsubmit.webp" alt="Kode Program: Penghubungan _submitForm pada ElevatedButton"><p style="text-align: center"><em>Kode Program: Penghubungan _submitForm pada ElevatedButton</em></p><p>Method _submitForm dikaitkan dengan properti onPressed pada ElevatedButton yang dibungkus SizedBox agar lebar tombol memenuhi layar. Dengan demikian, setiap kali tombol Submit ditekan, proses validasi pada seluruh TextFormField akan dijalankan terlebih dahulu sebelum data ditampilkan.</p><img src="/images/legacy/MobApp/tampilanakhirbasicformtextfiled.webp" alt="Hasil Akhir Basic Form TextFormField Beserta Validasinya"><p style="text-align: center"><em>Hasil Akhir Basic Form TextFormField Beserta Validasinya</em></p><p>Hasil pengujian menunjukkan bahwa saat kolom nama atau email dikosongkan atau format email tidak valid, pesan error otomatis muncul di bawah field yang bersangkutan. Ketika seluruh data valid dan tombol Submit ditekan, SnackBar muncul menampilkan nama dan email yang berhasil divalidasi.</p>$wp$, 1 from public.reports where slug = 'mobile-app-01-input-widgets-basic-form';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Tugas/Latihan (Kelas B)$wp$, $wp$<h3>Implementasi Form Pendaftaran Pengguna</h3><p>Sesuai instruksi latihan Kelas B, dibuat aplikasi form pendaftaran pengguna yang terdiri dari empat kolom inputan yaitu nama, email, password, dan confirm password, beserta satu tombol submit. Implementasi dipecah menjadi dua file dart, yaitu main.dart sebagai root aplikasi dan user_registration_form.dart yang berisi logika form.</p><img src="/images/legacy/MobApp/maindart.webp" alt="Kode Program: main.dart"><p style="text-align: center"><em>Kode Program: main.dart</em></p><p>File main.dart menggunakan MaterialApp sebagai root aplikasi dengan properti home diarahkan langsung ke widget UserRegistrationForm yang bertipe StatefulWidget.</p><img src="/images/legacy/MobApp/deklarasiglobaltugas.webp" alt="Kode Program: Deklarasi GlobalKey dan Controller pada user_registration_form.dart"><p style="text-align: center"><em>Kode Program: Deklarasi GlobalKey dan Controller pada user_registration_form.dart</em></p><p>Pada class _UserRegistrationFormState dideklarasikan sebuah _formKey bertipe GlobalKey&lt;FormState&gt; beserta empat TextEditingController untuk menampung nilai nama, email, password, dan confirm password. Seluruh controller tersebut dibersihkan pada method dispose() agar tidak membebani memori aplikasi.</p><img src="/images/legacy/MobApp/validatortexformfieldemaildannama.webp" alt="Kode Program: Validator pada Kolom Nama dan Email"><p style="text-align: center"><em>Kode Program: Validator pada Kolom Nama dan Email</em></p><p>Kolom nama divalidasi agar tidak boleh dikosongkan, sedangkan kolom email divalidasi dengan dua ketentuan, yaitu tidak boleh kosong dan wajib mengandung karakter "@" agar dianggap sebagai format email yang benar.</p><img src="/images/legacy/MobApp/widgetformdanvalidator.webp" alt="Kode Program: Validator pada Kolom Password dan Confirm Password"><p style="text-align: center"><em>Kode Program: Validator pada Kolom Password dan Confirm Password</em></p><p>Kolom password divalidasi agar tidak kosong dan memiliki panjang minimal enam karakter. Kolom confirm password divalidasi dengan membandingkan nilainya terhadap nilai pada controller password menggunakan operator perbandingan string, sehingga apabila kedua nilai tersebut berbeda, pesan error "Password tidak sama" akan ditampilkan.</p><img src="/images/legacy/MobApp/submitformtugas.webp" alt="Kode Program: Method _submitForm dan Pemasangannya pada Tombol Submit"><p style="text-align: center"><em>Kode Program: Method _submitForm dan Pemasangannya pada Tombol Submit</em></p><p>Method _submitForm memanggil _formKey.currentState!.validate() untuk menjalankan seluruh validator secara serentak. Apabila hasilnya bernilai true, aplikasi akan menampilkan SnackBar bertuliskan "Pendaftaran Berhasil" sebagai tanda bahwa seluruh data yang diinputkan telah lolos validasi.</p><img src="/images/legacy/MobApp/tampilanawaltugas.webp" alt="Hasil Tampilan Awal Form Pendaftaran Pengguna"><p style="text-align: center"><em>Hasil Tampilan Awal Form Pendaftaran Pengguna</em></p><p>Tampilan awal menunjukkan keempat kolom inputan tersusun rapi secara vertikal beserta tombol Submit di bagian bawah yang lebarnya memenuhi layar.</p><img src="/images/legacy/MobApp/validasisalahtugas.webp" alt="Hasil Pengujian Validasi Saat Kolom Kosong atau Format Salah"><p style="text-align: center"><em>Hasil Pengujian Validasi Saat Kolom Kosong atau Format Salah</em></p><p>Ketika tombol Submit ditekan pada kondisi terdapat kolom yang masih kosong, format email salah, atau password dan confirm password tidak sama, pesan error yang sesuai langsung muncul di bawah masing-masing field yang bermasalah.</p><img src="/images/legacy/MobApp/validasibenartugas.webp" alt="Hasil Notifikasi Pendaftaran Berhasil"><p style="text-align: center"><em>Hasil Notifikasi Pendaftaran Berhasil</em></p><p>Setelah seluruh data diisi dengan benar dan tombol Submit ditekan, SnackBar "Pendaftaran Berhasil" muncul di bagian bawah layar, menandakan bahwa seluruh proses validasi telah berjalan sesuai dengan yang diharapkan.</p>$wp$, 2 from public.reports where slug = 'mobile-app-01-input-widgets-basic-form';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa Flutter menyediakan dua jenis widget input utama, yaitu TextField yang cocok digunakan untuk kebutuhan inputan sederhana tanpa validasi, serta TextFormField yang lebih tepat digunakan pada form dengan kebutuhan validasi data. Penggunaan GlobalKey bersama FormState memungkinkan seluruh proses validasi pada beberapa TextFormField dijalankan secara serentak dan terpusat melalui satu method saja. Implementasi pada studi kasus form pendaftaran pengguna semakin memperkuat pemahaman mengenai bagaimana validasi bertingkat, seperti pengecekan format email dan kecocokan password, dapat diterapkan secara efektif untuk menghasilkan aplikasi mobile yang lebih aman dan andal.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDart</p>$wp$, 3 from public.reports where slug = 'mobile-app-01-input-widgets-basic-form';
update public.reports set updated_at = now() where slug = 'mobile-app-01-input-widgets-basic-form';

-- laprak_MobApp-2.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-02-widgets-layouting-styling');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum kedua Aplikasi Mobile ini terdiri atas dua modul yang saling berkelanjutan, yaitu Pengenalan Widgets serta Layouting &amp; Styling pada Flutter. Modul pertama membahas dasar-dasar pembangunan antarmuka melalui perbedaan StatelessWidget yang tampilannya statis dan StatefulWidget yang mampu merender ulang dirinya melalui fungsi setState() ketika terjadi perubahan data. Modul kedua melanjutkan pembahasan dengan menerapkan widget tata letak seperti Row, Column, Container, dan ListTile untuk menyusun komponen antarmuka yang lebih kompleks, seperti deretan tombol aksi dan daftar riwayat transaksi, hingga akhirnya seluruh komponen digabungkan menjadi satu dashboard yang dapat digulir menggunakan SingleChildScrollView.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu membedakan penggunaan StatelessWidget dan StatefulWidget dalam pengembangan aplikasi Flutter.</p></li><li><p>Mahasiswa mampu menerapkan fungsi setState() untuk membangun antarmuka yang interaktif.</p></li><li><p>Mahasiswa mampu menerapkan widget Row dan Column untuk menyusun tata letak antarmuka secara horizontal maupun vertikal.</p></li><li><p>Mahasiswa mampu menggunakan widget Container dan ListTile untuk membangun tampilan daftar yang rapi dan konsisten.</p></li><li><p>Mahasiswa mampu menggabungkan seluruh komponen ke dalam satu halaman dashboard yang dapat digulir.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-02-widgets-layouting-styling';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Modul 1: Pengenalan Widgets, Stateless, Stateful & Manajemen State Dasar$wp$, $wp$<h3>A. Membuat Widget Sapaan (Stateless)</h3><img src="/images/legacy/MobApp/Praktikum2/Kode_Greetings.webp" alt="Kode Program: GreetingWidget (StatelessWidget)"><p style="text-align: center"><em>Kode Program: GreetingWidget (StatelessWidget)</em></p><p>Dibuat GreetingWidget yang diturunkan dari StatelessWidget karena tampilan sapaan bersifat statis dan tidak memiliki data yang berubah setelah dirender. Widget Row digunakan untuk menyusun CircleAvatar berwarna biru berisi ikon person di sisi kiri, diikuti SizedBox sebagai jarak, lalu Column dengan crossAxisAlignment.start yang menumpuk dua Text, yaitu "Halo, Budi" dengan gaya tebal ukuran 20 dan "Selamat datang kembali!" berwarna abu-abu berukuran lebih kecil.</p><h3>B. Membuat Kartu Saldo (Stateful)</h3><img src="/images/legacy/MobApp/Praktikum2/Kode_Balance_Card.webp" alt="Kode Program: Struktur BalanceCardWidget (StatefulWidget)"><p style="text-align: center"><em>Kode Program: Struktur BalanceCardWidget (StatefulWidget)</em></p><p>Berbeda dari GreetingWidget, kartu saldo harus dapat bereaksi saat ikon mata ditekan sehingga dibuat sebagai StatefulWidget bernama BalanceCardWidget, dengan createState() mengembalikan _BalanceCardWidgetState. Pada class state tersebut dideklarasikan variabel _isBalanceVisible bertipe bool (default true) untuk menandai status visibilitas saldo, serta variabel _balance bertipe String final yang menampung nilai nominal "Rp 5.000.000".</p><h3>C. Menerapkan Interaktivitas (setState)</h3><img src="/images/legacy/MobApp/Praktikum2/kode_SetState.webp" alt="Kode Program: Implementasi setState pada BalanceCardWidget"><p style="text-align: center"><em>Implementasi setState pada BalanceCardWidget</em></p><p>Method build mengembalikan Card berwarna biru dengan sudut membulat, berisi Row spaceBetween yang menampilkan teks "Saldo Utama" beserta IconButton. Ikon pada tombol tersebut berganti antara Icons.visibility dan Icons.visibility_off menggunakan ternary berdasarkan nilai _isBalanceVisible, sementara Text nominal saldo juga berganti antara angka asli dan tanda sensor. Setiap kali IconButton ditekan, method _toggleVisibility memanggil setState() untuk membalik nilai boolean, sehingga Flutter merender ulang kartu dengan kondisi tampilan yang baru.</p><h3>Hasil Akhir Modul 1</h3><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirModul1.webp" alt="Hasil Akhir Modul 1: Tampilan Sapaan dan Kartu Saldo"><p style="text-align: center"><em>Hasil Akhir Modul 1: Tampilan Sapaan dan Kartu Saldo</em></p><p>Setelah GreetingWidget dan BalanceCardWidget digabungkan ke dalam Scaffold utama melalui Padding dan Column, halaman menampilkan sapaan statis di bagian atas beserta CircleAvatar pengguna, diikuti kartu saldo berwarna biru di bawahnya. Ikon mata pada kartu dapat ditekan untuk menyembunyikan atau menampilkan kembali nominal saldo secara dinamis tanpa perlu memuat ulang halaman.</p><h3>Tugas/Latihan Modul 1</h3><h4>Tugas 1: Mengubah Tema Warna BalanceCard</h4><img src="/images/legacy/MobApp/Praktikum2/kode_Tugas1_WarnaTeal.webp" alt="Kode Program: Perubahan Warna BalanceCard menjadi Colors.teal"><p style="text-align: center"><em>Kode Program: Perubahan Warna BalanceCard menjadi Colors.teal</em></p><p>Sesuai instruksi tugas, properti color pada widget Card di dalam BalanceCardWidget diubah dari Colors.blueAccent menjadi Colors.teal, sehingga kartu saldo tampil dengan nuansa hijau emerald menggantikan warna biru sebelumnya.</p><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirTugas1_Modul1.webp" alt="Hasil Tampilan Tugas 1: Kartu Saldo Warna Teal"><p style="text-align: center"><em>Hasil Tampilan Tugas 1: Kartu Saldo Warna Teal</em></p><p>Tampilan yang diharapkan menunjukkan kartu saldo dengan warna dasar hijau emerald menggantikan warna biru, sementara seluruh fungsi interaktivitas menampilkan dan menyembunyikan saldo tetap berjalan seperti semula.</p><h4>Tugas 2: Menambahkan Nomor Rekening</h4><img src="/images/legacy/MobApp/Praktikum2/Kode_Tugas2_NoRek.webp" alt="Kode Program: Penambahan Teks No. Rekening pada BalanceCard"><p style="text-align: center"><em>Kode Program: Penambahan Teks No. Rekening pada BalanceCard</em></p><p>Di bawah Text nominal saldo ditambahkan SizedBox sebagai jarak vertikal, diikuti sebuah Text statis baru bertuliskan "No. Rekening: 1423-5678" dengan warna putih transparan dan ukuran huruf yang lebih kecil agar tidak mendominasi tampilan kartu.</p><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirTugas2_Modul1.webp" alt="Hasil Tampilan Tugas 2: Kartu Saldo dengan Nomor Rekening"><p style="text-align: center"><em>Hasil Tampilan Tugas 2: Kartu Saldo dengan Nomor Rekening</em></p><p>Tampilan yang diharapkan menunjukkan baris teks nomor rekening muncul tepat di bawah nominal saldo pada kartu, melengkapi informasi yang ditampilkan tanpa mengubah fungsi toggle visibilitas saldo yang sudah ada.</p>$wp$, 1 from public.reports where slug = 'mobile-app-02-widgets-layouting-styling';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Modul 2: Layouting & Styling ; Row, Column, Container, dan ListTile$wp$, $wp$<h3>A. Menyusun Tombol Aksi (Row)</h3><img src="/images/legacy/MobApp/Praktikum2/Kode_ActionButtonWidget.webp" alt="Kode Program: ActionButtonsWidget (Row)"><p style="text-align: center"><em>Kode Program: ActionButtonsWidget (Row)</em></p><img src="/images/legacy/MobApp/Praktikum2/Kode_ActionButtonWidget2.webp" alt="Kode Program: ActionButtonsWidget (Row)"><p style="text-align: center"><em>Kode Program: ActionButtonsWidget (Row)</em></p><p>ActionButtonsWidget menggunakan Row dengan mainAxisAlignment.spaceEvenly agar jarak antar tombol terbagi rata. Tiga tombol aksi, yaitu Pemasukan, Pengeluaran, dan Transfer, dibangun melalui method pembantu _buildActionButton yang mengembalikan Column berisi Container pembungkus ikon dengan padding, warna latar transparan 20% dari warna asli, dan sudut membulat, diikuti SizedBox serta Text label di bawah ikon.</p><h3>B. Menyusun Riwayat (Column + ListTile)</h3><img src="/images/legacy/MobApp/Praktikum2/Kode_RecentTransaction.webp" alt="Kode Program: RecentTransactionsWidget (Column + ListTile)"><p style="text-align: center"><em>Kode Program: RecentTransactionsWidget (Column + ListTile)</em></p><p>RecentTransactionsWidget menyusun judul "Transaksi Terakhir" di atas sebuah Card berisi Column yang menumpuk beberapa ListTile secara berturut-turut, dipisahkan oleh Divider di antaranya. Setiap ListTile memiliki leading berupa CircleAvatar dengan ikon sesuai kategori transaksi, title berisi nama transaksi, subtitle berupa tanggal, dan trailing berupa Text nominal yang diwarnai merah untuk transaksi pengeluaran dan hijau untuk transaksi pemasukan.</p><h3>C. Integrasi Dashboard (Scrollable)</h3><img src="/images/legacy/MobApp/Praktikum2/Kode_SingleChildScroll.webp" alt="Kode Program: Integrasi SingleChildScrollView pada DashboardScreen"><p style="text-align: center"><em>Kode Program: Integrasi SingleChildScrollView pada DashboardScreen</em></p><p>Seluruh widget dari Modul 1 (GreetingWidget, BalanceCardWidget) dan Modul 2 (ActionButtonsWidget, RecentTransactionsWidget) digabungkan ke dalam satu Column dengan jarak antarwidget diatur menggunakan SizedBox, lalu Column tersebut dibungkus dengan Padding dan SingleChildScrollView agar halaman tetap dapat digulir dan terhindar dari overflow ketika daftar transaksi bertambah panjang.</p><h3>Hasil Akhir Modul 2</h3><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirModul2.webp" alt="Hasil Akhir Modul 2: Mockup Dashboard"><p style="text-align: center"><em>Hasil Akhir Modul 2: Mockup Dashboard</em></p><p>Dashboard yang dihasilkan menampilkan sapaan dan kartu saldo dari Modul 1 di bagian atas, diikuti tiga tombol aksi yang tersusun sejajar secara horizontal, dan daftar Transaksi Terakhir di bagian bawah lengkap dengan warna nominal sesuai jenis transaksinya. Seluruh komponen tersusun rapi dalam satu halaman yang dapat digulir.</p><h3>Tugas/Latihan Modul 2</h3><h4>Tugas 1: Styling Warna Trailing Text</h4><img src="/images/legacy/MobApp/Praktikum2/Kode_Tugas1_Modul2.webp" alt="Kode Program: Pewarnaan Trailing Text pada ListTile"><p style="text-align: center"><em>Kode Program: Pewarnaan Trailing Text pada ListTile</em></p><p>Setiap Text pada properti trailing ListTile diberi TextStyle dengan color eksplisit, yaitu Colors.red untuk transaksi bertipe pengeluaran dan Colors.green untuk transaksi bertipe pemasukan, sehingga jenis transaksi dapat dikenali langsung dari warna nominal tanpa perlu membaca judulnya.</p><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirTugas1_Modul2.webp" alt="Hasil Tampilan Tugas 1: Warna Trailing Text Transaksi"><p style="text-align: center"><em>Hasil Tampilan Tugas 1: Warna Trailing Text Transaksi</em></p><p>Tampilan yang diharapkan menunjukkan nominal transaksi pengeluaran berwarna merah dan nominal transaksi pemasukan berwarna hijau pada setiap ListTile di daftar Transaksi Terakhir.</p><h4>Tugas 2: Menambahkan Transaksi Baru</h4><img src="/images/legacy/MobApp/Praktikum2/Kode_Tugas2_Modul2.webp" alt="Kode Program: Penambahan Dua ListTile Transaksi Baru"><p style="text-align: center"><em>Kode Program: Penambahan Dua ListTile Transaksi Baru</em></p><p>Dua ListTile baru beserta Divider pemisahnya ditambahkan setelah item transaksi yang sudah ada di dalam Column milik Card, masing-masing dengan leading ikon, title, subtitle tanggal, dan trailing nominal sesuai jenis transaksi fiktif yang dipilih.</p><img src="/images/legacy/MobApp/Praktikum2/HasilAkhirTugas2_Modul2.webp" alt="Hasil Tampilan Tugas 2: Daftar Transaksi dengan Data Baru"><p style="text-align: center"><em>Hasil Tampilan Tugas 2: Daftar Transaksi dengan Data Baru</em></p><p>Tampilan yang diharapkan menunjukkan daftar Transaksi Terakhir bertambah menjadi lima item, dengan dua transaksi baru mengikuti pola tampilan dan pewarnaan yang sama seperti transaksi sebelumnya.</p>$wp$, 2 from public.reports where slug = 'mobile-app-02-widgets-layouting-styling';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa Flutter menyediakan StatelessWidget untuk komponen yang tampilannya statis serta StatefulWidget yang dilengkapi setState() untuk komponen yang perlu merespons interaksi pengguna secara dinamis. Lebih lanjut, kombinasi widget tata letak seperti Row untuk susunan horizontal, Column untuk susunan vertikal, Container untuk pengaturan padding dan warna, serta ListTile untuk baris daftar yang rapi, memungkinkan pembangunan antarmuka yang kompleks seperti dashboard keuangan. Pembungkusan seluruh komponen dengan SingleChildScrollView juga terbukti penting untuk menjaga tampilan tetap dapat digulir dan terhindar dari overflow ketika jumlah data bertambah.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDart</p>$wp$, 3 from public.reports where slug = 'mobile-app-02-widgets-layouting-styling';
update public.reports set updated_at = now() where slug = 'mobile-app-02-widgets-layouting-styling';

-- laprak_MobApp-3.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-03-input-widgets-forms');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum ketiga Aplikasi Mobile ini membahas pembuatan formulir input pada Flutter menggunakan TextFormField, DropdownButtonFormField, serta mekanisme validasi data melalui GlobalKey dan FormState. Studi kasus yang diterapkan adalah halaman Catat Transaksi Baru yang menangkap judul transaksi, nominal, dan kategori dari pengguna sebelum data tersebut diproses lebih lanjut oleh aplikasi.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu menangkap teks masukan pengguna menggunakan TextEditingController.</p></li><li><p>Mahasiswa mampu menerapkan widget dropdown statis menggunakan DropdownButtonFormField.</p></li><li><p>Mahasiswa mampu menerapkan validasi input untuk mencegah data kosong atau format yang tidak sesuai.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-03-input-widgets-forms';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja$wp$, $wp$<h3>A. Struktur Dasar Halaman (Scaffold, AppBar &amp; SingleChildScrollView)</h3><img src="/images/legacy/MobApp/Praktikum3/BagianA.webp" alt="Kode Program: Struktur Scaffold, AppBar, dan Pembungkus Form"><p style="text-align: center"><em>Kode Program: Struktur Scaffold, AppBar, dan Pembungkus Form</em></p><p>Method build mengembalikan Scaffold dengan AppBar berjudul "Catat Transaksi Baru" berwarna deepPurple. Isi halaman dibungkus SingleChildScrollView agar tampilan tidak overflow saat keyboard muncul, lalu widget Form dengan key: _formKey membungkus Column crossAxisAlignment.stretch yang menampung seluruh kolom input, dropdown, dan tombol agar lebarnya memenuhi layar.</p><h3>B. Persiapan State &amp; Controller</h3><img src="/images/legacy/MobApp/Praktikum3/BagianB.webp" alt="Kode Program: Struktur _AddTransactionScreenState"><p style="text-align: center"><em>Kode Program: Struktur _AddTransactionScreenState</em></p><p>AddTransactionScreen dibuat sebagai StatefulWidget karena isi formulir berupa teks dan pilihan dropdown akan terus berubah seiring interaksi pengguna. Pada class _AddTransactionScreenState dideklarasikan _formKey bertipe GlobalKey&lt;FormState&gt; sebagai kunci utama untuk memicu validasi seluruh kolom sekaligus, dua TextEditingController (_titleController dan _amountController) untuk menampung teks judul dan nominal, serta variabel _selectedCategory bertipe String dengan nilai awal 'Makanan' untuk menyimpan kategori yang sedang dipilih pada dropdown.</p><h3>C. Membersihkan Controller (dispose())</h3><img src="/images/legacy/MobApp/Praktikum3/BagianC.webp" alt="Kode Program: Method dispose()"><p style="text-align: center"><em>Kode Program: Method dispose()</em></p><p>Method dispose() dioverride untuk memanggil dispose() pada _titleController, _amountController, dan _dateController sebelum memanggil super.dispose(), sehingga seluruh controller dibersihkan dari memori ketika halaman AddTransactionScreen sudah tidak digunakan lagi dan aplikasi terhindar dari memory leak.</p><h3>D. Membuat Kolom Input (TextFormField)</h3><img src="/images/legacy/MobApp/Praktikum3/BagianD.webp" alt="Kode Program: TextFormField Judul dan Nominal Transaksi"><p style="text-align: center"><em>Kode Program: TextFormField Judul dan Nominal Transaksi</em></p><p>Seluruh kolom input dibungkus widget Form dan dihubungkan melalui key: _formKey. Kolom pertama menggunakan TextFormField dengan controller _titleController, decoration labelText "Judul Transaksi", dan validator yang mengembalikan pesan error apabila value kosong. Kolom kedua menggunakan controller _amountController dengan keyboardType: TextInputType.number agar papan ketik yang muncul berupa angka, serta validator bertingkat yang memeriksa apakah value kosong terlebih dahulu, kemudian memeriksa apakah value dapat dikonversi menjadi angka melalui int.tryParse sebelum dianggap valid.</p><h3>E. Dropdown &amp; Tombol Simpan</h3><img src="/images/legacy/MobApp/Praktikum3/BagianE.webp" alt="Kode Program: DropdownButtonFormField dan Tombol Simpan"><p style="text-align: center"><em>Kode Program: DropdownButtonFormField dan Tombol Simpan</em></p><p>Kategori transaksi ditangkap melalui DropdownButtonFormField&lt;String&gt; dengan value terikat pada _selectedCategory dan items yang dibangun dari daftar kategori menggunakan method map, masing-masing dibungkus DropdownMenuItem. Properti onChanged memanggil setState untuk memperbarui _selectedCategory setiap kali pengguna memilih opsi baru. Di bawahnya, ElevatedButton "Simpan Transaksi" pada onPressed memanggil _formKey.currentState!.validate() untuk menjalankan seluruh validator secara serentak; apabila hasilnya true, SnackBar ditampilkan sebagai tanda bahwa data telah lolos validasi.</p><h3>Hasil Akhir</h3><img src="/images/legacy/MobApp/Praktikum3/HasilAkhirLangkahPraktikum.webp" alt="Hasil Akhir: Mockup Formulir Catat Transaksi"><p style="text-align: center"><em>Hasil Akhir: Mockup Formulir Catat Transaksi</em></p><p>Halaman menampilkan AppBar berwarna ungu bertuliskan "Catat Transaksi Baru", diikuti kolom Judul Transaksi, kolom Nominal yang menampilkan pesan error berwarna merah apabila format yang dimasukkan bukan angka, dropdown Kategori dengan opsi bawaan "Makanan", dan tombol Simpan Transaksi di bagian bawah. SnackBar hijau muncul setelah tombol ditekan apabila seluruh kolom telah terisi dengan format yang benar.</p>$wp$, 1 from public.reports where slug = 'mobile-app-03-input-widgets-forms';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Tugas/Latihan: Menambahkan Input Tanggal Transaksi$wp$, $wp$<h3>A. Menyiapkan Controller dan Fungsi Pilih Tanggal</h3><img src="/images/legacy/MobApp/Praktikum3/KodeTugasA.webp" alt="Kode Program: Controller dan Fungsi _selectDate"><p style="text-align: center"><em>Kode Program: Controller dan Fungsi _selectDate</em></p><p>Ditambahkan TextEditingController baru bernama _dateController untuk menampung teks tanggal yang telah dipilih, beserta method _selectDate yang memanggil showDatePicker dan menunggu tanggal yang dipilih pengguna melalui date picker bawaan Flutter. Setelah tanggal dipilih, nilai day, month, dan year pada objek DateTime hasil pilihan diformat secara manual ke pola DD/MM/YYYY menggunakan padLeft(2, '0') agar tanggal dan bulan satu digit tetap tampil dua digit, tanpa memerlukan package tambahan, kemudian hasilnya ditetapkan ke dalam _dateController.text.</p><h3>B. Menambahkan Input Tanggal pada Form</h3><img src="/images/legacy/MobApp/Praktikum3/KodeTugasB.webp" alt="Kode Program: TextFormField Tanggal Transaksi"><p style="text-align: center"><em>Kode Program: TextFormField Tanggal Transaksi</em></p><p>Sebuah TextFormField baru ditambahkan sebelum tombol Simpan Transaksi, dengan controller _dateController, properti readOnly bernilai true agar keyboard tidak muncul, serta suffixIcon berupa IconButton kalender yang memanggil _selectDate saat ditekan. Validator pada kolom ini mengembalikan pesan error apabila _dateController.text masih kosong, sesuai instruksi tugas yang mewajibkan pengisian tanggal.</p><h3>Hasil Tampilan Tugas</h3><img src="/images/legacy/MobApp/Praktikum3/HasilTugasA.webp" alt="Hasil Tampilan Tugas: Kolom Tanggal Terisi"><p style="text-align: center"><em>Hasil Tampilan Tugas: Kolom Tanggal Terisi</em></p><p>Setelah ikon kalender ditekan dan tanggal dipilih melalui date picker, kolom Tanggal Transaksi menampilkan teks tanggal dengan format DD/MM/YYYY, sejajar dengan kolom-kolom input lain di atasnya sebelum tombol Simpan Transaksi.</p><img src="/images/legacy/MobApp/Praktikum3/HasilTugasB.webp" alt="Hasil Tampilan Tugas: Validasi Kolom Tanggal Kosong"><p style="text-align: center"><em>Hasil Tampilan Tugas: Validasi Kolom Tanggal Kosong</em></p><p>Apabila tombol Simpan Transaksi ditekan sementara kolom Tanggal Transaksi belum diisi, pesan error berwarna merah muncul di bawah kolom tersebut bersamaan dengan pesan error pada kolom lain yang belum valid, menandakan bahwa validator tanggal turut dijalankan oleh _formKey.currentState!.validate().</p>$wp$, 2 from public.reports where slug = 'mobile-app-03-input-widgets-forms';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa TextEditingController berperan penting dalam menangkap serta mengelola nilai masukan pengguna pada TextFormField, sementara DropdownButtonFormField memudahkan penyediaan pilihan tetap tanpa perlu widget tambahan untuk validasinya. Penggunaan GlobalKey bersama FormState memungkinkan seluruh validator pada berbagai jenis input, termasuk kolom tanggal yang memanfaatkan showDatePicker, dijalankan secara serentak melalui satu method saja, sehingga proses pengecekan data sebelum disimpan menjadi lebih terpusat dan konsisten.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDart</p>$wp$, 3 from public.reports where slug = 'mobile-app-03-input-widgets-forms';
update public.reports set updated_at = now() where slug = 'mobile-app-03-input-widgets-forms';

-- laprak_MobApp-4.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-04-navigation-passing-data');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum keempat Aplikasi Mobile ini membahas perpindahan antarhalaman pada Flutter menggunakan Navigator yang bekerja dengan konsep tumpukan (stack). Navigator.push digunakan untuk meletakkan halaman baru di tumpukan teratas, sedangkan Navigator.pop digunakan untuk menutup halaman teratas dan kembali ke halaman sebelumnya. Selain itu, praktikum ini juga menerapkan pengiriman data antarhalaman melalui constructor, sehingga halaman detail transaksi dapat menampilkan informasi yang sesuai dengan baris transaksi yang dipilih pada dashboard. Struktur proyek dibagi menjadi empat file terpisah, yaitu main.dart, dashboard_screen.dart, add_transaction_screen.dart, dan transaction_detail_screen.dart.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu menerapkan Navigator.push untuk berpindah ke layar baru.</p></li><li><p>Mahasiswa mampu menggunakan Navigator.pop untuk menutup layar setelah aksi selesai.</p></li><li><p>Mahasiswa mampu mengirim data antarlayar melalui constructor.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-04-navigation-passing-data';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja$wp$, $wp$<h3>A. Konfigurasi Aplikasi Utama (main.dart)</h3><img src="/images/legacy/MobApp/Praktikum4/main_dart.webp" alt="Kode Program: lib/main.dart"><p style="text-align: center"><em>Kode Program: lib/main.dart</em></p><p>File main.dart menjadi titik awal aplikasi melalui fungsi main() yang memanggil runApp(). Class MyApp mengembalikan MaterialApp dengan tema primarySwatch merah sesuai Modul 4, menonaktifkan banner debug, dan menetapkan DashboardScreen sebagai halaman home, sehingga DashboardScreen menjadi halaman pertama yang berada di dasar tumpukan Navigator.</p><h3>B. Membuat Halaman Detail Transaksi (Variabel Final &amp; Constructor)</h3><img src="/images/legacy/MobApp/Praktikum4/detail_constructor.webp" alt="Kode Program: Variabel dan Constructor TransactionDetailScreen"><p>TransactionDetailScreen</p><p>Dibuat file transaction_detail_screen.dart berisi TransactionDetailScreen yang diturunkan dari StatelessWidget. Empat variabel final bertipe String, yaitu title, amount, category, dan date, dideklarasikan sebagai penampung data yang dikirim dari halaman sebelumnya. Variabel tersebut harus final karena StatelessWidget tidak dapat mengubah datanya setelah dibangun. Constructor menggunakan kata kunci required pada setiap parameter, sehingga halaman ini tidak dapat dibuka tanpa data lengkap yang diserahkan oleh halaman pemanggilnya.</p><h3>C. Tampilan Halaman Detail &amp; Widget Pembantu _buildDetailRow</h3><img src="/images/legacy/MobApp/Praktikum4/detail_build.webp" alt="Kode Program: Method build dan _buildDetailRow pada TransactionDetailScreen"><p style="text-align: center"><em>Kode Program: Method build dan _buildDetailRow pada TransactionDetailScreen</em></p><p>Method build mengembalikan Scaffold dengan AppBar "Detail Transaksi" berwarna merah. Isi halaman berupa Column yang menampilkan ikon receipt_long berukuran besar, diikuti Text title dan Text amount yang langsung memakai data dari constructor, lalu Divider sebagai pemisah. Informasi kategori, tanggal, dan status ditampilkan melalui method pembantu _buildDetailRow yang mengembalikan Row spaceBetween berisi label berwarna abu-abu di kiri dan nilai bercetak tebal di kanan, sehingga setiap baris detail memiliki format yang seragam tanpa menuliskan kode yang sama berulang kali.</p><h3>D. Struktur Dashboard &amp; Kartu Saldo</h3><img src="/images/legacy/MobApp/Praktikum4/dashboard_struktur.webp" alt="Kode Program: Scaffold DashboardScreen dan _buildBalanceCard"><p style="text-align: center"><em>Kode Program: Scaffold DashboardScreen dan _buildBalanceCard</em></p><p>DashboardScreen pada dashboard_screen.dart menggabungkan antarmuka Modul 1 dan Modul 2 dalam satu Scaffold dengan AppBar "Dashboard Keuangan". Bagian body dibungkus SingleChildScrollView berisi Column yang menyusun teks sapaan, kartu saldo, judul Transaksi Terakhir, dan daftar transaksi. Kartu saldo dibangun melalui method _buildBalanceCard yang mengembalikan Card berwarna redAccent dengan sudut membulat, sedangkan daftar transaksi dibangun melalui _buildTransactionList yang menerima parameter context agar dapat digunakan oleh Navigator di dalamnya.</p><h3>E. Pindah ke Detail &amp; Mengirim Data (Push)</h3><img src="/images/legacy/MobApp/Praktikum4/listtile_push.webp" alt="Kode Program: onTap ListTile dengan Navigator.push"><p style="text-align: center"><em>Kode Program: onTap ListTile dengan Navigator.push</em></p><p>Setiap ListTile pada _buildTransactionList diberi properti onTap yang memanggil Navigator.push dengan MaterialPageRoute. Builder pada MaterialPageRoute membuat objek TransactionDetailScreen sekaligus mengisi constructor-nya dengan data milik baris yang diklik. Baris Makan Siang mengirim nominal "- Rp 50.000" dengan kategori Makanan, sedangkan baris Gaji Bulanan mengirim nominal "+ Rp 5.000.000" dengan kategori Pemasukan, sehingga halaman detail yang terbuka selalu sesuai dengan transaksi yang dipilih.</p><h3>F. Tombol Tambah Transaksi (FloatingActionButton)</h3><img src="/images/legacy/MobApp/Praktikum4/fab_push.webp" alt="Kode Program: FloatingActionButton menuju AddTransactionScreen"><p style="text-align: center"><em>Kode Program: FloatingActionButton menuju AddTransactionScreen</em></p><p>Scaffold dashboard dilengkapi FloatingActionButton berwarna merah dengan ikon add. Saat ditekan, tombol ini memanggil Navigator.push untuk membuka AddTransactionScreen. Berbeda dengan navigasi ke halaman detail, perpindahan ini tidak membawa data apa pun karena halaman formulir justru bertugas menerima masukan baru dari pengguna.</p><h3>G. Menutup Layar / Kembali Otomatis (Pop)</h3><img src="/images/legacy/MobApp/Praktikum4/form_pop.webp" alt="Kode Program: AddTransactionScreen dengan Navigator.pop"><p style="text-align: center"><em>Kode Program: AddTransactionScreen dengan Navigator.pop</em></p><p>Pada add_transaction_screen.dart, formulir berisi kolom Judul dan Nominal yang masing-masing memiliki validator wajib diisi. Di dalam onPressed tombol Simpan, setelah _formKey.currentState!.validate() bernilai true, SnackBar "Transaksi Berhasil Disimpan!" ditampilkan, lalu Navigator.pop(context) dipanggil untuk menghapus halaman formulir dari tumpukan. Akibatnya, pengguna otomatis kembali ke dashboard tanpa harus menekan tombol kembali secara manual.</p><h3>Hasil Akhir</h3><img src="/images/legacy/MobApp/Praktikum4/hasil_dashboard.webp" alt="Hasil Akhir: Tampilan Awal Dashboard Keuangan"><p style="text-align: center"><em>Hasil Akhir: Tampilan Awal Dashboard Keuangan</em></p><p>Saat aplikasi dijalankan, dashboard menampilkan AppBar merah bertuliskan "Dashboard Keuangan", teks sapaan, kartu saldo berwarna merah, serta daftar Transaksi Terakhir yang berisi Makan Siang dan Gaji Bulanan. FloatingActionButton dengan ikon tambah terlihat di pojok kanan bawah layar.</p><img src="/images/legacy/MobApp/Praktikum4/hasil_detail_makan_siang.webp" alt="Hasil Akhir: Detail Transaksi Makan Siang (Pengeluaran)"><p style="text-align: center"><em>Hasil Akhir: Detail Transaksi Makan Siang (Pengeluaran)</em></p><p>Ketika baris Makan Siang diklik, halaman Detail Transaksi terbuka dan menampilkan judul Makan Siang, nominal pengeluaran, kategori Makanan, tanggal transaksi, serta status Berhasil. Tombol panah kiri muncul secara otomatis di AppBar karena halaman ini dibuka melalui Navigator.push, dan menekannya akan mengembalikan pengguna ke dashboard.</p><img src="/images/legacy/MobApp/Praktikum4/hasil_detail_gaji_bulanan.webp" alt="Hasil Akhir: Detail Transaksi Gaji Bulanan (Pemasukan)"><p style="text-align: center"><em>Hasil Akhir: Detail Transaksi Gaji Bulanan (Pemasukan)</em></p><p>Ketika baris Gaji Bulanan diklik, halaman detail yang sama menampilkan data yang berbeda, yaitu judul Gaji Bulanan, nominal pemasukan, dan kategori Pemasukan. Hal ini menunjukkan bahwa satu halaman TransactionDetailScreen dapat digunakan ulang untuk berbagai transaksi karena isinya sepenuhnya bergantung pada data yang dikirim melalui constructor.</p>$wp$, 1 from public.reports where slug = 'mobile-app-04-navigation-passing-data';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Tugas/Latihan: Menambahkan Input Tanggal Transaksi$wp$, $wp$<h3>A. Menyiapkan Controller dan Fungsi Pilih Tanggal</h3><img src="/images/legacy/MobApp/Praktikum4/tugas_controller_selectdate.webp" alt="Kode Program: Controller dan Fungsi _selectDate"><p style="text-align: center"><em>Kode Program: Controller dan Fungsi _selectDate</em></p><p>Pada _AddTransactionScreenState ditambahkan TextEditingController bernama _dateController untuk menampung teks tanggal, beserta method _selectDate yang memanggil showDatePicker bawaan Flutter. Setelah pengguna memilih tanggal, nilai day, month, dan year dari objek DateTime diformat secara manual menjadi pola DD/MM/YYYY dengan bantuan padLeft(2, '0') agar tanggal dan bulan satu digit tetap tampil dua digit, kemudian hasilnya dimasukkan ke _dateController.text di dalam setState.</p><h3>B. Menambahkan Input Tanggal pada Form</h3><img src="/images/legacy/MobApp/Praktikum4/tugas_textformfield_tanggal.webp" alt="Kode Program: TextFormField Tanggal Transaksi"><p style="text-align: center"><em>Kode Program: TextFormField Tanggal Transaksi</em></p><p>TextFormField baru ditempatkan setelah kolom Nominal dan sebelum tombol Simpan, dengan controller _dateController dan properti readOnly bernilai true sehingga tanggal hanya dapat diisi melalui date picker. Date picker dapat dibuka dengan mengetuk kolom melalui onTap maupun menekan IconButton kalender pada suffixIcon. Validator pada kolom ini mengembalikan pesan "Tanggal wajib diisi" apabila kolom masih kosong, sehingga ikut diperiksa ketika tombol Simpan menjalankan validasi formulir.</p><h3>Hasil Tampilan Tugas</h3><img src="/images/legacy/MobApp/Praktikum4/tugas_hasil_terisi.webp" alt="Hasil Tampilan Tugas: Kolom Tanggal Terisi"><p style="text-align: center"><em>Hasil Tampilan Tugas: Kolom Tanggal Terisi</em></p><p>Setelah tanggal dipilih melalui date picker, kolom Tanggal Transaksi menampilkan tanggal dengan format DD/MM/YYYY di bawah kolom Nominal dan di atas tombol Simpan.</p><img src="/images/legacy/MobApp/Praktikum4/tugas_hasil_validasi.webp" alt="Hasil Tampilan Tugas: Validasi Kolom Tanggal Kosong"><p style="text-align: center"><em>Hasil Tampilan Tugas: Validasi Kolom Tanggal Kosong</em></p><p>Apabila tombol Simpan ditekan saat kolom Tanggal Transaksi masih kosong, pesan error berwarna merah muncul di bawah kolom tersebut dan halaman formulir tidak ditutup, karena Navigator.pop hanya dijalankan setelah seluruh kolom lolos validasi.</p>$wp$, 2 from public.reports where slug = 'mobile-app-04-navigation-passing-data';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa Navigator pada Flutter mengelola halaman dalam bentuk tumpukan, di mana Navigator.push digunakan untuk membuka halaman baru di atas halaman yang sedang aktif dan Navigator.pop digunakan untuk menutupnya kembali. Pengiriman data antarhalaman dapat dilakukan melalui constructor dengan variabel final dan parameter required, sehingga satu halaman detail dapat menampilkan isi yang berbeda sesuai data yang diterimanya. Penempatan Navigator.pop setelah validasi formulir juga memastikan halaman hanya ditutup ketika seluruh data, termasuk tanggal transaksi, telah diisi dengan benar.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDart</p>$wp$, 3 from public.reports where slug = 'mobile-app-04-navigation-passing-data';
update public.reports set updated_at = now() where slug = 'mobile-app-04-navigation-passing-data';

-- laprak_MobApp-5.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-05-navigation-architecture');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum kelima Aplikasi Mobile ini membahas arsitektur navigasi pada Flutter melalui penerapan Named Routes dan BottomNavigationBar. Named Routes memungkinkan seluruh halaman aplikasi didaftarkan secara terpusat di dalam MaterialApp sehingga perpindahan halaman cukup dilakukan dengan memanggil nama rutenya, sedangkan BottomNavigationBar digunakan untuk berpindah antara halaman Beranda, Riwayat, dan Profil tanpa mengganti Scaffold utama.</p><p>Selain itu, praktikum ini juga menjadi tugas akhir yang menggabungkan seluruh hasil Praktikum 1 sampai 5 ke dalam satu aplikasi Expense Tracker. Karena praktikum sebelumnya masih menggunakan data statis, aplikasi dilengkapi dengan local storage berbasis SQLite sehingga data yang dimasukkan pengguna tidak hilang, serta fitur register dan login yang datanya juga tersimpan di database. Desain antarmuka dari praktikum sebelumnya tetap dipertahankan, dengan penyesuaian warna tema menjadi indigo.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu menerapkan Named Routes untuk navigasi yang terpusat dan rapi.</p></li><li><p>Mahasiswa mampu membangun menu navigasi bawah menggunakan BottomNavigationBar.</p></li><li><p>Mahasiswa mampu mengintegrasikan halaman Beranda, Riwayat, dan Profil dalam satu wadah.</p></li><li><p>Mahasiswa mampu menerapkan local storage menggunakan SQLite agar data aplikasi tersimpan secara permanen.</p></li><li><p>Mahasiswa mampu membangun fitur register dan login yang datanya disimpan pada local storage.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-05-navigation-architecture';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja$wp$, $wp$<h3>A. Mendaftarkan Named Routes</h3><img src="/images/legacy/MobApp/Praktikum5/mendaftarkannamedroutes.webp" alt="Kode Program: Named Routes pada main.dart"><p style="text-align: center"><em>Kode Program: Named Routes pada main.dart</em></p><p>Pada main.dart, parameter home pada MaterialApp diganti dengan initialRoute dan routes. Rute '/' diarahkan ke LoginScreen karena pengguna harus masuk terlebih dahulu, kemudian rute '/register' ke RegisterScreen, '/home' ke MainScreen yang berisi tab, dan '/add' ke AddTransactionScreen. Rute '/home' dan '/add' memeriksa Session.currentUser terlebih dahulu, sehingga apabila belum ada pengguna yang login, misalnya ketika halaman browser dimuat ulang, aplikasi menampilkan halaman login alih-alih halaman yang membutuhkan data pengguna. MaterialApp juga mengatur tema aplikasi melalui ColorScheme.fromSeed dan AppBarTheme dengan warna utama kPrimaryColor.</p><h3>B. Membuat Penampung Tab (MainScreen)</h3><img src="/images/legacy/MobApp/Praktikum5/membuatpenampungtab.webp" alt="Kode Program: State dan Daftar Halaman pada MainScreen"><p style="text-align: center"><em>Kode Program: State dan Daftar Halaman pada MainScreen</em></p><p>MainScreen pada main_screen.dart dibuat sebagai StatefulWidget karena tab yang aktif akan terus berubah. Variabel _selectedIndex bernilai awal 0 sehingga tab Beranda aktif secara default, sedangkan list _pages berisi tiga halaman yang akan ditukar, yaitu DashboardScreen, HistoryScreen, dan ProfileScreen. Method _onItemTapped memanggil setState untuk memperbarui _selectedIndex sesuai indeks tab yang ditekan pengguna.</p><h3>C. Merangkai BottomNavigationBar</h3><img src="/images/legacy/MobApp/Praktikum5/merangkaibottomnavigator.webp" alt="Kode Program: BottomNavigationBar pada MainScreen"><p style="text-align: center"><em>Kode Program: BottomNavigationBar pada MainScreen</em></p><p>Method build pada MainScreen mengembalikan Scaffold dengan body berupa _pages[_selectedIndex], sehingga isi layar berganti mengikuti tab yang aktif. Properti bottomNavigationBar diisi BottomNavigationBar dengan currentIndex yang terikat pada _selectedIndex, onTap yang memanggil _onItemTapped, warna item aktif kPrimaryColor, serta tiga BottomNavigationBarItem berlabel Beranda, Riwayat, dan Profil.</p><h3>D. Pembaruan Tombol Tambah Transaksi (pushNamed)</h3><img src="/images/legacy/MobApp/Praktikum5/pembaruantomboltambahtransaksi.webp" alt="Kode Program: FloatingActionButton dengan Navigator.pushNamed"><p style="text-align: center"><em>Kode Program: FloatingActionButton dengan Navigator.pushNamed</em></p><p>FloatingActionButton pada DashboardScreen yang sebelumnya menggunakan Navigator.push dengan MaterialPageRoute kini diganti menjadi Navigator.pushNamed(context, '/add'). Pemanggilan tersebut ditunggu menggunakan await, sehingga setelah halaman formulir ditutup, method _loadData dijalankan untuk memuat ulang data transaksi dan saldo dari database.</p><h3>Hasil Akhir</h3><img src="/images/legacy/MobApp/Praktikum5/halamanberandadenganbottomnavigator.webp" alt="Hasil Akhir: Halaman Beranda dengan BottomNavigationBar"><p style="text-align: center"><em>Hasil Akhir: Halaman Beranda dengan BottomNavigationBar</em></p><p>Setelah login, aplikasi menampilkan halaman Beranda dengan BottomNavigationBar di bagian bawah layar yang berisi tab Beranda, Riwayat, dan Profil. Tab yang sedang aktif ditandai dengan warna indigo, dan menekan tab lain akan mengganti isi layar tanpa berpindah Scaffold utama.</p>$wp$, 1 from public.reports where slug = 'mobile-app-05-navigation-architecture';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Tugas/Latihan Praktikum 5$wp$, $wp$<h3>A. Halaman Riwayat Transaksi</h3><img src="/images/legacy/MobApp/Praktikum5/pengambilandatadanfilter.webp" alt="Kode Program: Pengambilan Data dan Filter pada HistoryScreen"><p style="text-align: center"><em>Kode Program: Pengambilan Data dan Filter pada HistoryScreen</em></p><p>HistoryScreen dibuat sebagai StatefulWidget yang menyimpan list _transactions, pilihan filter aktif _filter dengan nilai awal 'Semua', serta daftar pilihan filter berisi Semua, Pemasukan, dan Pengeluaran. Method _loadData dipanggil pada initState untuk mengambil seluruh transaksi milik pengguna yang sedang login dari database. Getter _filteredTransactions kemudian menyaring list tersebut menggunakan method where berdasarkan properti isIncome, sehingga hanya transaksi yang sesuai dengan filter yang dikembalikan.</p><img src="/images/legacy/MobApp/Praktikum5/choicechip.webp" alt="Kode Program: ChoiceChip dan ListView pada HistoryScreen"><p style="text-align: center"><em>Kode Program: ChoiceChip dan ListView pada HistoryScreen</em></p><p>Bagian atas halaman berisi Row yang menampilkan ChoiceChip untuk setiap pilihan filter. Chip yang terpilih diberi warna kPrimaryColor dengan teks putih, dan menekan chip akan memanggil setState untuk mengganti nilai _filter. Di bawahnya, widget Expanded berisi ListView.separated yang menampilkan transaksi hasil filter menggunakan TransactionTile dengan Divider sebagai pemisah, atau teks "Belum ada transaksi" apabila datanya kosong.</p><img src="/images/legacy/MobApp/Praktikum5/filtersemua.webp" alt="Hasil Tampilan: Halaman Riwayat dengan Filter Semua"><p style="text-align: center"><em>Hasil Tampilan: Halaman Riwayat dengan Filter Semua</em></p><p>Halaman Riwayat menampilkan seluruh transaksi pengguna dengan urutan terbaru di bagian atas, lengkap dengan ikon kategori, tanggal, dan nominal yang berwarna hijau untuk pemasukan dan merah untuk pengeluaran.</p><img src="/images/legacy/MobApp/Praktikum5/filterpengeluaran.webp" alt="Hasil Tampilan: Halaman Riwayat dengan Filter Pengeluaran"><p style="text-align: center"><em>Hasil Tampilan: Halaman Riwayat dengan Filter Pengeluaran</em></p><p>Ketika filter Pengeluaran dipilih, daftar langsung hanya menampilkan transaksi pengeluaran tanpa perlu memuat ulang data dari database, karena penyaringan dilakukan pada data yang sudah tersimpan di state halaman.</p><h3>B. Halaman Profil</h3><img src="/images/legacy/MobApp/Praktikum5/kodeprofilescreen.webp" alt="Kode Program: ProfileScreen"><p style="text-align: center"><em>Kode Program: ProfileScreen</em></p><p>ProfileScreen merupakan StatelessWidget yang mengambil data pengguna dari Session.currentUser, lalu menampilkannya dalam Column yang berisi CircleAvatar dengan ikon person, Text nama, dan Text email. Tombol Logout dibuat menggunakan ElevatedButton.icon berwarna merah. Method _logout mengosongkan Session.currentUser, kemudian memanggil Navigator.pushNamedAndRemoveUntil ke rute '/' dengan kondisi yang selalu bernilai false, sehingga seluruh halaman pada tumpukan dihapus dan pengguna tidak dapat kembali ke halaman sebelumnya setelah logout.</p><img src="/images/legacy/MobApp/Praktikum5/tampilanhalamanprofil.webp" alt="Hasil Tampilan: Halaman Profil"><p style="text-align: center"><em>Hasil Tampilan: Halaman Profil</em></p><p>Halaman Profil menampilkan avatar, nama, dan email sesuai akun yang sedang login, dengan tombol Logout di bagian bawah. Menekan tombol tersebut akan mengembalikan pengguna ke halaman Login.</p><h3>C. Halaman Login</h3><img src="/images/legacy/MobApp/Praktikum5/formpadaloginscreen.webp" alt="Kode Program: Form pada LoginScreen"><p style="text-align: center"><em>Kode Program: Form pada LoginScreen</em></p><p>LoginScreen dibuat sebagai StatefulWidget dengan GlobalKey&lt;FormState&gt; dan dua TextEditingController untuk email dan password. Form berisi ikon dompet, judul aplikasi, TextFormField email dengan validasi wajib diisi serta harus mengandung karakter '@' dan '.', dan TextFormField password dengan obscureText yang dapat diubah melalui IconButton pada suffixIcon. Di bawahnya terdapat tombol Login dan TextButton yang mengarah ke rute '/register'.</p><img src="/images/legacy/MobApp/Praktikum5/methodlogin.webp" alt="Kode Program: Method _login"><p style="text-align: center"><em>Kode Program: Method _login</em></p><p>Method _login menjalankan validasi form terlebih dahulu, kemudian memanggil DatabaseHelper.login dengan email yang sudah dirapikan menggunakan trim dan toLowerCase. Apabila hasilnya null, SnackBar merah berisi pesan "Email atau password salah" ditampilkan. Apabila data cocok, objek User disimpan ke Session.currentUser dan aplikasi berpindah ke rute '/home' menggunakan pushReplacementNamed, sehingga halaman login diganti dan tidak dapat diakses kembali melalui tombol kembali. Email pengguna yang login kemudian ditampilkan pada sapaan di halaman Beranda dan pada halaman Profil.</p><img src="/images/legacy/MobApp/Praktikum5/halamanlogin.webp" alt="Hasil Tampilan: Halaman Login"><p style="text-align: center"><em>Hasil Tampilan: Halaman Login</em></p><p>Halaman Login menampilkan kolom email dan password beserta tombol Login dan tautan menuju halaman pendaftaran. Apabila tombol Login ditekan saat kolom masih kosong, pesan validasi berwarna merah muncul di bawah kolom yang belum diisi.</p><img src="/images/legacy/MobApp/Praktikum5/logindenganpasswordsalah.webp" alt="Hasil Tampilan: Login dengan Password Salah"><p style="text-align: center"><em>Hasil Tampilan: Login dengan Password Salah</em></p><p>Ketika email atau password yang dimasukkan tidak sesuai dengan data di database, SnackBar merah berisi pesan "Email atau password salah" muncul dan pengguna tetap berada di halaman Login.</p><img src="/images/legacy/MobApp/Praktikum5/emailpenggunapadahalamanberanda.webp" alt="Hasil Tampilan: Email Pengguna pada Halaman Beranda"><p style="text-align: center"><em>Hasil Tampilan: Email Pengguna pada Halaman Beranda</em></p><p>Setelah login berhasil, halaman Beranda menampilkan sapaan berisi nama pengguna beserta email yang diinputkan saat login, sesuai dengan ketentuan tugas.</p>$wp$, 2 from public.reports where slug = 'mobile-app-05-navigation-architecture';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Tugas Akhir: Integrasi Praktikum 1–5 dengan Local Storage$wp$, $wp$<h3>A. Struktur Project dan Package</h3><img src="/images/legacy/MobApp/Praktikum5/strukturfolderliv.webp" alt="Struktur Folder lib"><p style="text-align: center"><em>Struktur Folder lib</em></p><p>Seluruh kode aplikasi disusun di dalam folder lib dan dibagi berdasarkan fungsinya, yaitu main.dart untuk konfigurasi aplikasi dan rute, models.dart untuk model data, database_helper.dart untuk pengelolaan database, file halaman seperti login_screen.dart, register_screen.dart, main_screen.dart, dashboard_screen.dart, add_transaction_screen.dart, transaction_detail_screen.dart, history_screen.dart, dan profile_screen.dart, serta transaction_tile.dart sebagai widget baris transaksi yang digunakan bersama.</p><img src="/images/legacy/MobApp/Praktikum5/dependenciespadapubsecyaml.webp" alt="Kode Program: Dependencies pada pubspec.yaml"><p style="text-align: center"><em>Kode Program: Dependencies pada pubspec.yaml</em></p><p>Untuk local storage ditambahkan package sqflite sebagai penghubung ke database SQLite dan package path untuk menyusun lokasi file database. Karena aplikasi juga dijalankan di browser, ditambahkan pula package sqflite_common_ffi_web yang menyediakan SQLite versi web. Package tersebut membutuhkan perintah dart run sqflite_common_ffi_web:setup untuk menambahkan file pendukungnya ke folder web.</p><h3>B. Model Data dan Session</h3><img src="/images/legacy/MobApp/Praktikum5/modelsdart.webp" alt="Kode Program: models.dart"><p style="text-align: center"><em>Kode Program: models.dart</em></p><p>File models.dart berisi class User dan TransactionItem yang merepresentasikan satu baris data dari tabel users dan transactions. Keduanya memiliki factory fromMap untuk mengubah hasil query menjadi objek, dan TransactionItem juga memiliki method toMap untuk menyimpan data. Getter isIncome menentukan bahwa transaksi berkategori Pemasukan menambah saldo, sedangkan getter amountText menyusun teks nominal beserta tanda plus atau minus. Class Session menyimpan pengguna yang sedang login dalam variabel static currentUser. File ini juga berisi konstanta kPrimaryColor, fungsi formatRupiah yang memberi pemisah titik setiap tiga digit, serta fungsi categoryIcon dan categoryColor untuk menentukan ikon dan warna setiap kategori.</p><h3>C. Local Storage dengan SQLite (DatabaseHelper)</h3><img src="/images/legacy/MobApp/Praktikum5/konfigurasisqlite.webp" alt="Kode Program: Konfigurasi SQLite Web pada Fungsi main"><p style="text-align: center"><em>Kode Program: Konfigurasi SQLite Web pada Fungsi main</em></p><p>Pada fungsi main, kondisi kIsWeb digunakan untuk mendeteksi apakah aplikasi berjalan di browser. Apabila benar, databaseFactory diganti dengan databaseFactoryFfiWeb agar sqflite menggunakan SQLite versi web, sedangkan saat dijalankan di Android aplikasi tetap menggunakan SQLite bawaan perangkat.</p><img src="/images/legacy/MobApp/Praktikum5/inisialisasidatabasedanpembuatantabel.webp" alt="Kode Program: Inisialisasi Database dan Pembuatan Tabel"><p style="text-align: center"><em>Kode Program: Inisialisasi Database dan Pembuatan Tabel</em></p><p>Class DatabaseHelper menyimpan objek database dalam variabel static _database, dan getter database menggunakan operator ??= agar database hanya dibuka satu kali. Method _initDatabase menentukan lokasi file expense_tracker.db, lalu memanggil openDatabase dengan callback onCreate yang membuat dua tabel saat database pertama kali dibuat. Tabel users menyimpan nama, email, dan password dengan email bersifat UNIQUE, sedangkan tabel transactions menyimpan user_id, judul, nominal, kategori, dan tanggal sehingga setiap transaksi terhubung dengan pemiliknya.</p><img src="/images/legacy/MobApp/Praktikum5/methodregister,login,danpengelolaantransaksi.webp" alt="Kode Program: Method Register, Login, dan Pengelolaan Transaksi"><p style="text-align: center"><em>Kode Program: Method Register, Login, dan Pengelolaan Transaksi</em></p><p>Method register memeriksa terlebih dahulu apakah email sudah ada di tabel users, lalu mengembalikan false apabila sudah terdaftar atau menyimpan data baru dan mengembalikan true. Method login mencari baris yang email dan password-nya cocok dan mengembalikan objek User atau null. Untuk transaksi, insertTransaction menyimpan data baru, getTransactions mengambil transaksi berdasarkan user_id dengan urutan id terbaru di atas, dan deleteTransaction menghapus transaksi berdasarkan id. Seluruh query menggunakan parameter whereArgs agar nilai yang dimasukkan pengguna tidak digabungkan langsung ke dalam perintah SQL.</p><h3>D. Halaman Register</h3><p><strong>[Screenshot belum ditambahkan: Kode Program: Form dan Validasi pada RegisterScreen]</strong></p><p style="text-align: center"><em>Kode Program: Form dan Validasi pada RegisterScreen</em></p><p>RegisterScreen memiliki empat TextFormField, yaitu nama lengkap, email, password, dan konfirmasi password, masing-masing dengan controller sendiri. Validator nama memastikan kolom tidak kosong, validator email memeriksa format email, validator password mewajibkan minimal enam karakter, dan validator konfirmasi password membandingkan isinya dengan _passwordController.text sehingga pendaftaran ditolak apabila kedua password tidak sama. Kolom password dan konfirmasi password juga dilengkapi tombol untuk menampilkan atau menyembunyikan isinya.</p><img src="/images/legacy/MobApp/Praktikum5/methodregister.webp" alt="Kode Program: Method _register"><p style="text-align: center"><em>Kode Program: Method _register</em></p><p>Method _register memanggil DatabaseHelper.register setelah form lolos validasi. Apabila hasilnya false, SnackBar merah berisi pesan "Email sudah terdaftar" ditampilkan. Apabila berhasil, SnackBar hijau muncul dan halaman ditutup menggunakan Navigator.pop sehingga pengguna kembali ke halaman Login untuk masuk dengan akun yang baru dibuat.</p><img src="/images/legacy/MobApp/Praktikum5/validasipasswdtdksama.webp" alt="Hasil Tampilan: Validasi Konfirmasi Password"><p style="text-align: center"><em>Hasil Tampilan: Validasi Konfirmasi Password</em></p><p>Apabila isi kolom konfirmasi password berbeda dengan kolom password, pesan "Password tidak sama" muncul di bawah kolom konfirmasi dan data tidak disimpan ke database.</p><img src="/images/legacy/MobApp/Praktikum5/registrasiberhasil.webp" alt="Hasil Tampilan: Registrasi Berhasil"><p style="text-align: center"><em>Hasil Tampilan: Registrasi Berhasil</em></p><p>Setelah seluruh kolom diisi dengan benar, SnackBar hijau bertuliskan "Registrasi berhasil, silakan login" muncul dan aplikasi kembali ke halaman Login.</p><h3>E. Integrasi Halaman Beranda dengan Database</h3><img src="/images/legacy/MobApp/Praktikum5/methodloaddata.webp" alt="Kode Program: State dan Method _loadData pada DashboardScreen"><p style="text-align: center"><em>Kode Program: State dan Method _loadData pada DashboardScreen</em></p><p>DashboardScreen yang pada praktikum sebelumnya berupa StatelessWidget kini diubah menjadi StatefulWidget karena datanya diambil dari database. Method _loadData dipanggil pada initState untuk mengambil transaksi milik pengguna, lalu menjumlahkan nominal transaksi pemasukan ke _totalIncome dan transaksi lainnya ke _totalExpense. Lima transaksi teratas disimpan ke _recentTransactions untuk ditampilkan sebagai Transaksi Terakhir.</p><img src="/images/legacy/MobApp/Praktikum5/greetingwidgerdanbalancecardwidget.webp" alt="Kode Program: GreetingWidget dan BalanceCardWidget"><p style="text-align: center"><em>Kode Program: GreetingWidget dan BalanceCardWidget</em></p><p>GreetingWidget tetap berupa StatelessWidget dengan Row berisi CircleAvatar dan Column teks, namun kini menerima nama dan email melalui constructor sehingga sapaan sesuai dengan pengguna yang login. BalanceCardWidget tetap berupa StatefulWidget dengan variabel _isBalanceVisible dan setState untuk menyembunyikan saldo. Saldo utama dihitung dari income dikurangi expense, kemudian di bawahnya ditambahkan Divider dan Row berisi dua ringkasan yang dibangun melalui method _buildSummary, yaitu total pemasukan dengan ikon panah bawah hijau dan total pengeluaran dengan ikon panah atas merah. Ringkasan ini juga ikut tersensor ketika saldo disembunyikan.</p><img src="/images/legacy/MobApp/Praktikum5/actionbuttondanrecenttransaction.webp" alt="Kode Program: ActionButtonsWidget dan RecentTransactionsWidget"><p style="text-align: center"><em>Kode Program: ActionButtonsWidget dan RecentTransactionsWidget</em></p><p>ActionButtonsWidget dipertahankan dengan Row spaceEvenly berisi tiga tombol yang dibangun melalui _buildActionButton, yaitu Column berisi Container berwarna transparan dan label teks. RecentTransactionsWidget menampilkan judul Transaksi Terakhir dan Card berisi Column. Setiap transaksi ditampilkan melalui TransactionTile dengan Divider di antaranya menggunakan perulangan for, atau teks "Belum ada transaksi" apabila datanya kosong. Widget ini juga menerima callback onChanged agar daftar dapat dimuat ulang ketika transaksi dihapus dari halaman detail.</p><img src="/images/legacy/MobApp/Praktikum5/belumadatransaksi.webp" alt="Hasil Tampilan: Beranda Sebelum Ada Transaksi"><p style="text-align: center"><em>Hasil Tampilan: Beranda Sebelum Ada Transaksi</em></p><p>Untuk akun yang baru didaftarkan, kartu saldo menampilkan saldo, pemasukan, dan pengeluaran bernilai nol, sedangkan bagian Transaksi Terakhir menampilkan teks "Belum ada transaksi".</p><img src="/images/legacy/MobApp/Praktikum5/setelahtransaksiditambahkan.webp" alt="Hasil Tampilan: Beranda Setelah Transaksi Ditambahkan"><p style="text-align: center"><em>Hasil Tampilan: Beranda Setelah Transaksi Ditambahkan</em></p><p>Setelah transaksi ditambahkan, saldo utama beserta ringkasan pemasukan dan pengeluaran terhitung otomatis, dan transaksi terbaru muncul pada daftar Transaksi Terakhir dengan warna nominal sesuai jenisnya.</p><img src="/images/legacy/MobApp/Praktikum5/saldodanringkasandisembunyikan.webp" alt="Hasil Tampilan: Saldo dan Ringkasan Disembunyikan"><p style="text-align: center"><em>Hasil Tampilan: Saldo dan Ringkasan Disembunyikan</em></p><p>Ketika ikon mata ditekan, saldo utama serta nominal pemasukan dan pengeluaran pada kartu berubah menjadi tanda bintang.</p><h3>F. Form Tambah Transaksi dengan Penyimpanan ke Database</h3><img src="/images/legacy/MobApp/Praktikum5/controller,kategori,danmethodselectdate.webp" alt="Kode Program: Controller, Kategori, dan Method _selectDate"><p style="text-align: center"><em>Kode Program: Controller, Kategori, dan Method _selectDate</em></p><p>AddTransactionScreen memiliki tiga TextEditingController untuk judul, nominal, dan tanggal, serta daftar kategori yang kini ditambah opsi Pemasukan agar pengguna dapat mencatat transaksi pemasukan. Method _selectDate memanggil showDatePicker, lalu memformat tanggal yang dipilih ke pola DD/MM/YYYY menggunakan padLeft, sedangkan method dispose membersihkan seluruh controller ketika halaman ditutup.</p><img src="/images/legacy/MobApp/Praktikum5/methodsavetransaction.webp" alt="Kode Program: Method _saveTransaction"><p style="text-align: center"><em>Kode Program: Method _saveTransaction</em></p><p>Method _saveTransaction menjalankan validasi form, kemudian membuat objek TransactionItem dari isi setiap kolom beserta id pengguna dari Session dan menyimpannya melalui DatabaseHelper.insertTransaction. Setelah tersimpan, SnackBar hijau ditampilkan dan halaman ditutup dengan Navigator.pop. Validator nominal juga diperketat sehingga selain harus berupa angka bulat, nilainya harus lebih dari nol.</p><img src="/images/legacy/MobApp/Praktikum5/validasiformtambahtransaksi.webp" alt="Hasil Tampilan: Validasi Form Tambah Transaksi"><p style="text-align: center"><em>Hasil Tampilan: Validasi Form Tambah Transaksi</em></p><p>Apabila tombol Simpan Transaksi ditekan saat form masih kosong, pesan validasi berwarna merah muncul pada kolom judul, nominal, dan tanggal.</p><img src="/images/legacy/MobApp/Praktikum5/transaksiterisi.webp" alt="Hasil Tampilan: Form Tambah Transaksi Terisi"><p style="text-align: center"><em>Hasil Tampilan: Form Tambah Transaksi Terisi</em></p><p>Form yang telah diisi menampilkan judul, nominal, kategori yang dipilih, dan tanggal dalam format DD/MM/YYYY. Setelah disimpan, aplikasi kembali ke Beranda dengan data yang sudah diperbarui.</p><h3>G. Detail dan Hapus Transaksi</h3><img src="/images/legacy/MobApp/Praktikum5/transactiontile.webp" alt="Kode Program: TransactionTile"><p style="text-align: center"><em>Kode Program: TransactionTile</em></p><p>TransactionTile merupakan ListTile yang digunakan bersama oleh halaman Beranda dan Riwayat. Bagian leading menampilkan CircleAvatar dengan ikon dan warna sesuai kategori, title berisi judul, subtitle berisi tanggal, dan trailing berisi nominal berwarna hijau atau merah. Pada onTap, data transaksi dikirim melalui constructor ke TransactionDetailScreen menggunakan Navigator.push. Hasil dari halaman detail ditunggu dengan await, dan apabila bernilai true, callback onChanged dipanggil untuk memuat ulang daftar transaksi.</p><img src="/images/legacy/MobApp/Praktikum5/constructordanmethoddeletetransaction.webp" alt="Kode Program: Constructor dan Method _deleteTransaction"><p style="text-align: center"><em>Kode Program: Constructor dan Method _deleteTransaction</em></p><p>TransactionDetailScreen kini menerima tambahan parameter id melalui constructor agar transaksi dapat dihapus. Method _deleteTransaction menampilkan AlertDialog berisi tombol Batal dan Hapus. Apabila pengguna memilih Hapus, transaksi dihapus melalui DatabaseHelper.deleteTransaction, SnackBar ditampilkan, lalu halaman ditutup dengan Navigator.pop(context, true) sebagai tanda bahwa data telah berubah. Warna nominal pada halaman detail juga disesuaikan menjadi hijau untuk pemasukan dan merah untuk pengeluaran.</p><img src="/images/legacy/MobApp/Praktikum5/halamandetailtransaksi.webp" alt="Hasil Tampilan: Halaman Detail Transaksi"><p style="text-align: center"><em>Hasil Tampilan: Halaman Detail Transaksi</em></p><p>Halaman detail menampilkan judul, nominal, kategori, tanggal, dan status transaksi yang dipilih, dengan tombol Hapus Transaksi berwarna merah di bagian bawah.</p><img src="/images/legacy/MobApp/Praktikum5/konfirmasihapus.webp" alt="Hasil Tampilan: Dialog Konfirmasi Hapus"><p style="text-align: center"><em>Hasil Tampilan: Dialog Konfirmasi Hapus</em></p><p>Saat tombol Hapus Transaksi ditekan, dialog konfirmasi muncul terlebih dahulu. Setelah dikonfirmasi, aplikasi kembali ke halaman sebelumnya dan transaksi tersebut sudah tidak tampil, dengan saldo yang ikut diperbarui.</p><h3>H. Pengujian Penyimpanan Data</h3><img src="/images/legacy/MobApp/Praktikum5/halamandimuatulang.webp" alt="Hasil Tampilan: Data Tetap Tersimpan Setelah Halaman Dimuat Ulang"><p style="text-align: center"><em>Hasil Tampilan: Data Tetap Tersimpan Setelah Halaman Dimuat Ulang</em></p><p>Pengujian dilakukan dengan logout, memuat ulang halaman browser sehingga aplikasi dijalankan kembali dari awal, lalu login menggunakan akun yang sama. Akun tetap dapat digunakan dan seluruh transaksi beserta saldo masih tampil seperti sebelumnya, yang menunjukkan bahwa data tersimpan pada database SQLite dan tidak hanya berada di memori sementara aplikasi.</p><h3>I. Build Aplikasi menjadi APK</h3><img src="/images/legacy/MobApp/Praktikum5/buildapk.webp" alt="Proses Build APK"><p style="text-align: center"><em>Proses Build APK</em></p><p>Aplikasi dibangun menjadi file instalasi Android menggunakan perintah flutter build apk --release. Perintah ini mengompilasi kode Dart beserta seluruh package ke dalam mode release yang lebih ringan dan cepat dibandingkan mode debug.</p><img src="/images/legacy/MobApp/Praktikum5/folderapk.webp" alt="Hasil File APK"><p style="text-align: center"><em>Hasil File APK</em></p><p>File hasil build bernama app-release.apk dan berada di folder build/app/outputs/flutter-apk. File tersebut dapat langsung dipasang pada perangkat Android.</p>$wp$, 3 from public.reports where slug = 'mobile-app-05-navigation-architecture';
insert into public.report_sections (report_id, title, content, position) select id, $wp$5. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa Named Routes membuat pengelolaan navigasi menjadi lebih terpusat karena seluruh halaman didaftarkan di satu tempat, sedangkan BottomNavigationBar memungkinkan beberapa halaman utama diakses dalam satu wadah dengan mengganti isi body berdasarkan indeks tab yang aktif. Penggabungan Praktikum 1 sampai 5 menunjukkan bahwa konsep StatelessWidget dan StatefulWidget, widget tata letak, formulir dengan validasi, serta navigasi dan passing data dapat dipadukan menjadi satu aplikasi yang utuh. Penambahan local storage menggunakan SQLite membuat data akun dan transaksi tetap tersimpan meskipun aplikasi dijalankan ulang, sekaligus memungkinkan fitur register dan login yang memisahkan data setiap pengguna.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDartSQLite</p>$wp$, 4 from public.reports where slug = 'mobile-app-05-navigation-architecture';
update public.reports set updated_at = now() where slug = 'mobile-app-05-navigation-architecture';

-- laprak_MobApp-6.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-06-state-management');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum keenam Aplikasi Mobile ini membahas state management pada Flutter dengan membuat aplikasi ResepKu, yaitu aplikasi sederhana yang menampilkan daftar resep masakan beserta detailnya. State merupakan data yang dapat berubah selama aplikasi berjalan dan memengaruhi tampilan, sehingga pemilihan tempat penyimpanan state menjadi hal yang penting dalam merancang aplikasi. Pada praktikum ini digunakan dua pendekatan, yaitu state lokal menggunakan StatefulWidget dan setState() yang cocok untuk data yang hanya dibutuhkan oleh satu widget, serta state global menggunakan package provider yang cocok untuk data yang dibutuhkan oleh banyak widget dan halaman sekaligus.</p><p>Kedua pendekatan tersebut diterapkan pada dua fitur yang berbeda. Fitur jumlah porsi pada halaman detail menggunakan setState() karena nilainya hanya dibutuhkan oleh halaman tersebut, sedangkan fitur favorit menggunakan Provider karena daftar favorit dibutuhkan oleh daftar resep, badge di AppBar, halaman detail, dan halaman Favorit. Sebelum menggunakan Provider, status favorit terlebih dahulu dicoba disimpan sebagai state lokal untuk melihat keterbatasan pendekatan tersebut ketika satu data dibutuhkan di banyak tempat.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu membuat state lokal dengan StatefulWidget dan setState() pada fitur jumlah porsi di halaman detail.</p></li><li><p>Mahasiswa mampu menjelaskan keterbatasan state lokal ketika satu data dibutuhkan oleh banyak widget dan halaman.</p></li><li><p>Mahasiswa mampu membuat state global dengan package provider (ChangeNotifier dan MultiProvider) pada fitur favorit.</p></li><li><p>Mahasiswa mampu membaca state dengan context.watch, context.read, dan Consumer di beberapa halaman.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-06-state-management';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja$wp$, $wp$<h3>Bagian A: Menyiapkan ResepKu dan State Lokal</h3><h3>A.1 Membuat Project dan Struktur Folder</h3><p><code>Terminal</code></p><pre><code class="language-bash">flutter create resepku
cd resepku</code></pre><p style="text-align: center"><em>Kode Program: Membuat Project ResepKu</em></p><p>Project baru bernama resepku dibuat menggunakan perintah flutter create, kemudian terminal diarahkan ke folder project tersebut. File test/widget_test.dart bawaan template dihapus karena merujuk ke class MyApp yang tidak digunakan lagi, sehingga tidak menimbulkan error pada editor.</p><p><code>lib/</code></p><pre><code class="language-plaintext">lib/
├── main.dart
├── models/
│   └── recipe.dart
├── data/
│   └── dummy_recipes.dart
├── providers/
│   └── favorite_provider.dart
├── pages/
│   ├── home_page.dart
│   ├── detail_page.dart
│   └── favorite_page.dart
└── widgets/
    ├── identity_footer.dart
    ├── recipe_tile.dart
    └── favorite_badge_button.dart</code></pre><p style="text-align: center"><em>Kode Program: Struktur Folder lib</em></p><p>Folder lib dibagi menjadi lima folder sesuai perannya, yaitu models untuk class data, data untuk data dummy, providers untuk state global, pages untuk halaman, dan widgets untuk komponen yang dapat digunakan ulang. Pemisahan ini membuat setiap file memiliki tanggung jawab yang jelas sehingga kode lebih mudah dibaca dan dikembangkan.</p><h3>A.2 Membuat Model Recipe</h3><p><code>lib/models/recipe.dart</code></p><pre><code class="language-dart">class Recipe {
  final int id;
  final String name;
  final String cuisine;
  final String difficulty;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final int caloriesPerServing;
  final double rating;
  final String image; // dipakai mulai Modul 7
  final List&lt;String&gt; ingredients;

  const Recipe({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.difficulty,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.caloriesPerServing,
    required this.rating,
    required this.image,
    required this.ingredients,
  });

  int get totalTimeMinutes =&gt; prepTimeMinutes + cookTimeMinutes;
}</code></pre><p style="text-align: center"><em>Kode Program: Model Recipe</em></p><p>Class Recipe merepresentasikan satu resep dengan field seperti nama, jenis masakan, tingkat kesulitan, waktu persiapan, waktu memasak, jumlah porsi, kalori per porsi, rating, gambar, dan daftar bahan. Seluruh field bersifat final dan constructor-nya bertanda const sehingga objek resep tidak dapat diubah setelah dibuat. Getter totalTimeMinutes menjumlahkan waktu persiapan dan waktu memasak, lalu dipanggil seperti field biasa tanpa tanda kurung.</p><h3>A.3 Menambahkan Data Dummy</h3><p><code>lib/data/dummy_recipes.dart</code></p><pre><code class="language-dart">import 'package:resepku/models/recipe.dart';

// Data sementara. Isinya sama dengan https://dummyjson.com/recipes (id 1-6),
// sehingga di Modul 8 cukup sumber datanya yang diganti ke API.
const List&lt;Recipe&gt; dummyRecipes = [
  Recipe(
    id: 1, name: 'Classic Margherita Pizza', cuisine: 'Italian', difficulty: 'Easy',
    prepTimeMinutes: 20, cookTimeMinutes: 15, servings: 4, caloriesPerServing: 300,
    rating: 4.6, image: 'https://cdn.dummyjson.com/recipe-images/1.webp',
    ingredients: ['Pizza dough', 'Tomato sauce', 'Fresh mozzarella cheese',
        'Fresh basil leaves', 'Olive oil', 'Salt and pepper to taste'],
  ),
  Recipe(
    id: 2, name: 'Vegetarian Stir-Fry', cuisine: 'Asian', difficulty: 'Medium',
    prepTimeMinutes: 15, cookTimeMinutes: 20, servings: 3, caloriesPerServing: 250,
    rating: 4.7, image: 'https://cdn.dummyjson.com/recipe-images/2.webp',
    ingredients: ['Tofu, cubed', 'Broccoli florets', 'Carrots, sliced',
        'Bell peppers, sliced', 'Soy sauce', 'Ginger, minced', 'Garlic, minced',
        'Sesame oil', 'Cooked rice for serving'],
  ),
  Recipe(
    id: 3, name: 'Chocolate Chip Cookies', cuisine: 'American', difficulty: 'Easy',
    prepTimeMinutes: 15, cookTimeMinutes: 10, servings: 24, caloriesPerServing: 150,
    rating: 4.9, image: 'https://cdn.dummyjson.com/recipe-images/3.webp',
    ingredients: ['All-purpose flour', 'Butter, softened', 'Brown sugar',
        'White sugar', 'Eggs', 'Vanilla extract', 'Baking soda', 'Salt',
        'Chocolate chips'],
  ),
  Recipe(
    id: 4, name: 'Chicken Alfredo Pasta', cuisine: 'Italian', difficulty: 'Medium',
    prepTimeMinutes: 15, cookTimeMinutes: 20, servings: 4, caloriesPerServing: 500,
    rating: 4.9, image: 'https://cdn.dummyjson.com/recipe-images/4.webp',
    ingredients: ['Fettuccine pasta', 'Chicken breast, sliced', 'Heavy cream',
        'Parmesan cheese, grated', 'Garlic, minced', 'Butter',
        'Salt and pepper to taste', 'Fresh parsley for garnish'],
  ),
  Recipe(
    id: 5, name: 'Mango Salsa Chicken', cuisine: 'Mexican', difficulty: 'Easy',
    prepTimeMinutes: 15, cookTimeMinutes: 25, servings: 3, caloriesPerServing: 380,
    rating: 4.9, image: 'https://cdn.dummyjson.com/recipe-images/5.webp',
    ingredients: ['Chicken thighs', 'Mango, diced', 'Red onion, finely chopped',
        'Cilantro, chopped', 'Lime juice', 'Jalapeño, minced',
        'Salt and pepper to taste', 'Cooked rice for serving'],
  ),
  Recipe(
    id: 6, name: 'Quinoa Salad with Avocado', cuisine: 'Mediterranean',
    difficulty: 'Easy', prepTimeMinutes: 20, cookTimeMinutes: 15, servings: 4,
    caloriesPerServing: 280, rating: 4.4,
    image: 'https://cdn.dummyjson.com/recipe-images/6.webp',
    ingredients: ['Quinoa, cooked', 'Avocado, diced', 'Cherry tomatoes, halved',
        'Cucumber, diced', 'Red bell pepper, diced', 'Feta cheese, crumbled',
        'Lemon vinaigrette dressing', 'Salt and pepper to taste'],
  ),
];</code></pre><p style="text-align: center"><em>Kode Program: Data Dummy Resep</em></p><p>File dummy_recipes.dart berisi konstanta dummyRecipes, yaitu list berisi enam objek Recipe yang digunakan sebagai data sementara untuk ditampilkan pada aplikasi. Data tersebut diambil dari enam resep pertama pada dummyjson.com/recipes, sehingga setiap resep sudah memiliki nama, jenis masakan, waktu memasak, jumlah porsi, kalori, rating, dan daftar bahan yang lengkap. Karena bertanda const, seluruh data dibuat sekali saat kompilasi dan tidak berubah selama aplikasi berjalan.</p><h3>A.4 Membuat Footer Identitas</h3><p><code>lib/widgets/identity_footer.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';

const String kNim = '2411531010';
const String kNama = 'Rizan Oesvan Idrati';

/// Menampilkan NIM dan nama di bawah setiap halaman.
/// Dipasang sekali di MaterialApp.builder, jadi berlaku untuk semua route.
class IdentityFooter extends StatelessWidget {
  const IdentityFooter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // ruang aman bawah sudah diurus footer, jadi tidak dihitung dua kali
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: child,
          ),
        ),
        Material(
          color: Colors.black87,
          child: SafeArea(
            top: false,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  '$kNim  •  $kNama',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: IdentityFooter</em></p><p>IdentityFooter menerima parameter child berupa halaman yang sedang tampil, lalu menyusunnya dalam Column bersama sebuah bar hitam berisi NIM dan nama. Halaman ditempatkan di dalam Expanded agar mengisi sisa ruang layar, sedangkan MediaQuery.removePadding menghapus padding bawah halaman karena ruang aman bagian bawah layar sudah ditangani oleh SafeArea pada footer. Widget ini dipasang sekali melalui parameter builder pada MaterialApp, sehingga footer otomatis tampil di seluruh halaman tanpa perlu ditambahkan ke setiap Scaffold.</p><h3>A.5 Halaman Home dan RecipeTile</h3><p><code>lib/main.dart (versi awal)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/pages/home_page.dart';
import 'package:resepku/widgets/identity_footer.dart';

void main() {
  runApp(const ResepKuApp());
}

class ResepKuApp extends StatelessWidget {
  const ResepKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResepKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
      builder: (context, child) =&gt; IdentityFooter(child: child!), // footer NIM &amp; nama
      home: const HomePage(),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: main.dart Versi Awal</em></p><p>File main.dart menjalankan ResepKuApp yang mengembalikan MaterialApp dengan tema berbasis warna deepOrange melalui colorSchemeSeed. Parameter builder membungkus Navigator dengan IdentityFooter, sedangkan parameter home menetapkan HomePage sebagai halaman pertama.</p><p><code>lib/pages/home_page.dart (versi awal)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResepKu'),
      ),
      body: ListView(
        children: [
          for (final recipe in dummyRecipes) RecipeTile(recipe: recipe),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: HomePage Versi Awal</em></p><p>HomePage berupa StatelessWidget yang menampilkan AppBar berjudul ResepKu dan sebuah ListView. Isi ListView dibangun menggunakan collection for, sehingga setiap resep pada dummyRecipes ditampilkan sebagai satu RecipeTile.</p><p><code>lib/widgets/recipe_tile.dart (versi awal)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/detail_page.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text(recipe.name[0])),
      title: Text(recipe.name),
      subtitle: Text(
        '${recipe.cuisine} • ${recipe.totalTimeMinutes} menit • ★ ${recipe.rating}',
      ),
      onTap: () =&gt; Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =&gt; DetailPage(recipe: recipe)),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeTile Versi Awal</em></p><p>RecipeTile menerima satu objek Recipe melalui constructor dan menampilkannya dalam ListTile. Bagian leading berisi CircleAvatar dengan huruf pertama nama resep, title berisi nama resep, dan subtitle berisi jenis masakan, total waktu memasak, serta rating. Ketika diketuk, tile membuka DetailPage dengan mengirimkan objek resep yang sama melalui Navigator.push.</p><h3>A.6 Halaman Detail dengan setState()</h3><p><code>lib/pages/detail_page.dart (versi awal)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State&lt;DetailPage&gt; createState() =&gt; _DetailPageState();
}

class _DetailPageState extends State&lt;DetailPage&gt; {
  late int _servings; // state lokal: hanya halaman ini yang butuh

  @override
  void initState() {
    super.initState();
    _servings = widget.recipe.servings; // nilai awal dari data resep
  }

  void _addServing() {
    setState(() =&gt; _servings++);
  }

  void _removeServing() {
    if (_servings &gt; 1) {
      setState(() =&gt; _servings--);
    }
  }</code></pre><p style="text-align: center"><em>Kode Program: State Lokal _servings dan Method Pengubahnya</em></p><p>DetailPage dibuat sebagai StatefulWidget karena jumlah porsi berubah setiap kali tombol tambah atau kurang ditekan. Variabel _servings dideklarasikan dengan kata kunci late karena nilainya baru diisi di dalam initState(), yaitu dari widget.recipe.servings. Penulisan widget.recipe diperlukan karena data resep dimiliki oleh class DetailPage, bukan oleh class State-nya. Method _addServing dan _removeServing membungkus perubahan nilai di dalam setState() agar Flutter menjalankan build() kembali, dengan _removeServing hanya mengurangi nilai apabila porsi masih lebih dari satu.</p><p><code>lib/pages/detail_page.dart (versi awal)</code></p><pre><code class="language-dart">  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final totalCalories = recipe.caloriesPerServing * _servings;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${recipe.cuisine} • ${recipe.difficulty} • ${recipe.totalTimeMinutes} menit',
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Text('Porsi', style: textTheme.titleMedium),
                  const Spacer(),
                  IconButton.filledTonal(
                    onPressed: _servings &gt; 1 ? _removeServing : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('$_servings', style: textTheme.titleLarge),
                  ),
                  IconButton.filledTonal(
                    onPressed: _addServing,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Total kalori: $totalCalories kkal', style: textTheme.titleMedium),
          const SizedBox(height: 24),
          Text('Bahan', style: textTheme.titleLarge),
          for (final item in recipe.ingredients)
            ListTile(
              dense: true,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(item),
            ),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: Tampilan Halaman Detail</em></p><p>Di dalam build(), total kalori dihitung dari caloriesPerServing dikalikan _servings, sehingga nilainya ikut berubah setiap kali porsi diubah. Halaman menampilkan informasi resep, Card berisi pengatur porsi, total kalori, dan daftar bahan yang dibangun dengan collection for. Tombol kurang menjadi tidak aktif ketika porsi bernilai 1 karena baris <code>onPressed: _servings &gt; 1 ? _removeServing : null</code>. Ketika porsi tidak lebih dari satu, onPressed bernilai null, dan Flutter secara otomatis menampilkan tombol dalam keadaan nonaktif serta tidak merespons ketukan.</p><h3>Checkpoint 1</h3><img src="/images/legacy/MobApp/Praktikum6/checkpoint1_porsi6.webp" alt="Checkpoint 1: Classic Margherita Pizza dengan Porsi 6"><p style="text-align: center"><em>Checkpoint 1: Classic Margherita Pizza dengan Porsi 6</em></p><p>Halaman detail Classic Margherita Pizza dengan porsi yang dinaikkan menjadi 6 menampilkan total kalori 1800 kkal, sesuai dengan perhitungan 6 porsi dikalikan 300 kkal per porsi. Hal ini menunjukkan bahwa setState() berhasil memperbarui jumlah porsi sekaligus nilai yang dihitung darinya.</p><img src="/images/legacy/MobApp/Praktikum6/checkpoint1_porsi1.webp" alt="Checkpoint 1: Tombol Kurang Nonaktif pada Porsi 1"><p style="text-align: center"><em>Checkpoint 1: Tombol Kurang Nonaktif pada Porsi 1</em></p><p>Ketika porsi diturunkan hingga bernilai 1, tombol kurang tampil dalam keadaan nonaktif dan tidak dapat ditekan, sesuai dengan kondisi pada properti onPressed yang bernilai null ketika _servings tidak lebih dari satu.</p><h3>Bagian B: Eksperimen Favorit dengan State Lokal</h3><h3>B.1 Mengganti RecipeTile</h3><p><code>lib/widgets/recipe_tile.dart (versi eksperimen)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/detail_page.dart';

// VERSI EKSPERIMEN: favorit disimpan sebagai state lokal di setiap tile
class RecipeTile extends StatefulWidget {
  const RecipeTile({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State&lt;RecipeTile&gt; createState() =&gt; _RecipeTileState();
}

class _RecipeTileState extends State&lt;RecipeTile&gt; {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return ListTile(
      leading: CircleAvatar(child: Text(recipe.name[0])),
      title: Text(recipe.name),
      subtitle: Text(
        '${recipe.cuisine} • ${recipe.totalTimeMinutes} menit • ★ ${recipe.rating}',
      ),
      trailing: IconButton(
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : null,
        ),
        onPressed: () =&gt; setState(() =&gt; _isFavorite = !_isFavorite),
      ),
      onTap: () =&gt; Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =&gt; DetailPage(recipe: recipe)),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeTile Versi Eksperimen</em></p><p>Pada versi eksperimen, RecipeTile diubah menjadi StatefulWidget dan setiap tile menyimpan status favoritnya sendiri dalam variabel _isFavorite dengan nilai awal false. Properti trailing berisi IconButton yang menampilkan ikon hati terisi berwarna merah apabila _isFavorite bernilai true, dan menekan tombol tersebut akan membalik nilainya melalui setState().</p><h3>B.2 Pengamatan</h3><p><strong>Apakah ikon hati berubah? Mengapa?</strong> Ikon hati berubah menjadi merah pada resep yang ditekan. Hal ini terjadi karena setState() dipanggil di dalam _RecipeTileState, sehingga Flutter membangun ulang tile tersebut dengan nilai _isFavorite yang baru. Setiap RecipeTile memiliki objek State masing-masing, sehingga perubahan pada satu tile tidak memengaruhi tile lainnya.</p><p><strong>Apakah jumlah resep favorit dapat ditampilkan di judul AppBar HomePage?</strong> Hal tersebut tidak dapat dilakukan. Data _isFavorite berada di dalam class _RecipeTileState yang bersifat private dan dimiliki oleh setiap tile secara terpisah. HomePage merupakan parent dari RecipeTile, sedangkan data pada Flutter mengalir dari parent ke child melalui constructor, bukan sebaliknya. Akibatnya, HomePage tidak memiliki cara untuk membaca maupun menghitung jumlah tile yang berstatus favorit.</p><p><strong>Bagaimana halaman detail mengetahui bahwa resep tersebut favorit?</strong> Halaman detail tidak dapat mengetahuinya. DetailPage hanya menerima objek Recipe melalui constructor, sedangkan objek tersebut tidak menyimpan status favorit. Nilai _isFavorite tetap tertinggal di dalam tile pada halaman Home dan tidak ikut dikirim ketika halaman detail dibuka, sehingga halaman detail tidak memiliki akses ke informasi tersebut.</p><h3>Bagian C: Fitur Favorit dengan Provider</h3><h3>C.1 Memasang Provider dan Membuat FavoriteProvider</h3><p><code>Terminal</code></p><pre><code class="language-bash">flutter pub add provider</code></pre><p style="text-align: center"><em>Kode Program: Menambahkan Package Provider</em></p><p>Perintah flutter pub add provider menambahkan package provider ke dalam pubspec.yaml sekaligus mengunduhnya, sehingga class seperti ChangeNotifierProvider, MultiProvider, dan Consumer dapat digunakan.</p><p><code>lib/providers/favorite_provider.dart</code></p><pre><code class="language-dart">import 'package:flutter/foundation.dart';
import 'package:resepku/models/recipe.dart';

class FavoriteProvider extends ChangeNotifier {
  final List&lt;Recipe&gt; _items = [];

  // Dari luar hanya boleh dibaca, tidak boleh diubah langsung
  List&lt;Recipe&gt; get items =&gt; List.unmodifiable(_items);
  int get count =&gt; _items.length;

  bool isFavorite(Recipe recipe) =&gt; _items.any((r) =&gt; r.id == recipe.id);

  void toggle(Recipe recipe) {
    if (isFavorite(recipe)) {
      _items.removeWhere((r) =&gt; r.id == recipe.id);
    } else {
      _items.add(recipe);
    }
    notifyListeners(); // beri tahu semua widget yang "mendengarkan"
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}</code></pre><p style="text-align: center"><em>Kode Program: FavoriteProvider</em></p><p>FavoriteProvider meng-extend ChangeNotifier sehingga dapat menyimpan daftar listener dan memberi tahu mereka melalui notifyListeners(). Daftar favorit disimpan pada list private _items, sedangkan dari luar data hanya dapat dibaca melalui getter items yang mengembalikan list unmodifiable dan getter count. Dengan cara ini, setiap perubahan wajib melalui method toggle() atau clear() yang selalu diakhiri dengan notifyListeners(). Method isFavorite memeriksa keberadaan resep berdasarkan id, bukan berdasarkan objeknya, sehingga sebuah resep tetap dikenali sebagai favorit meskipun objek Recipe yang dibandingkan merupakan objek yang berbeda.</p><h3>C.2 Memasang Provider di Atas MaterialApp</h3><p><code>lib/main.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/pages/home_page.dart';
import 'package:resepku/providers/favorite_provider.dart';
import 'package:resepku/widgets/identity_footer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =&gt; FavoriteProvider()),
      ],
      child: const ResepKuApp(),
    ),
  );
}

class ResepKuApp extends StatelessWidget {
  const ResepKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResepKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
      builder: (context, child) =&gt; IdentityFooter(child: child!), // tetap dipertahankan
      home: const HomePage(),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: MultiProvider pada main.dart</em></p><p>ChangeNotifierProvider yang membuat objek FavoriteProvider dipasang di atas ResepKuApp melalui MultiProvider. Karena berada di atas MaterialApp, provider ini dapat diakses oleh seluruh halaman yang berada di bawah Navigator. MultiProvider digunakan agar provider lain dapat ditambahkan dengan mudah ke dalam list providers. Setelah main.dart diubah, aplikasi perlu di-hot restart karena hot reload tidak menjalankan ulang fungsi main(), sehingga provider belum terpasang dan akan muncul ProviderNotFoundException.</p><h3>C.3 RecipeTile Membaca Data dari Provider</h3><p><code>lib/widgets/recipe_tile.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/detail_page.dart';
import 'package:resepku/providers/favorite_provider.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    // watch: widget ini ikut rebuild saat daftar favorit berubah
    final isFavorite = context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe);

    return ListTile(
      leading: CircleAvatar(child: Text(recipe.name[0])),
      title: Text(recipe.name),
      subtitle: Text(
        '${recipe.cuisine} • ${recipe.totalTimeMinutes} menit • ★ ${recipe.rating}',
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        // read: di dalam callback cukup "membaca", tidak perlu listen
        onPressed: () =&gt; context.read&lt;FavoriteProvider&gt;().toggle(recipe),
      ),
      onTap: () =&gt; Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =&gt; DetailPage(recipe: recipe)),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeTile dengan Provider</em></p><p>RecipeTile dikembalikan menjadi StatelessWidget karena status favorit tidak lagi disimpan di dalam tile. Di dalam build(), context.watch&lt;FavoriteProvider&gt;() digunakan untuk membaca status favorit sekaligus mendaftarkan tile sebagai listener, sehingga tile ikut dibangun ulang setiap kali daftar favorit berubah. Sebaliknya, di dalam callback onPressed digunakan context.read&lt;FavoriteProvider&gt;() karena callback hanya perlu memanggil method toggle() tanpa mendengarkan perubahan.</p><h3>C.4 Tombol Favorit di Halaman Detail</h3><p><code>lib/pages/detail_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/providers/favorite_provider.dart';</code></pre><p style="text-align: center"><em>Kode Program: Import Provider pada DetailPage</em></p><p><code>lib/pages/detail_page.dart</code></p><pre><code class="language-dart">  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final totalCalories = recipe.caloriesPerServing * _servings;
    final isFavorite = context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () =&gt; context.read&lt;FavoriteProvider&gt;().toggle(recipe),
          ),
        ],
      ),</code></pre><p style="text-align: center"><em>Kode Program: Status Favorit dan Tombol Favorit pada AppBar DetailPage</em></p><p>Pada DetailPage ditambahkan import package provider dan FavoriteProvider. Variabel isFavorite dibaca menggunakan context.watch tepat setelah perhitungan totalCalories, lalu digunakan oleh IconButton pada parameter actions di AppBar untuk menentukan ikon hati yang terisi atau kosong. Ketika ditekan, tombol tersebut memanggil toggle() melalui context.read. Bagian lain dari halaman detail tidak berubah, sehingga halaman ini kini menggunakan dua jenis state sekaligus, yaitu _servings sebagai state lokal dengan setState() dan status favorit sebagai state global dengan Provider.</p><h3>C.5 Halaman Favorit</h3><p><code>lib/pages/favorite_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit Saya')),
      body: Consumer&lt;FavoriteProvider&gt;(
        builder: (context, favorite, child) {
          if (favorite.count == 0) {
            return const Center(
              child: Text(
                'Belum ada resep favorit.\nTekan ikon hati di daftar resep.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView(
            children: [
              for (final recipe in favorite.items)
                ListTile(
                  title: Text(recipe.name),
                  subtitle: Text(recipe.cuisine),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =&gt; favorite.toggle(recipe),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: FavoritePage dengan Consumer</em></p><p>FavoritePage menggunakan Consumer&lt;FavoriteProvider&gt;, yaitu bentuk widget dari context.watch. Fungsi builder pada Consumer menerima objek provider melalui parameter favorite dan dijalankan ulang setiap kali notifyListeners() dipanggil. Apabila count bernilai nol, halaman menampilkan pesan bahwa belum ada resep favorit. Jika tidak, setiap resep favorit ditampilkan sebagai ListTile dengan tombol hapus yang memanggil toggle() untuk mengeluarkan resep tersebut dari daftar favorit.</p><h3>C.6 Badge Jumlah Favorit di AppBar</h3><p><code>lib/widgets/favorite_badge_button.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/pages/favorite_page.dart';
import 'package:resepku/providers/favorite_provider.dart';

class FavoriteBadgeButton extends StatelessWidget {
  const FavoriteBadgeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch&lt;FavoriteProvider&gt;().count;

    return IconButton(
      tooltip: 'Favorit saya',
      icon: Badge(
        isLabelVisible: count &gt; 0,
        label: Text('$count'),
        child: const Icon(Icons.favorite),
      ),
      onPressed: () =&gt; Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =&gt; const FavoritePage()),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: FavoriteBadgeButton</em></p><p>FavoriteBadgeButton dibuat sebagai widget terpisah agar hanya bagian ini yang dibangun ulang ketika jumlah favorit berubah, bukan seluruh HomePage. Widget ini membaca count menggunakan context.watch, lalu menampilkannya melalui widget Badge dari Material 3 di atas ikon hati. Label badge hanya terlihat ketika count lebih dari nol, dan menekan tombol akan membuka FavoritePage.</p><p><code>lib/pages/home_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResepKu'),
        actions: const [FavoriteBadgeButton()],
      ),
      body: ListView(
        children: [
          for (final recipe in dummyRecipes) RecipeTile(recipe: recipe),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: HomePage dengan FavoriteBadgeButton</em></p><p>FavoriteBadgeButton dipasang pada parameter actions di AppBar HomePage. Karena seluruh pembacaan data favorit sudah ditangani oleh RecipeTile dan FavoriteBadgeButton, HomePage sendiri tetap menjadi StatelessWidget tanpa perlu mengetahui isi daftar favorit.</p><h3>C.7 Pengujian Aplikasi</h3><table><tbody><tr><th><p>No</p></th><th><p>Skenario</p></th><th><p>Hasil yang Diharapkan</p></th><th><p>Sesuai?</p></th></tr><tr><td><p>1</p></td><td><p>Tap ikon hati pada Margherita dan Alfredo di Home</p></td><td><p>Ikon berwarna merah, badge menunjukkan angka 2</p></td><td><p>✓</p></td></tr><tr><td><p>2</p></td><td><p>Buka detail Margherita</p></td><td><p>Ikon hati di AppBar terisi</p></td><td><p>✓</p></td></tr><tr><td><p>3</p></td><td><p>Di halaman detail, tap ikon hati, lalu kembali ke Home</p></td><td><p>Ikon Margherita kosong, badge menunjukkan angka 1</p></td><td><p>✓</p></td></tr><tr><td><p>4</p></td><td><p>Tap badge di AppBar</p></td><td><p>Halaman Favorit hanya berisi Alfredo</p></td><td><p>✓</p></td></tr><tr><td><p>5</p></td><td><p>Hapus Alfredo dari halaman Favorit, lalu kembali</p></td><td><p>Muncul pesan "Belum ada resep favorit", badge hilang</p></td><td><p>✓</p></td></tr><tr><td><p>6</p></td><td><p>Ubah porsi menjadi 2, kembali ke Home, lalu buka lagi resep yang sama</p></td><td><p>Porsi kembali ke nilai awal, karena state lokal ikut dibuang ketika halaman ditutup</p></td><td><p>✓</p></td></tr></tbody></table><p>Keenam skenario pengujian memberikan hasil sesuai dengan yang diharapkan. Skenario 1 hingga 5 menunjukkan bahwa perubahan favorit dari daftar resep, halaman detail, maupun halaman Favorit langsung tercermin di seluruh bagian aplikasi karena semuanya membaca sumber data yang sama dari FavoriteProvider. Skenario 6 menunjukkan bahwa jumlah porsi kembali ke nilai awal ketika halaman detail dibuka ulang, karena _servings merupakan state lokal yang ikut dibuang bersama halaman.</p><h3>Checkpoint 2</h3><img src="/images/legacy/MobApp/Praktikum6/checkpoint2_home_badge.webp" alt="Checkpoint 2: Halaman Home dengan Badge Bernilai 2"><p style="text-align: center"><em>Checkpoint 2: Halaman Home dengan Badge Bernilai 2</em></p><p>Setelah ikon hati pada Classic Margherita Pizza dan Chicken Alfredo Pasta ditekan, kedua ikon berubah menjadi merah dan badge pada AppBar menunjukkan angka 2.</p><img src="/images/legacy/MobApp/Praktikum6/checkpoint2_detail_favorit.webp" alt="Checkpoint 2: Halaman Detail dengan Ikon Hati Terisi"><p style="text-align: center"><em>Checkpoint 2: Halaman Detail dengan Ikon Hati Terisi</em></p><p>Halaman detail resep yang telah difavoritkan menampilkan ikon hati terisi pada AppBar, membuktikan bahwa halaman detail kini dapat membaca status favorit yang ditetapkan dari halaman Home.</p><img src="/images/legacy/MobApp/Praktikum6/checkpoint2_halaman_favorit.webp" alt="Checkpoint 2: Halaman Favorit"><p style="text-align: center"><em>Checkpoint 2: Halaman Favorit</em></p><p>Halaman Favorit yang dibuka melalui badge menampilkan daftar resep yang sedang difavoritkan beserta tombol hapus pada setiap item.</p>$wp$, 1 from public.reports where slug = 'mobile-app-06-state-management';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Pertanyaan Analisis$wp$, $wp$<p><strong>1. Keterbatasan state lokal pada fitur favorit.</strong> Ikon hati dapat berubah karena setState() membangun ulang tile yang menyimpan _isFavorite, tetapi jumlah favorit tidak dapat ditampilkan pada AppBar HomePage dan halaman detail tidak dapat mengetahui status favorit suatu resep. Penyebabnya adalah data _isFavorite tersimpan secara terpisah di dalam _RecipeTileState milik setiap tile, sementara data pada Flutter hanya mengalir dari parent ke child. HomePage sebagai parent tidak dapat membaca state milik child-nya, dan DetailPage hanya menerima objek Recipe yang tidak memuat informasi favorit. Oleh karena itu, data yang dibutuhkan oleh banyak widget dan halaman perlu dipindahkan ke tempat yang lebih tinggi pada widget tree, yaitu ke dalam Provider.</p><p><strong>2. Mengapa jumlah porsi tetap menggunakan setState()?</strong> Jumlah porsi hanya dibutuhkan oleh halaman detail resep yang sedang dibuka dan tidak dibaca oleh widget atau halaman lain, sehingga termasuk state lokal yang cukup dikelola dengan setState(). Hasil skenario keenam pada pengujian menunjukkan bahwa porsi kembali ke nilai awal setiap kali halaman detail dibuka ulang, karena objek State dibuang ketika halaman ditutup dan initState() kembali mengisi _servings dari data resep. Perilaku ini memang diharapkan, karena pengaturan porsi bersifat sementara untuk satu kali melihat resep. Apabila porsi dimasukkan ke Provider, nilainya akan tetap tersimpan setelah halaman ditutup dan perlu dikelola untuk setiap resep, sehingga menambah kompleksitas tanpa memberikan manfaat.</p><p><strong>3. Apa yang terjadi jika ChangeNotifierProvider dipindahkan ke dalam HomePage?</strong> Halaman Home dan badge tetap berfungsi, tetapi ketika halaman Favorit dibuka, aplikasi menampilkan error ProviderNotFoundException. Hal ini terjadi karena Provider hanya dapat diakses oleh widget yang berada di bawahnya pada widget tree. Ketika halaman baru dibuka dengan Navigator.push, halaman tersebut ditempatkan sebagai route baru di dalam Navigator milik MaterialApp, sejajar dengan HomePage dan bukan di dalamnya. Akibatnya, FavoritePage dan DetailPage tidak lagi berada di bawah provider tersebut. Dengan memasang provider kembali di atas MaterialApp, seluruh route berada di bawah provider sehingga dapat mengaksesnya kembali.</p>$wp$, 2 from public.reports where slug = 'mobile-app-06-state-management';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Latihan$wp$, $wp$<h3>Latihan 1: Tema Gelap dan Terang</h3><h3>A. Membuat ThemeProvider</h3><p><code>lib/providers/theme_provider.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode =&gt; _themeMode;
  bool get isDarkMode =&gt; _themeMode == ThemeMode.dark;

  void setDarkMode(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}</code></pre><p style="text-align: center"><em>Kode Program: ThemeProvider</em></p><p>ThemeProvider meng-extend ChangeNotifier dan menyimpan mode tema pada field private _themeMode dengan nilai awal ThemeMode.light. Getter themeMode digunakan oleh MaterialApp, sedangkan getter isDarkMode mempermudah halaman Pengaturan menentukan posisi switch. Method setDarkMode mengubah _themeMode sesuai nilai yang diterima, lalu memanggil notifyListeners() agar widget yang mendengarkan ikut diperbarui.</p><h3>B. Mendaftarkan ThemeProvider dan Mengatur Tema di MaterialApp</h3><p><code>lib/main.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/pages/home_page.dart';
import 'package:resepku/providers/favorite_provider.dart';
import 'package:resepku/providers/theme_provider.dart';
import 'package:resepku/widgets/identity_footer.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =&gt; FavoriteProvider()),
        ChangeNotifierProvider(create: (context) =&gt; ThemeProvider()),
      ],
      child: const ResepKuApp(),
    ),
  );
}

class ResepKuApp extends StatelessWidget {
  const ResepKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch&lt;ThemeProvider&gt;().themeMode;

    return MaterialApp(
      title: 'ResepKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      builder: (context, child) =&gt; IdentityFooter(child: child!),
      home: const HomePage(),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: ThemeProvider pada MultiProvider dan MaterialApp</em></p><p>ThemeProvider didaftarkan sebagai ChangeNotifierProvider kedua di dalam MultiProvider, sehingga provider baru dapat ditambahkan tanpa mengubah struktur yang sudah ada. MaterialApp kini memiliki dua tema, yaitu theme untuk mode terang dan darkTheme dengan brightness gelap, sedangkan tema yang aktif ditentukan oleh parameter themeMode. Nilai themeMode dibaca menggunakan context.watch, bukan context.read, karena MaterialApp harus dibangun ulang setiap kali mode tema berubah. Apabila menggunakan read, nilai hanya dibaca satu kali dan perubahan dari switch tidak akan diterapkan. Parameter builder untuk footer identitas tetap digunakan agar footer tampil di setiap halaman.</p><h3>C. Membuat Halaman Pengaturan</h3><p><code>lib/pages/settings_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch&lt;ThemeProvider&gt;().isDarkMode;

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Mode gelap'),
            subtitle: const Text('Ubah tampilan aplikasi menjadi tema gelap'),
            value: isDarkMode,
            onChanged: (value) =&gt; context.read&lt;ThemeProvider&gt;().setDarkMode(value),
          ),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: SettingsPage</em></p><p>SettingsPage berisi SwitchListTile berjudul Mode gelap. Posisi switch ditentukan oleh isDarkMode yang dibaca menggunakan context.watch agar switch selalu sesuai dengan tema yang sedang aktif. Ketika switch digeser, callback onChanged memanggil setDarkMode melalui context.read dengan nilai switch yang baru.</p><h3>D. Menambahkan Tombol Pengaturan di HomePage</h3><p><code>lib/pages/home_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/pages/settings_page.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResepKu'),
        actions: [
          const FavoriteBadgeButton(),
          IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings),
            onPressed: () =&gt; Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =&gt; const SettingsPage()),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final recipe in dummyRecipes) RecipeTile(recipe: recipe),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: Tombol Pengaturan pada AppBar HomePage</em></p><p>Sebuah IconButton dengan ikon settings ditambahkan pada actions AppBar HomePage di samping FavoriteBadgeButton. Karena IconButton memiliki callback onPressed, list actions tidak lagi bertanda const, sedangkan FavoriteBadgeButton tetap dibuat dengan const. Menekan tombol ini akan membuka SettingsPage menggunakan Navigator.push.</p><img src="/images/legacy/MobApp/Praktikum6/latihan1_pengaturan_terang.webp" alt="Hasil Tampilan: Halaman Pengaturan dengan Mode Terang"><p style="text-align: center"><em>Hasil Tampilan: Halaman Pengaturan dengan Mode Terang</em></p><p>Halaman Pengaturan menampilkan SwitchListTile Mode gelap dalam keadaan tidak aktif, dengan tampilan aplikasi masih menggunakan tema terang.</p><img src="/images/legacy/MobApp/Praktikum6/latihan1_pengaturan_gelap.webp" alt="Hasil Tampilan: Halaman Pengaturan Setelah Mode Gelap Diaktifkan"><p style="text-align: center"><em>Hasil Tampilan: Halaman Pengaturan Setelah Mode Gelap Diaktifkan</em></p><p>Setelah switch diaktifkan, tampilan halaman langsung berubah menjadi tema gelap tanpa perlu memuat ulang aplikasi, karena MaterialApp dibangun ulang setelah ThemeProvider memanggil notifyListeners().</p><img src="/images/legacy/MobApp/Praktikum6/latihan1_home_gelap.webp" alt="Hasil Tampilan: Halaman Home dalam Mode Gelap"><p style="text-align: center"><em>Hasil Tampilan: Halaman Home dalam Mode Gelap</em></p><p>Ketika kembali ke halaman Home, daftar resep dan AppBar juga tampil dalam tema gelap, lengkap dengan tombol pengaturan dan badge favorit pada AppBar.</p><img src="/images/legacy/MobApp/Praktikum6/latihan1_detail_gelap.webp" alt="Hasil Tampilan: Halaman Detail dalam Mode Gelap"><p style="text-align: center"><em>Hasil Tampilan: Halaman Detail dalam Mode Gelap</em></p><p>Halaman detail resep turut menggunakan tema gelap, yang menunjukkan bahwa perubahan tema berlaku untuk seluruh aplikasi karena diatur langsung pada MaterialApp.</p><h3>Latihan 2: Menghapus Semua Favorit</h3><h3>A. Tombol Hapus Semua dengan Konfirmasi</h3><p><code>lib/pages/favorite_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/favorite_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  Future&lt;void&gt; _confirmClearAll(BuildContext context) async {
    final confirmed = await showDialog&lt;bool&gt;(
      context: context,
      builder: (dialogContext) =&gt; AlertDialog(
        title: const Text('Hapus semua favorit?'),
        content: const Text('Semua resep akan dihapus dari daftar favorit.'),
        actions: [
          TextButton(
            onPressed: () =&gt; Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () =&gt; Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true &amp;&amp; context.mounted) {
      context.read&lt;FavoriteProvider&gt;().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = context.watch&lt;FavoriteProvider&gt;().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya'),
        actions: [
          IconButton(
            tooltip: 'Hapus semua',
            icon: const Icon(Icons.delete_sweep),
            onPressed: count == 0 ? null : () =&gt; _confirmClearAll(context),
          ),
        ],
      ),
      body: Consumer&lt;FavoriteProvider&gt;(
        builder: (context, favorite, child) {
          if (favorite.count == 0) {
            return const Center(
              child: Text(
                'Belum ada resep favorit.\nTekan ikon hati di daftar resep.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView(
            children: [
              for (final recipe in favorite.items)
                ListTile(
                  title: Text(recipe.name),
                  subtitle: Text(recipe.cuisine),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () =&gt; favorite.toggle(recipe),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: FavoritePage dengan Tombol Hapus Semua</em></p><p>Pada AppBar FavoritePage ditambahkan IconButton Hapus semua dengan ikon delete_sweep. Jumlah favorit dibaca menggunakan context.watch, sehingga ketika count bernilai nol, onPressed diisi null dan tombol otomatis nonaktif. Apabila daftar favorit berisi data, tombol memanggil method _confirmClearAll yang menampilkan AlertDialog berisi tombol Batal dan Hapus. Dialog dikembalikan dengan nilai false atau true melalui Navigator.pop menggunakan dialogContext, kemudian clear() dari FavoriteProvider hanya dipanggil apabila pengguna memilih Hapus. Pemeriksaan context.mounted memastikan halaman masih aktif sebelum provider diakses setelah proses await selesai.</p><img src="/images/legacy/MobApp/Praktikum6/latihan2_favorit_terisi.webp" alt="Hasil Tampilan: Halaman Favorit dengan Tombol Hapus Semua"><p style="text-align: center"><em>Hasil Tampilan: Halaman Favorit dengan Tombol Hapus Semua</em></p><p>Halaman Favorit yang berisi beberapa resep menampilkan tombol Hapus semua pada AppBar dalam keadaan aktif.</p><img src="/images/legacy/MobApp/Praktikum6/latihan2_dialog.webp" alt="Hasil Tampilan: Dialog Konfirmasi Hapus Semua Favorit"><p style="text-align: center"><em>Hasil Tampilan: Dialog Konfirmasi Hapus Semua Favorit</em></p><p>Ketika tombol Hapus semua ditekan, dialog konfirmasi muncul terlebih dahulu sehingga daftar favorit tidak langsung terhapus. Menekan Batal akan menutup dialog tanpa mengubah daftar favorit.</p><img src="/images/legacy/MobApp/Praktikum6/latihan2_favorit_kosong.webp" alt="Hasil Tampilan: Halaman Favorit Setelah Semua Favorit Dihapus"><p style="text-align: center"><em>Hasil Tampilan: Halaman Favorit Setelah Semua Favorit Dihapus</em></p><p>Setelah Hapus dipilih, seluruh resep favorit terhapus dan halaman menampilkan pesan bahwa belum ada resep favorit. Tombol Hapus semua berubah menjadi nonaktif karena daftar favorit telah kosong, dan badge pada halaman Home ikut menghilang.</p>$wp$, 3 from public.reports where slug = 'mobile-app-06-state-management';
insert into public.report_sections (report_id, title, content, position) select id, $wp$5. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa tempat penyimpanan state perlu disesuaikan dengan seberapa luas data tersebut digunakan. Data yang hanya dibutuhkan oleh satu widget, seperti jumlah porsi pada halaman detail, cukup dikelola sebagai state lokal dengan StatefulWidget dan setState(), dan nilainya wajar hilang ketika halaman ditutup. Sebaliknya, data yang dibutuhkan oleh banyak widget dan halaman, seperti daftar favorit dan mode tema, perlu disimpan sebagai state global menggunakan Provider yang dipasang di atas MaterialApp. Percobaan menyimpan favorit di dalam setiap tile membuktikan bahwa state lokal tidak dapat dibaca oleh widget lain, sedangkan penerapan FavoriteProvider dan ThemeProvider menunjukkan bahwa satu perubahan dapat langsung tercermin di seluruh aplikasi melalui notifyListeners(). Penggunaan context.watch di dalam build(), context.read di dalam callback, dan Consumer untuk membangun ulang bagian tertentu membuat pembaruan tampilan menjadi tepat sasaran.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDartProvider</p>$wp$, 4 from public.reports where slug = 'mobile-app-06-state-management';
update public.reports set updated_at = now() where slug = 'mobile-app-06-state-management';

-- laprak_MobApp-7.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'mobile-app-07-list-grid-images-assets');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum ketujuh Aplikasi Mobile ini membahas cara menampilkan data dalam bentuk list dan grid, serta cara menggunakan gambar dan asset pada aplikasi ResepKu. Sebelumnya daftar resep hanya menampilkan teks dan huruf inisial, sehingga pada praktikum ini setiap resep dilengkapi foto yang diambil dari internet. Selain foto, aplikasi juga ditambahkan logo dan font Poppins yang disimpan sebagai asset di dalam project.</p><p>Gambar pada Flutter dapat ditampilkan dari dua sumber. Image.asset digunakan untuk file yang disimpan di dalam project dan ikut dibundel ke dalam aplikasi, sehingga dapat tampil langsung tanpa koneksi internet. Sementara itu, Image.network digunakan untuk gambar yang diunduh dari internet, sehingga memerlukan penanganan loading state selama gambar diunduh dan error state ketika gambar gagal dimuat. Daftar resep ditampilkan menggunakan ListView.builder dan GridView.builder yang membuat item secara lazy, yaitu hanya ketika item tersebut akan tampil di layar. Kedua tampilan tersebut dapat dipilih melalui satu tombol pada AppBar, dan fitur favorit tetap berfungsi pada keduanya.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mahasiswa mampu mendaftarkan asset gambar dan custom font di pubspec.yaml, lalu menggunakannya dengan Image.asset dan ThemeData.</p></li><li><p>Mahasiswa mampu menampilkan gambar dari internet dengan Image.network beserta loading state dan error state.</p></li><li><p>Mahasiswa mampu menampilkan data dengan ListView.builder dan GridView.builder.</p></li><li><p>Mahasiswa mampu mengganti tampilan list dan grid dengan state lokal (setState) tanpa mengganggu state favorit di Provider.</p></li></ul>$wp$, 0 from public.reports where slug = 'mobile-app-07-list-grid-images-assets';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja$wp$, $wp$<h3>Bagian A: Asset Gambar dan Custom Font</h3><h3>A.1 Menyiapkan Folder Assets</h3><p><code>Terminal</code></p><pre><code class="language-bash">mkdir assets
mkdir assets/images
mkdir assets/fonts</code></pre><p style="text-align: center"><em>Kode Program: Membuat Folder Assets</em></p><p>Folder assets dibuat di folder utama project, sejajar dengan folder lib, beserta dua subfolder yaitu images dan fonts. File logo.png dan placeholder.png disalin ke assets/images, sedangkan Poppins-Regular.ttf, Poppins-Medium.ttf, dan Poppins-Bold.ttf disalin ke assets/fonts. Nama file harus ditulis persis sama, termasuk huruf besar dan kecilnya, karena nama tersebut yang akan dirujuk di pubspec.yaml dan di dalam kode.</p><p><code>resepku/</code></p><pre><code class="language-plaintext">resepku/
├── assets/
│   ├── images/   logo.png, placeholder.png
│   └── fonts/    Poppins-Regular.ttf, Poppins-Medium.ttf, Poppins-Bold.ttf
├── pubspec.yaml
└── lib/
    ├── main.dart
    ├── pages/
    │   ├── home_page.dart
    │   ├── detail_page.dart
    │   └── favorite_page.dart
    └── widgets/
        ├── recipe_image.dart
        ├── recipe_tile.dart
        ├── recipe_grid_card.dart
        └── favorite_badge_button.dart</code></pre><p style="text-align: center"><em>Kode Program: Struktur Folder Project</em></p><p>Struktur di atas menunjukkan susunan project setelah seluruh langkah selesai dikerjakan. Selain folder assets, terdapat dua widget baru yaitu recipe_image.dart untuk menampilkan foto resep dan recipe_grid_card.dart untuk kartu pada tampilan grid.</p><h3>A.2 Mendaftarkan Asset dan Font di pubspec.yaml</h3><p><code>pubspec.yaml (bagian bawah)</code></p><pre><code class="language-yaml">flutter:
  uses-material-design: true

  assets:
    - assets/images/

  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700</code></pre><p style="text-align: center"><em>Kode Program: Pendaftaran Asset dan Font</em></p><p>Bagian assets mendaftarkan folder assets/images/. Tanda garis miring di akhir menandakan bahwa yang didaftarkan adalah satu folder, sehingga seluruh file di dalamnya otomatis dapat digunakan tanpa perlu didaftarkan satu per satu. Bagian fonts mendaftarkan keluarga font bernama Poppins yang terdiri dari tiga file. File Regular tidak diberi weight sehingga dianggap sebagai ketebalan normal (400), sedangkan file Medium dan Bold masing-masing diberi weight 500 dan 700 agar Flutter memakai file yang sesuai ketika teks ditampilkan dengan ketebalan tersebut. Karena YAML menggunakan indentasi dua spasi sebagai penanda struktur, assets dan fonts harus sejajar dengan uses-material-design. Setelah file disimpan, flutter pub get dijalankan untuk memuat konfigurasi baru.</p><h3>A.3 Memasang Font di Tema Aplikasi</h3><p><code>lib/main.dart (potongan)</code></p><pre><code class="language-dart">theme: ThemeData(
  colorSchemeSeed: Colors.deepOrange,
  fontFamily: 'Poppins', // didaftarkan di pubspec.yaml
),
darkTheme: ThemeData(
  colorSchemeSeed: Colors.deepOrange,
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
),</code></pre><p style="text-align: center"><em>Kode Program: fontFamily pada ThemeData</em></p><p>Parameter fontFamily dengan nilai 'Poppins' ditambahkan pada theme dan darkTheme di MaterialApp. Nilai ini harus sama persis dengan nama family yang didaftarkan di pubspec.yaml. Dengan memasang font pada tema, seluruh teks di aplikasi otomatis menggunakan Poppins tanpa perlu mengatur font pada setiap widget Text, baik pada mode terang maupun mode gelap. Parameter builder untuk footer identitas tetap digunakan.</p><h3>A.4 Logo di AppBar</h3><p><code>lib/pages/home_page.dart (potongan)</code></p><pre><code class="language-dart">title: Row(
  children: [
    Image.asset('assets/images/logo.png', height: 32),
    const SizedBox(width: 8),
    const Text('ResepKu'),
  ],
),</code></pre><p style="text-align: center"><em>Kode Program: Logo pada Judul AppBar</em></p><p>Parameter title pada AppBar HomePage diubah menjadi Row yang berisi logo dan teks ResepKu. Logo ditampilkan dengan Image.asset menggunakan path yang sesuai dengan lokasi file di folder assets, dengan tinggi 32 agar sejajar dengan teks judul. Karena asset dan font baru hanya dimasukkan ke aplikasi saat proses build, aplikasi perlu dihentikan lalu dijalankan kembali dengan flutter run, karena hot reload maupun hot restart tidak selalu memuat asset yang baru ditambahkan.</p><h3>Checkpoint 1</h3><img src="/images/legacy/MobApp/Praktikum7/checkpoint1_logo_font.webp" alt="Checkpoint 1: Halaman Home dengan Logo dan Font Poppins"><p style="text-align: center"><em>Checkpoint 1: Halaman Home dengan Logo dan Font Poppins</em></p><p>Halaman Home menampilkan logo di sebelah kiri judul ResepKu pada AppBar. Seluruh teks pada aplikasi, termasuk judul, nama resep, dan keterangan di bawahnya, kini menggunakan font Poppins yang terlihat dari bentuk huruf a dan g yang lebih bulat serta bentuk angka yang berbeda dari font bawaan.</p><h3>Bagian B: ListView.builder dan Foto Resep</h3><h3>B.1 Membuat Widget RecipeImage</h3><p><code>lib/widgets/recipe_image.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';

/// Foto resep dari internet, lengkap dengan loading state dan error state.
class RecipeImage extends StatelessWidget {
  const RecipeImage({super.key, required this.url, this.cacheWidth});

  final String url;

  /// Lebar (pixel) saat gambar di-decode. Gambar kecil cukup di-decode kecil,
  /// sehingga memory yang dipakai jauh lebih sedikit.
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      cacheWidth: cacheWidth,
      // Loading state: tampil selama gambar masih diunduh.
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child; // unduhan selesai
        // Loading State
        return ColoredBox(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(child: Icon(Icons.restaurant_menu)),
        );
      },
      // Error state: tampil jika URL salah atau tidak ada koneksi.
      errorBuilder: (context, error, stackTrace) {
        return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
      },
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeImage</em></p><p>Foto resep digunakan di tiga tempat, yaitu daftar resep, kartu grid, dan halaman detail, sehingga logika menampilkan foto dibuat sekali dalam widget RecipeImage. Widget ini menggunakan Image.network dengan BoxFit.cover agar foto mengisi seluruh area tanpa berubah proporsi, dengan bagian yang berlebih dipotong. Parameter loadingBuilder dipanggil berkali-kali selama foto diunduh; ketika loadingProgress bernilai null, unduhan sudah selesai sehingga foto asli (child) dikembalikan, sedangkan selama proses unduh ditampilkan kotak berwarna dengan ikon restaurant_menu. Parameter errorBuilder dipanggil ketika foto gagal dimuat, misalnya karena URL salah atau tidak ada koneksi, dan menampilkan gambar placeholder dari asset. Parameter cacheWidth bersifat opsional dan menentukan lebar foto dalam pixel ketika di-decode, sehingga foto berukuran besar dari server tidak harus disimpan di memory dalam ukuran aslinya.</p><h3>B.2 Thumbnail di RecipeTile</h3><p><code>lib/widgets/recipe_tile.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/detail_page.dart';
import 'package:resepku/providers/favorite_provider.dart';
import 'package:resepku/widgets/recipe_image.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    // watch: widget ini ikut rebuild saat daftar favorit berubah
    final isFavorite = context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe);

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 56,
          height: 56,
          // 56 dp x 3 (kepadatan layar umum) = 168 pixel
          child: RecipeImage(url: recipe.image, cacheWidth: 168),
        ),
      ),
      title: Text(recipe.name),
      subtitle: Text(
        '${recipe.cuisine} • ${recipe.totalTimeMinutes} menit • ★ ${recipe.rating}',
      ),
      trailing: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : null,
        ),
        // read: di dalam callback cukup "membaca", tidak perlu listen
        onPressed: () =&gt; context.read&lt;FavoriteProvider&gt;().toggle(recipe),
      ),
      onTap: () =&gt; Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =&gt; DetailPage(recipe: recipe)),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeTile dengan Thumbnail Foto</em></p><p>Perubahan pada RecipeTile hanya terdapat pada bagian leading. CircleAvatar berisi huruf inisial diganti dengan foto resep berukuran 56 x 56 dp yang dibungkus ClipRRect dengan radius 8 agar sudutnya membulat. Foto diberi cacheWidth 168 karena thumbnail tampil selebar 56 dp, dan pada layar dengan kepadatan tiga kali (devicePixelRatio 3) ukuran tersebut setara dengan 168 pixel fisik. Men-decode foto lebih besar dari ukuran itu hanya akan memboroskan memory. Bagian lain seperti tombol favorit dan navigasi ke halaman detail tidak berubah.</p><h3>B.3 ListView.builder di HomePage</h3><p><code>lib/pages/home_page.dart (versi ListView.builder)</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 32),
            const SizedBox(width: 8),
            const Text('ResepKu'),
          ],
        ),
        actions: const [FavoriteBadgeButton()],
      ),
      body: ListView.builder(
        itemCount: dummyRecipes.length,
        itemBuilder: (context, index) {
          return RecipeTile(recipe: dummyRecipes[index]);
        },
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: HomePage dengan ListView.builder</em></p><p>Body HomePage yang sebelumnya berupa ListView dengan children diganti menjadi ListView.builder. Parameter itemCount diisi jumlah resep, sedangkan itemBuilder membuat RecipeTile untuk resep pada indeks tertentu. Berbeda dengan ListView biasa yang membuat seluruh item sekaligus, ListView.builder hanya membuat item yang akan tampil di layar, sehingga lebih hemat ketika jumlah data bertambah. Saat aplikasi pertama kali dibuka, kotak berikon muncul sebentar di setiap baris sebelum foto tampil, yang merupakan loading state dari RecipeImage.</p><h3>B.4 Menguji Error State</h3><p>Pengujian error state dilakukan dengan mengubah sementara URL foto resep pertama di dummy_recipes.dart menjadi alamat yang tidak valid, yaitu dengan mengganti ekstensi 1.webp menjadi 1.webpx, kemudian melakukan hot restart. Foto yang gagal dimuat diganti dengan gambar placeholder dari asset, dan aplikasi tetap berjalan tanpa menampilkan layar error merah. Setelah pengujian selesai, URL dikembalikan seperti sebelumnya.</p><h3>Checkpoint 2</h3><img src="/images/legacy/MobApp/Praktikum7/checkpoint2_thumbnail.webp" alt="Checkpoint 2: Halaman Home dengan Thumbnail Foto Resep"><p style="text-align: center"><em>Checkpoint 2: Halaman Home dengan Thumbnail Foto Resep</em></p><p>Setiap baris pada daftar resep kini menampilkan thumbnail foto berukuran persegi dengan sudut membulat di sebelah kiri nama resep, menggantikan avatar berisi huruf inisial.</p><img src="/images/legacy/MobApp/Praktikum7/checkpoint2_error_state.webp" alt="Checkpoint 2: Halaman Home saat Error State Aktif"><p style="text-align: center"><em>Checkpoint 2: Halaman Home saat Error State Aktif</em></p><p>Ketika URL foto resep pertama tidak valid, thumbnail resep tersebut menampilkan gambar placeholder, sedangkan resep lain tetap menampilkan fotonya masing-masing. Hal ini menunjukkan bahwa errorBuilder berhasil menangani kegagalan memuat foto tanpa mengganggu bagian lain dari aplikasi.</p><h3>Bagian C: GridView dan Tombol Ganti Tampilan</h3><h3>C.1 Membuat RecipeGridCard</h3><p><code>lib/widgets/recipe_grid_card.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/detail_page.dart';
import 'package:resepku/providers/favorite_provider.dart';
import 'package:resepku/widgets/recipe_image.dart';

class RecipeGridCard extends StatelessWidget {
  const RecipeGridCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.antiAlias, // gambar ikut terpotong sesuai sudut Card
      child: InkWell(
        onTap: () =&gt; Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =&gt; DetailPage(recipe: recipe)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RecipeImage(url: recipe.image, cacheWidth: 500),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton.filledTonal(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () =&gt;
                          context.read&lt;FavoriteProvider&gt;().toggle(recipe),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '★ ${recipe.rating} • ${recipe.totalTimeMinutes} menit',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: RecipeGridCard</em></p><p>RecipeGridCard menampilkan satu resep dalam bentuk kartu untuk tampilan grid. Card diberi clipBehavior Clip.antiAlias agar foto ikut terpotong mengikuti sudut kartu yang membulat, dan seluruh kartu dibungkus InkWell sehingga dapat diketuk dengan efek ripple untuk membuka halaman detail. Bagian atas kartu menggunakan Expanded berisi Stack, sehingga foto mengisi sisa tinggi kartu dan tombol favorit dapat diletakkan di atas foto menggunakan Positioned di pojok kanan atas. Bagian bawah berisi nama resep yang dibatasi satu baris dengan maxLines dan TextOverflow.ellipsis agar nama yang panjang tidak menyebabkan overflow, diikuti rating dan total waktu memasak. Status favorit tetap dibaca dengan context.watch dan diubah dengan context.read seperti pada RecipeTile.</p><h3>C.2 HomePage dengan List dan Grid</h3><p><code>lib/pages/home_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_grid_card.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State&lt;HomePage&gt; createState() =&gt; _HomePageState();
}

class _HomePageState extends State&lt;HomePage&gt; {
  bool _isGrid = false; // ephemeral state: hanya HomePage yang membutuhkan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 32),
            const SizedBox(width: 8),
            const Text('ResepKu'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'Tampilan list' : 'Tampilan grid',
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () =&gt; setState(() =&gt; _isGrid = !_isGrid),
          ),
          const FavoriteBadgeButton(),
        ],
      ),
      body: _isGrid ? _buildGrid() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: dummyRecipes.length,
      itemBuilder: (context, index) {
        return RecipeTile(recipe: dummyRecipes[index]);
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4, // lebar : tinggi
      ),
      itemCount: dummyRecipes.length,
      itemBuilder: (context, index) {
        return RecipeGridCard(recipe: dummyRecipes[index]);
      },
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: HomePage dengan Tombol Ganti Tampilan</em></p><p>HomePage diubah menjadi StatefulWidget karena kini memiliki state _isGrid yang menentukan tampilan aktif, dengan nilai awal false sehingga daftar resep ditampilkan sebagai list. State ini cukup dikelola dengan setState karena hanya dibutuhkan oleh HomePage. Tombol pada actions AppBar membalik nilai _isGrid, dengan ikon dan tooltip yang menyesuaikan tampilan yang akan dipilih. Body memanggil _buildGrid atau _buildList sesuai nilai _isGrid. Method _buildGrid menggunakan GridView.builder dengan SliverGridDelegateWithFixedCrossAxisCount yang mengatur grid selalu terdiri dari dua kolom, jarak antarkartu 8 baik secara vertikal maupun horizontal, serta childAspectRatio 3/4 sehingga kartu lebih tinggi daripada lebarnya agar foto dan teks dapat termuat.</p><h3>C.3 Menghitung Ukuran Kartu</h3><p>Ukuran kartu grid dihitung untuk HP dengan lebar layar 360 dp. Lebar kartu diperoleh dari lebar layar dikurangi padding kiri dan kanan GridView, lalu dikurangi jarak antarkolom, kemudian dibagi jumlah kolom. Tinggi kartu diperoleh dari lebar kartu dibagi childAspectRatio.</p><table><tbody><tr><th><p>Yang dihitung</p></th><th><p>Langkah perhitungan</p></th><th><p>Hasil</p></th></tr><tr><td><p>Lebar area grid</p></td><td><p>360 − (8 + 8) = 344</p></td><td><p>344 dp</p></td></tr><tr><td><p>Lebar kartu (dp)</p></td><td><p>(344 − 8) / 2 = 336 / 2</p></td><td><p><strong>168 dp</strong></p></td></tr><tr><td><p>Tinggi kartu (dp)</p></td><td><p>168 / (3/4) = 168 × 4/3</p></td><td><p><strong>224 dp</strong></p></td></tr></tbody></table><p>Dengan dua kolom, terdapat satu jarak crossAxisSpacing sebesar 8 dp di antara kedua kartu, sehingga lebar setiap kartu adalah 168 dp. Karena childAspectRatio merupakan perbandingan lebar terhadap tinggi, tinggi kartu adalah 168 dibagi 0,75, yaitu 224 dp.</p><h3>Bagian D: Foto di Halaman Detail dan Pengujian</h3><h3>D.1 Foto Besar di Halaman Detail</h3><p><code>lib/pages/detail_page.dart (import)</code></p><pre><code class="language-dart">import 'package:resepku/widgets/recipe_image.dart';</code></pre><p style="text-align: center"><em>Kode Program: Import RecipeImage pada DetailPage</em></p><p><code>lib/pages/detail_page.dart (potongan)</code></p><pre><code class="language-dart">ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: AspectRatio(
    aspectRatio: 16 / 9,
    child: RecipeImage(url: recipe.image),
  ),
),
const SizedBox(height: 16),</code></pre><p style="text-align: center"><em>Kode Program: Foto Resep sebagai Child Pertama ListView</em></p><p>RecipeImage digunakan kembali pada halaman detail dan diletakkan sebagai child pertama ListView. Foto dibungkus AspectRatio 16/9 agar tingginya menyesuaikan lebar layar dengan proporsi yang tetap, dan ClipRRect dengan radius 16 agar sudutnya membulat. Pada halaman ini cacheWidth tidak diisi, karena foto tampil hampir selebar layar sehingga membutuhkan resolusi yang lebih besar dibandingkan thumbnail.</p><h3>D.2 Pengujian Aplikasi</h3><table><tbody><tr><th><p>No</p></th><th><p>Skenario</p></th><th><p>Hasil yang Diharapkan</p></th><th><p>Sesuai?</p></th></tr><tr><td><p>1</p></td><td><p>Buka aplikasi</p></td><td><p>Logo di AppBar, font Poppins, thumbnail foto di setiap resep</p></td><td><p>✓</p></td></tr><tr><td><p>2</p></td><td><p>Tekan tombol grid di AppBar</p></td><td><p>Resep tampil sebagai kartu dua kolom; ikon tombol berubah menjadi ikon list</p></td><td><p>✓</p></td></tr><tr><td><p>3</p></td><td><p>Di mode grid, tap ikon hati pada Margherita</p></td><td><p>Ikon merah dan badge bertambah</p></td><td><p>✓</p></td></tr><tr><td><p>4</p></td><td><p>Kembali ke mode list</p></td><td><p>Ikon hati Margherita tetap merah</p></td><td><p>✓</p></td></tr><tr><td><p>5</p></td><td><p>Tap kartu Alfredo di mode grid</p></td><td><p>Halaman detail terbuka dengan foto besar di atas</p></td><td><p>✓</p></td></tr><tr><td><p>6</p></td><td><p>Putuskan koneksi internet, lalu jalankan ulang aplikasi</p></td><td><p>Gambar placeholder tampil tanpa error merah</p></td><td><p>✓</p></td></tr></tbody></table><p>Keenam skenario memberikan hasil sesuai dengan yang diharapkan. Skenario 3 dan 4 menunjukkan bahwa status favorit tetap konsisten meskipun tampilan berganti antara grid dan list, sedangkan skenario 6 menunjukkan bahwa error state mampu menangani kondisi ketika foto tidak dapat diunduh.</p><h3>Checkpoint 3</h3><img src="/images/legacy/MobApp/Praktikum7/checkpoint3_grid_favorit.webp" alt="Checkpoint 3: Halaman Home Mode Grid dengan Resep Favorit"><p style="text-align: center"><em>Checkpoint 3: Halaman Home Mode Grid dengan Resep Favorit</em></p><p>Pada mode grid, resep ditampilkan sebagai kartu dua kolom dengan foto di bagian atas. Resep yang difavoritkan menampilkan ikon hati merah di pojok kanan atas foto, dan badge pada AppBar menunjukkan jumlah resep favorit. Ikon tombol tampilan di AppBar berubah menjadi ikon list.</p><img src="/images/legacy/MobApp/Praktikum7/checkpoint3_detail_foto.webp" alt="Checkpoint 3: Halaman Detail dengan Foto Besar"><p style="text-align: center"><em>Checkpoint 3: Halaman Detail dengan Foto Besar</em></p><p>Halaman detail menampilkan foto resep berukuran besar di bagian atas dengan sudut membulat, diikuti informasi resep, pengatur porsi, total kalori, dan daftar bahan.</p>$wp$, 1 from public.reports where slug = 'mobile-app-07-list-grid-images-assets';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Pertanyaan Analisis$wp$, $wp$<p><strong>1. Mengapa status favorit tetap sama saat tampilan berganti dari grid ke list?</strong> Status favorit tidak disimpan di dalam RecipeGridCard maupun RecipeTile, melainkan pada FavoriteProvider yang dipasang di atas MaterialApp. Kedua widget hanya membaca status tersebut melalui context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe) dan mengubahnya melalui toggle(). Ketika tombol ganti tampilan ditekan, setState pada HomePage membuang widget kartu grid dan membuat widget RecipeTile yang baru, tetapi data di FavoriteProvider tidak ikut berubah. Karena kedua widget membaca sumber data yang sama dan mencocokkan resep berdasarkan id, RecipeTile yang baru dibuat langsung menampilkan ikon hati yang sama dengan kartu grid sebelumnya.</p><p><strong>2. Apa yang tampil jika baris <code>if (loadingProgress == null) return child;</code> dihapus?</strong> Foto resep tidak akan pernah tampil, dan setiap gambar akan terus menampilkan kotak berwarna dengan ikon restaurant_menu. Hal ini terjadi karena loadingBuilder tidak hanya dipanggil selama foto diunduh, tetapi juga dipanggil sekali lagi setelah unduhan selesai dengan loadingProgress bernilai null. Apa pun yang dikembalikan loadingBuilder itulah yang ditampilkan di layar, sehingga tanpa baris tersebut child yang berisi foto asli tidak pernah dikembalikan, dan foto yang sebenarnya sudah selesai diunduh tetap tertutup oleh tampilan loading.</p><table><tbody><tr><th><p>Kondisi</p></th><th><p>Ukuran decode</p></th><th><p>Jumlah pixel</p></th><th><p>Memory per foto (4 byte/pixel)</p></th><th><p>Memory 50 resep</p></th></tr><tr><td><p>Tanpa cacheWidth</p></td><td><p>1200 × 800</p></td><td><p>960.000</p></td><td><p>± 3,84 MB</p></td><td><p>± 192 MB</p></td></tr><tr><td><p>Dengan cacheWidth: 168</p></td><td><p>168 × 112</p></td><td><p>18.816</p></td><td><p>± 75 KB</p></td><td><p>± 3,8 MB</p></td></tr></tbody></table><p><strong>3. Perhitungan pixel thumbnail dengan dan tanpa cacheWidth.</strong> Tanpa cacheWidth, foto di-decode dalam ukuran aslinya yaitu 1200 x 800 = 960.000 pixel. Dengan cacheWidth: 168, lebar foto di-decode menjadi 168 pixel dan tingginya menyesuaikan proporsi asli, yaitu 800 / 1200 x 168 = 112 pixel, sehingga jumlahnya hanya 168 x 112 = 18.816 pixel, sekitar 51 kali lebih sedikit. Karena setiap pixel memerlukan 4 byte (RGBA), satu foto tanpa cacheWidth menghabiskan sekitar 3,84 MB memory, sedangkan dengan cacheWidth hanya sekitar 75 KB. Ketika data bertambah menjadi 50 resep, thumbnail tanpa cacheWidth dapat membutuhkan sekitar 192 MB, jauh melebihi kebutuhan sebenarnya untuk gambar berukuran 56 dp. Akibatnya memory cepat penuh, gambar lebih sering dibuang lalu di-decode ulang dari cache, scroll menjadi tersendat, dan pada perangkat dengan memory kecil aplikasi berisiko ditutup paksa oleh sistem. Dengan cacheWidth, kebutuhan memory untuk 50 thumbnail hanya sekitar 3,8 MB.</p><p><strong>4. Mengapa logo memakai Image.asset dan foto resep memakai Image.network?</strong> Logo merupakan bagian dari identitas aplikasi yang selalu tampil sejak aplikasi dibuka, berukuran kecil, dan tidak pernah berubah. Jika diambil dari internet, logo akan bergantung pada koneksi, sempat kosong selama diunduh, dan dapat gagal tampil ketika pengguna sedang offline, padahal logo seharusnya tersedia kapan pun. Sebaliknya, foto resep jumlahnya banyak, berukuran besar, dan mengikuti data resep yang dapat bertambah atau berubah. Jika seluruh foto dimasukkan ke asset, ukuran file aplikasi akan membengkak, dan setiap penambahan resep baru mengharuskan aplikasi di-build dan diperbarui ulang, karena asset hanya dapat ditambahkan saat proses build. Dengan Image.network, foto cukup diunduh ketika dibutuhkan dan selalu mengikuti data terbaru dari server.</p>$wp$, 2 from public.reports where slug = 'mobile-app-07-list-grid-images-assets';
insert into public.report_sections (report_id, title, content, position) select id, $wp$4. Latihan$wp$, $wp$<h3>Latihan 1: Filter Cuisine</h3><h3>A. Filter Cuisine pada HomePage</h3><p><code>lib/pages/home_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:resepku/data/dummy_recipes.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/pages/settings_page.dart';
import 'package:resepku/widgets/favorite_badge_button.dart';
import 'package:resepku/widgets/recipe_grid_card.dart';
import 'package:resepku/widgets/recipe_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State&lt;HomePage&gt; createState() =&gt; _HomePageState();
}

class _HomePageState extends State&lt;HomePage&gt; {
  bool _isGrid = false;
  String? _cuisine;

  final List&lt;String&gt; _cuisines =
      dummyRecipes.map((r) =&gt; r.cuisine).toSet().toList();

  List&lt;Recipe&gt; get _filteredRecipes {
    if (_cuisine == null) return dummyRecipes;
    return dummyRecipes.where((r) =&gt; r.cuisine == _cuisine).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recipes = _filteredRecipes;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 32),
            const SizedBox(width: 8),
            const Text('ResepKu'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _isGrid ? 'Tampilan list' : 'Tampilan grid',
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () =&gt; setState(() =&gt; _isGrid = !_isGrid),
          ),
          const FavoriteBadgeButton(),
          IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings),
            onPressed: () =&gt; Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =&gt; const SettingsPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildChip('Semua', null),
                for (final cuisine in _cuisines) _buildChip(cuisine, cuisine),
              ],
            ),
          ),
          Expanded(
            child: _isGrid ? _buildGrid(recipes) : _buildList(recipes),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Center(
        child: ChoiceChip(
          label: Text(label),
          selected: _cuisine == value,
          onSelected: (_) =&gt; setState(() =&gt; _cuisine = value),
        ),
      ),
    );
  }

  Widget _buildList(List&lt;Recipe&gt; recipes) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeTile(recipe: recipes[index]);
      },
    );
  }

  Widget _buildGrid(List&lt;Recipe&gt; recipes) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3 / 4,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeGridCard(recipe: recipes[index]);
      },
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: HomePage dengan Filter Cuisine</em></p><p>Pada _HomePageState ditambahkan state _cuisine bertipe String? dengan nilai awal null yang berarti seluruh cuisine ditampilkan. Daftar cuisine tidak ditulis manual, melainkan diambil dari data dan disimpan pada variabel _cuisines. Setiap resep dipetakan ke cuisine-nya, lalu diubah menjadi Set agar tidak ada nilai ganda, kemudian dikembalikan menjadi List. Getter _filteredRecipes mengembalikan seluruh resep apabila _cuisine bernilai null, atau hanya resep dengan cuisine yang sama apabila sebuah cuisine dipilih.</p><p>Body HomePage diubah menjadi Column. Bagian atasnya berisi SizedBox setinggi 56 yang membungkus ListView horizontal berisi ChoiceChip, karena ListView horizontal di dalam Column harus diberi tinggi yang pasti. Chip pertama bertuliskan Semua dengan nilai null, diikuti satu chip untuk setiap cuisine. Setiap chip dibangun melalui method _buildChip, dibungkus Center agar tingginya tidak ikut diregangkan, dan memanggil setState untuk mengganti _cuisine ketika dipilih. Bagian bawah Column berupa Expanded yang berisi list atau grid, sehingga tampilan tersebut mengisi sisa tinggi layar. Data yang sudah difilter dikirim sebagai parameter ke _buildList dan _buildGrid, sehingga filter berlaku pada kedua mode tampilan. Tombol Pengaturan untuk mode gelap tetap dipertahankan pada AppBar.</p><img src="/images/legacy/MobApp/Praktikum7/latihan1_list_semua.webp" alt="Hasil Tampilan: Mode List dengan Filter Semua"><p style="text-align: center"><em>Hasil Tampilan: Mode List dengan Filter Semua</em></p><p>Deretan chip tampil di bawah AppBar dengan chip Semua terpilih, sehingga seluruh resep ditampilkan pada mode list. Deretan chip dapat digeser ke samping untuk melihat cuisine lainnya.</p><img src="/images/legacy/MobApp/Praktikum7/latihan1_list_filter.webp" alt="Hasil Tampilan: Mode List dengan Filter Italian"><p style="text-align: center"><em>Hasil Tampilan: Mode List dengan Filter Italian</em></p><p>Ketika chip Italian dipilih, daftar hanya menampilkan resep dengan cuisine Italian, yaitu Classic Margherita Pizza dan Chicken Alfredo Pasta.</p><img src="/images/legacy/MobApp/Praktikum7/latihan1_grid_filter.webp" alt="Hasil Tampilan: Mode Grid dengan Filter Italian"><p style="text-align: center"><em>Hasil Tampilan: Mode Grid dengan Filter Italian</em></p><p>Setelah berpindah ke mode grid, filter yang dipilih tetap berlaku sehingga kartu yang tampil hanya resep Italian. Hal ini menunjukkan bahwa state _cuisine dan _isGrid bekerja secara terpisah dan dapat dikombinasikan.</p><h3>Latihan 2: Halaman Favorit yang Lebih Rapi</h3><h3>A. ListView.separated, Thumbnail, dan Dismissible</h3><p><code>lib/pages/favorite_page.dart</code></p><pre><code class="language-dart">import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/providers/favorite_provider.dart';
import 'package:resepku/widgets/recipe_image.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  Future&lt;void&gt; _confirmClearAll(BuildContext context) async {
    final confirmed = await showDialog&lt;bool&gt;(
      context: context,
      builder: (dialogContext) =&gt; AlertDialog(
        title: const Text('Hapus semua favorit?'),
        content: const Text('Semua resep akan dihapus dari daftar favorit.'),
        actions: [
          TextButton(
            onPressed: () =&gt; Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () =&gt; Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true &amp;&amp; context.mounted) {
      context.read&lt;FavoriteProvider&gt;().clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = context.watch&lt;FavoriteProvider&gt;().count;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Saya'),
        actions: [
          IconButton(
            tooltip: 'Hapus semua',
            icon: const Icon(Icons.delete_sweep),
            onPressed: count == 0 ? null : () =&gt; _confirmClearAll(context),
          ),
        ],
      ),
      body: Consumer&lt;FavoriteProvider&gt;(
        builder: (context, favorite, child) {
          if (favorite.count == 0) {
            return const Center(
              child: Text(
                'Belum ada resep favorit.\nTekan ikon hati di daftar resep.',
                textAlign: TextAlign.center,
              ),
            );
          }

          final items = favorite.items;
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) =&gt; const Divider(height: 1),
            itemBuilder: (context, index) {
              final recipe = items[index];
              return Dismissible(
                key: ValueKey(recipe.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  favorite.toggle(recipe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${recipe.name} dihapus dari favorit')),
                  );
                },
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: RecipeImage(url: recipe.image, cacheWidth: 168),
                    ),
                  ),
                  title: Text(recipe.name),
                  subtitle: Text(recipe.cuisine),
                ),
              );
            },
          );
        },
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: FavoritePage dengan ListView.separated dan Dismissible</em></p><p>Daftar favorit kini dibangun menggunakan ListView.separated, dengan separatorBuilder yang menyisipkan Divider di antara setiap item. Setiap baris menampilkan thumbnail foto menggunakan RecipeImage berukuran 56 x 56 dengan cacheWidth 168, sama seperti thumbnail pada daftar resep di halaman Home, diikuti nama resep dan cuisine-nya.</p><p>Setiap ListTile dibungkus Dismissible dengan direction endToStart sehingga item hanya dapat digeser ke kiri. Saat digeser, terlihat latar berwarna merah dengan ikon hapus di sisi kanan. Dismissible diberi key berupa ValueKey(recipe.id), karena key tersebut unik untuk setiap resep dan tidak berubah meskipun urutan item bergeser setelah ada item yang dihapus. Penggunaan indeks sebagai key tidak tepat karena indeks item di bawahnya akan berubah ketika satu item dihapus. Ketika item selesai digeser, onDismissed memanggil toggle() untuk mengeluarkan resep dari daftar favorit, lalu menampilkan SnackBar berisi nama resep yang dihapus. Tombol Hapus semua dengan dialog konfirmasi tetap dipertahankan pada AppBar.</p><img src="/images/legacy/MobApp/Praktikum7/latihan2_favorit_list.webp" alt="Hasil Tampilan: Halaman Favorit dengan Thumbnail dan Divider"><p style="text-align: center"><em>Hasil Tampilan: Halaman Favorit dengan Thumbnail dan Divider</em></p><p>Halaman Favorit menampilkan setiap resep favorit lengkap dengan thumbnail foto di sebelah kiri, dengan garis pemisah di antara setiap item.</p><img src="/images/legacy/MobApp/Praktikum7/latihan2_geser.webp" alt="Hasil Tampilan: Item Favorit saat Digeser ke Kiri"><p style="text-align: center"><em>Hasil Tampilan: Item Favorit saat Digeser ke Kiri</em></p><p>Ketika sebuah item digeser ke kiri, latar berwarna merah dengan ikon hapus terlihat di bawah item tersebut sebagai penanda bahwa item akan dihapus dari daftar favorit.</p><img src="/images/legacy/MobApp/Praktikum7/latihan2_snackbar.webp" alt="Hasil Tampilan: SnackBar Setelah Item Favorit Dihapus"><p style="text-align: center"><em>Hasil Tampilan: SnackBar Setelah Item Favorit Dihapus</em></p><p>Setelah item selesai digeser, resep tersebut hilang dari daftar dan SnackBar muncul di bagian bawah layar berisi nama resep yang dihapus. Jumlah pada badge di halaman Home juga ikut berkurang.</p><h3>Latihan 3 (Bonus): Foto yang Mengecil saat Di-scroll</h3><h3>A. CustomScrollView dan SliverAppBar</h3><p><code>Terminal</code></p><pre><code class="language-bash">flutter pub add cached_network_image</code></pre><p style="text-align: center"><em>Kode Program: Menambahkan Package cached_network_image</em></p><p><code>lib/pages/detail_page.dart</code></p><pre><code class="language-dart">import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/providers/favorite_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State&lt;DetailPage&gt; createState() =&gt; _DetailPageState();
}

class _DetailPageState extends State&lt;DetailPage&gt; {
  late int _servings;

  @override
  void initState() {
    super.initState();
    _servings = widget.recipe.servings;
  }

  void _addServing() {
    setState(() =&gt; _servings++);
  }

  void _removeServing() {
    if (_servings &gt; 1) {
      setState(() =&gt; _servings--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final totalCalories = recipe.caloriesPerServing * _servings;
    final isFavorite = context.watch&lt;FavoriteProvider&gt;().isFavorite(recipe);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: colorScheme.primary,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () =&gt; context.read&lt;FavoriteProvider&gt;().toggle(recipe),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: recipe.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =&gt; ColoredBox(
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(child: Icon(Icons.restaurant_menu)),
                    ),
                    errorWidget: (context, url, error) =&gt; Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black38, Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${recipe.cuisine} • ${recipe.difficulty} • ${recipe.totalTimeMinutes} menit',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Text('Porsi', style: textTheme.titleMedium),
                          const Spacer(),
                          IconButton.filledTonal(
                            onPressed: _servings &gt; 1 ? _removeServing : null,
                            icon: const Icon(Icons.remove),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$_servings', style: textTheme.titleLarge),
                          ),
                          IconButton.filledTonal(
                            onPressed: _addServing,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Total kalori: $totalCalories kkal', style: textTheme.titleMedium),
                  const SizedBox(height: 24),
                  Text('Bahan', style: textTheme.titleLarge),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: recipe.ingredients.length,
            itemBuilder: (context, index) =&gt; ListTile(
              dense: true,
              leading: const Icon(Icons.check_circle_outline),
              title: Text(recipe.ingredients[index]),
            ),
          ),
        ],
      ),
    );
  }
}</code></pre><p style="text-align: center"><em>Kode Program: DetailPage dengan CustomScrollView dan SliverAppBar</em></p><p>Halaman detail diubah dari ListView menjadi CustomScrollView yang tersusun atas beberapa sliver. Sliver pertama adalah SliverAppBar dengan expandedHeight 260 dan pinned bernilai true, sehingga AppBar tampil tinggi saat halaman dibuka, mengecil ketika halaman di-scroll, dan tetap menempel di bagian atas layar. Foto resep ditempatkan sebagai background FlexibleSpaceBar dan diberi lapisan gradasi gelap di bagian atas dan bawah agar tombol kembali, ikon favorit, dan judul resep berwarna putih tetap terbaca di atas foto.</p><p>Foto pada SliverAppBar ditampilkan menggunakan CachedNetworkImage dari package cached_network_image, sehingga foto yang sudah pernah diunduh disimpan di penyimpanan perangkat dan tidak perlu diunduh ulang ketika aplikasi dibuka kembali. Parameter placeholder dan errorWidget berperan sama seperti loadingBuilder dan errorBuilder pada RecipeImage. Bagian pengatur porsi dan judul Bahan diletakkan di dalam SliverToBoxAdapter karena berupa widget biasa, sedangkan daftar bahan dibangun dengan SliverList.builder agar item dibuat secara lazy seperti ListView.builder. Pengelolaan porsi dengan setState dan status favorit dengan Provider tidak berubah.</p><img src="/images/legacy/MobApp/Praktikum7/latihan3_detail_besar.webp" alt="Hasil Tampilan: Halaman Detail dengan Foto Besar di SliverAppBar"><p style="text-align: center"><em>Hasil Tampilan: Halaman Detail dengan Foto Besar di SliverAppBar</em></p><p>Saat halaman detail dibuka, foto resep tampil besar di bagian atas dengan judul resep di bagian bawah foto, serta tombol kembali dan ikon favorit di bagian atas.</p><img src="/images/legacy/MobApp/Praktikum7/latihan3_detail_scroll.webp" alt="Hasil Tampilan: Halaman Detail Setelah Di-scroll"><p style="text-align: center"><em>Hasil Tampilan: Halaman Detail Setelah Di-scroll</em></p><p>Ketika halaman di-scroll ke bawah, foto mengecil secara bertahap hingga berubah menjadi AppBar biasa berwarna tema yang tetap menempel di atas layar, sementara daftar bahan terus bergulir di bawahnya.</p>$wp$, 3 from public.reports where slug = 'mobile-app-07-list-grid-images-assets';
insert into public.report_sections (report_id, title, content, position) select id, $wp$5. Kesimpulan$wp$, $wp$<p>Berdasarkan praktikum yang telah dilakukan, dapat disimpulkan bahwa pemilihan sumber gambar perlu disesuaikan dengan sifat gambarnya. Gambar yang kecil, tetap, dan harus selalu tersedia seperti logo dan placeholder lebih tepat disimpan sebagai asset yang didaftarkan di pubspec.yaml, sedangkan foto resep yang banyak dan mengikuti data lebih tepat diambil dari internet menggunakan Image.network. Gambar dari internet perlu dilengkapi loading state dan error state agar aplikasi tetap nyaman digunakan ketika koneksi lambat atau terputus, serta cacheWidth agar foto berukuran besar tidak memboroskan memory ketika hanya ditampilkan sebagai thumbnail. ListView.builder dan GridView.builder membuat item secara lazy sehingga efisien untuk data dalam jumlah besar, dan keduanya dapat dipilih dengan state lokal tanpa mengganggu status favorit yang disimpan di Provider. Penambahan filter cuisine dan halaman Favorit dengan Dismissible juga menunjukkan bahwa state lokal dan state global dapat digunakan bersama untuk membangun tampilan yang lebih interaktif.</p><h4>Teknologi yang digunakan:</h4><p>FlutterDartProvider</p>$wp$, 4 from public.reports where slug = 'mobile-app-07-list-grid-images-assets';
update public.reports set updated_at = now() where slug = 'mobile-app-07-list-grid-images-assets';

-- laporan.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'web-ui-simple-crud');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Penggunaan framework (kerangka kerja) menjadi solusi utama bagi para pengembang untuk membangun aplikasi yang terstruktur dan mudah dikelola. Laravel adalah framework PHP open-source yang dirancang untuk membuat pengembangan web menjadi lebih mudah dan lebih cepat. Secara default, framework ini menggunakan pola arsitektur MVC (Model-View-Controller) yang membantu memisahkan logika aplikasi dari tampilan dan pengelolaan data. Framework ini menawarkan berbagai alat dan pustaka yang membantu pengembang dalam menangani berbagai aspek pengembangan web, mulai dari routing, otentikasi, hingga manajemen basis data.</p><p>Tujuan Praktikum:  Mempelajari penggunaan framework Laravel dalam pengembangan aplikasi web Mengetahui cara konfigurasi laravel pada teks editor Memahami cara pembuatan model, controller, dan view</p>$wp$, 0 from public.reports where slug = 'web-ui-simple-crud';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja dan Implementasi$wp$, $wp$<p>Berikut adalah tahapan-tahapan pengerjaan beserta tangkapan layar (screenshot) dari hasil eksekusi kode:</p><h3>A. Requirements Laravel</h3><p>Sebelum memulai, pastikan bahwa sistem memenuhi persyaratan berikut untuk menjalankan Laravel:</p><img src="/images/legacy/ss11.webp" alt="Screenshot UI"><h3>B. Instalasi Laravel</h3><p>Proses instalasi Laravel dilakukan dengan menggunakan terminal PowerShell melalui perintah <em>composer create-project</em>. Dalam proses tersebut, Composer berhasil mengunduh paket utama laravel/laravel (v12.0.0) dan menyiapkan struktur direktori proyek. Setelah instalasi selesai, proyek Laravel dapat masuk ke direktori proyek laravelnya.</p><img src="/images/legacy/ss2.webp" alt="Screenshot Fitur Filter"><img src="/images/legacy/ss3.webp" alt="Screenshot Fitur"><p>Proses instalasi selesai dengan ditandai bahwasannya tahap migrasi database setelah aplikasi berhasil terpasang. Pada bagian ini, sistem menyiapkan tabel migrasi utama dan menjalankan serangkaian perintah migrasi bawaan Laravel secara berurutan, seperti pembuatan tabel users, cache, dan jobs, yang ditandai dengan status "DONE" untuk setiap prosesnya.</p><h3>C. Konfigurasi dan Pembuatan Proyek</h3><p>Setelah setelah berhasil membuat project Laravel, selanjutnya masuk kedalam directory project Laravel dan melakukan penginstalan npm untuk untuk menyiapkan aplikasi (Node.js/Frontend) agar siap digunakan/di-hosting dengan cara mengunduh semua bahan yang dibutuhkan terlebih dahulu, lalu merapikan dan mengoptimalkan kode secara otomatis dengan menjalankan perintah <em>npm install</em> dan <em>npm run dev</em>. Proses ini memastikan bahwa semua dependensi frontend yang diperlukan untuk menjalankan aplikasi Laravel telah terpasang dengan benar, serta mengompilasi aset-aset seperti CSS dan JavaScript agar siap digunakan.</p><img src="/images/legacy/ss4.webp" alt="Screenshot Kiri"><img src="/images/legacy/ss5.webp" alt="Screenshot Kanan"><p>Setelah proses instalasi npm selesai, langkah selanjutnya adalah menjalankan perintah <em>php artisan serve</em> untuk mengaktifkan server lokal yang berjalan pada alamat [http://127.0.0.1:8000] jika berhasil, maka akan muncul tampilan halaman utama Laravel yang menandakan bahwa server sudah aktif dan laravel siap digunakan.</p><img src="/images/legacy/ss6.webp" alt=""><h3>D. Testing</h3><img src="/images/legacy/ss12.webp" alt="Screenshot Kiri"><img src="/images/legacy/ss7.webp" alt="Screenshot Kanan"><p>Setelah server aktif, dan proyek sudah dibuat kita akan melakukan testing dengan menampilkan hello world pada browser. Konfigurasi routing dasar pada framework Laravel di dalam file <em>routes/web.php</em> dengan URL '/hello' yang secara langsung mengembalikan string teks "Hello World".</p><img src="/images/legacy/ss8.webp" alt="Screenshot Kiri"><img src="/images/legacy/ss9.webp" alt="Screenshot Kanan"><p>Penggunaan perintah artisan make:controller untuk membuat controller baru dengan nama <em>SiswaController</em> yang secara otomatis menghasilkan file controller di dalam direktori <em>app/Http/Controllers</em>. Setelah controller berhasil dibuat, membuat artisan make:model untuk membuat model baru dengan nama <em>SebuahModel</em> yang secara otomatis menghasilkan file model di dalam direktori <em>app/Models</em>. untuk konfigurasi dengan tabel di database.</p><h3>E. Challenge</h3><img src="/images/legacy/ss14.webp" alt="Screenshot Kiri"><p style="text-align: center"><em>Challenge 1</em></p><img src="/images/legacy/ss15.webp" alt="Screenshot Kanan"><p style="text-align: center"><em>Challenge 2</em></p><p>Challenge pertama adalah buat 1 buah controller dengan nama studentcontroller, kemudian buatkan 1 buah function didalam controller dan 1 view dengan nama index didalam folder student(student/index): buat route untuk mengakses function yang sudah dibuat di controller, lalu tampilkan <code> resources/view</code> dimana terdapat file baru dengan nama index.blade.php yang berisi informasi student tersebut. Routing /students akan menampilkan view tersebut. Pada file <code>web.php</code> tambahkan kode <code>Route::get('/students', [StudentController::class, 'index']);</code> setelah itu dapat dijalankan dengan akses URL http://127.0.0.1:8000/students</p><p>Challenge kedua adalah buat sebuah function baru didalam StudentController dengan nama lingkaran, yang berisi rumus mencari luas dan keliling lingkaran, berikan input jari jari lingkaran. Lalu buat routing/lingkaran yang menampilkan hasil luas dan keliling lingkaran. Tanpa menggunakan view!&gt;. Dimana dapat membuat function baru seperti pada gambar dibawah.</p><img src="/images/legacy/ss13.webp" alt="Screenshot">$wp$, 1 from public.reports where slug = 'web-ui-simple-crud';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Kesimpulan$wp$, $wp$<p>Praktikum ini memberikan pemahaman mendalam tentang penggunaan framework Laravel dalam pengembangan aplikasi web. Melalui tahapan instalasi, konfigurasi, dan testing, berhasil memahami bagaimana Laravel melakukan proses pengembangan dengan menyediakan berbagai alat dan fitur yang memudahkan pengelolaan proyek.</p><h4>Teknologi yang digunakan:</h4><p>HTMLLaravelJavaScript</p>$wp$, 2 from public.reports where slug = 'web-ui-simple-crud';
update public.reports set updated_at = now() where slug = 'web-ui-simple-crud';

-- laporan8.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'web-laravel-mvc');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum ini bertujuan untuk memberikan pemahaman dasar tentang cara membangun aplikasi web menggunakan framework PHP yaitu Laravel. Pada praktikum ini, fokus utamanya adalah menerapkan pola arsitektur MVC (Model-View-Controller). Mahasiswa akan mempelajari cara mengatur database melalui kode program, membuat rute untuk alamat web, hingga menghubungkan proses pengolahan data dengan tampilan halaman. Dengan memahami materi ini, mahasiswa diharapkan bisa membuat fitur manipulasi data (CRUD) dengan lebih rapi, terstruktur, dan mudah dikelola.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Mengetahui cara mengatur tabel database menggunakan Migration dan mengisi data awal menggunakan Seeding.</p></li><li><p>Memahami cara membuat rute aplikasi (Routing) dan Model untuk berinteraksi dengan database.</p></li><li><p>Mampu membuat Controller sebagai penghubung antara data dan tampilan.</p></li><li><p>Mampu menampilkan data ke halaman web menggunakan sistem Blade Template milik Laravel.</p></li></ul>$wp$, 0 from public.reports where slug = 'web-laravel-mvc';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja dan Implementasi$wp$, $wp$<p>Berikut adalah langkah-langkah praktikum yang telah dilakukan beserta penjelasan dari gambar kode dan eksekusi programnya:</p><h3>A. Konfigurasi Database</h3><p>Langkah pertama dalam membuat proyek Laravel adalah mengatur koneksi ke database. Pengaturan ini dilakukan dengan mengubah beberapa baris pada file konfigurasi bernama `.env`. Pada file tersebut, jenis koneksi dipastikan menggunakan `mysql`, dan nama database diubah menjadi `praktikum_laravel`. Konfigurasi ini sangat penting agar aplikasi Laravel bisa terhubung dan menyimpan data ke dalam database lokal kita.</p><img src="/images/legacy/gb1.webp" alt="Screenshot Konfigurasi Database"><p style="text-align: center"><em>Gambar 2.1: Konfigurasi file .env untuk database</em></p><h3>B. Pembuatan Migration</h3><p>Migration digunakan untuk membuat struktur tabel database langsung melalui kode PHP, sehingga kita tidak perlu membuatnya secara manual. Pada praktikum ini, kita membuat file migration untuk tabel `products`. Di dalam kodenya, ditambahkan beberapa kolom yang dibutuhkan, yaitu kolom `name` dengan tipe string untuk nama produk, `price` dengan tipe integer untuk harga, dan `description` dengan tipe teks untuk deskripsi produk. Perintah `timestamps()` juga otomatis ditambahkan untuk mencatat kapan data dibuat dan diperbarui.</p><img src="/images/legacy/gb3.webp" alt="Screenshot Migration"><p style="text-align: center"><em>Gambar 2.2: Kode pembuatan kolom pada file Migration</em></p><h3>C. Membuat Data Awal (Seeding)</h3><p>Setelah tabel selesai dibuat, kita membutuhkan data contoh (dummy) untuk menguji aplikasi. Hal ini dilakukan menggunakan fitur Seeding. Pertama, kita membuat file seeder dengan mengetikkan perintah `php artisan make:seeder` di terminal. Setelah file seeder berhasil dibuat, kita menuliskan kode menggunakan `DB::table()-&gt;insert()` untuk memasukkan beberapa data produk secara langsung beserta atributnya seperti nama barang dan harga.</p><img src="/images/legacy/gb5.webp" alt="Screenshot Perintah Seeder"><p style="text-align: center"><em>Gambar 2.3: Perintah membuat file Seeder di terminal</em></p><img src="/images/legacy/gb6.webp" alt="Screenshot Kode Seeder"><p style="text-align: center"><em>Gambar 2.4: Kode untuk menambahkan data produk pada Seeder</em></p><p>Untuk menjalankan file seeder dan memasukkan data tersebut ke dalam database, kita menggunakan perintah `php artisan db:seed`. Selain itu, Laravel juga menyediakan perintah yang sangat praktis yaitu `php artisan migrate:fresh --seed`. Perintah ini berfungsi ganda, yaitu menghapus semua tabel lama, membuat tabel ulang dari awal berdasarkan migration, lalu langsung mengisinya dengan data dari seeder.</p><img src="/images/legacy/gb7.webp" alt="Screenshot Jalankan Seeder"><p style="text-align: center"><em>Gambar 2.5: Eksekusi perintah db:seed berjalan sukses</em></p><img src="/images/legacy/gb8.webp" alt="Screenshot Refresh Seeder"><p style="text-align: center"><em>Gambar 2.6: Proses reset database sekaligus mengisi data seeder</em></p><h3>D. Pengaturan Alamat Web (Routing)</h3><p>Routing berfungsi untuk mengatur setiap alamat link (URL) yang diketik oleh pengguna agar diarahkan ke halaman yang benar. Semua konfigurasi rute ini diletakkan pada file `routes/web.php`. Pada kode di bawah, kita membuat beberapa tipe rute. Mulai dari rute biasa yang mengembalikan teks langsung, rute dengan parameter ID untuk menampilkan data spesifik, hingga rute jenis *resource* yang secara otomatis akan membuat semua jalur URL yang diperlukan untuk fitur pengolahan data (CRUD).</p><img src="/images/legacy/gb9.webp" alt="Screenshot Routing"><p style="text-align: center"><em>Gambar 2.7: Konfigurasi bermacam tipe rute di web.php</em></p><p>Selain rute biasa, kita juga menggunakan fitur *Route Group* dengan tambahan penamaan *prefix*. Fitur ini digunakan untuk mengelompokkan URL. Pada contoh ini, kita mengelompokkan rute untuk bagian admin. Dengan begitu, setiap rute yang berada di dalam grup ini otomatis akan memiliki awalan '/admin' pada alamat webnya (misalnya `/admin/dashboard`). Hal ini membuat penulisan kode rute menjadi lebih rapi dan terorganisir.</p><img src="/images/legacy/gb11.webp" alt="Screenshot Route Group"><p style="text-align: center"><em>Gambar 2.8: Pengelompokan rute menggunakan prefix</em></p><h3>E. Konfigurasi Model</h3><p>Model adalah bagian yang bertugas secara langsung untuk mengambil dan memproses data dari tabel database. Pada file `Product.php`, kita perlu menambahkan variabel `protected $fillable`. Fungsi dari kode ini adalah sebagai sistem keamanan untuk menentukan kolom tabel apa saja yang diizinkan untuk menerima inputan atau diisi secara massal oleh pengguna, seperti nama produk, harga, dan deskripsinya.</p><img src="/images/legacy/gb10.webp" alt="Screenshot Model"><p style="text-align: center"><em>Gambar 2.9: Pengaturan izin kolom pada file Model</em></p><h3>F. Pembuatan Controller dan Tampilan (View)</h3><p>Controller berperan sebagai otak atau pengatur alur dari sebuah halaman. Controller dibuat dengan menggunakan perintah `php artisan make:controller` di terminal. Setelah dibuat, controller inilah yang akan menerima permintaan dari rute, memanggil data dari Model, dan mengirim data tersebut ke halaman depan. Halaman depan ini disebut View, yang dibuat menggunakan file dengan akhiran `.blade.php`. Fitur Blade memudahkan kita untuk menampilkan data dari controller secara dinamis ke dalam kode HTML dasar.</p><img src="/images/legacy/gb12.webp" alt="Screenshot Controller Command"><p style="text-align: center"><em>Gambar 2.10: Perintah pembuatan file Controller</em></p><img src="/images/legacy/gb15.webp" alt="Screenshot View"><p style="text-align: center"><em>Gambar 2.11: Hasil tampilan halaman web menggunakan View</em></p>$wp$, 1 from public.reports where slug = 'web-laravel-mvc';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Kesimpulan$wp$, $wp$<p>Melalui praktikum ini, dapat disimpulkan bahwa penggunaan pola MVC (Model-View-Controller) pada Laravel sangat mempermudah proses pembuatan website. Fitur Migration dan Seeding membuat manajemen database menjadi lebih praktis tanpa harus membuka database manager secara manual. Pemisahan fungsi antara pengelolaan rute (Routing), pengolahan data (Model), logika program (Controller), dan tampilan layar (View) membuat penulisan program menjadi lebih bersih, mudah dipahami, dan memudahkan ketika ada penambahan fitur nantinya.</p><h4>Teknologi yang digunakan:</h4><p>HTMLLaravelMySQL</p>$wp$, 2 from public.reports where slug = 'web-laravel-mvc';
update public.reports set updated_at = now() where slug = 'web-laravel-mvc';

-- laporan8-2.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'web-laravel-crud-relationships');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum ini berfokus pada pembuatan sistem akademik sederhana untuk memahami secara mendalam tentang konsep relasi antar tabel pada database menggunakan framework Laravel. Dalam membangun aplikasi yang nyata, data yang kita miliki jarang sekali berdiri sendiri pada satu tabel saja. Oleh karena itu, kita membangun hubungan antara tabel mahasiswa, tabel jurusan, dan tabel mata kuliah. Melalui pemahaman materi relasi ini, kita dapat menghubungkan berbagai data yang terpisah tersebut menjadi satu kesatuan informasi yang utuh dan sangat mudah dikelola melalui fitur yang sudah disediakan oleh Laravel.</p><h3>Tujuan Praktikum:</h3><ul><li><p>Memahami konsep dasar relationship atau relasi tabel di dalam Laravel.</p></li><li><p>Mengimplementasikan relasi jenis One to Many dan Many to Many.</p></li><li><p>Membuat file migration yang dilengkapi dengan kunci tamu (foreign key).</p></li><li><p>Menggunakan fitur Eloquent dari Laravel untuk melakukan query pemanggilan data.</p></li><li><p>Menampilkan data gabungan hasil relasi ke halaman antarmuka website.</p></li></ul>$wp$, 0 from public.reports where slug = 'web-laravel-crud-relationships';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Tahapan Kerja dan Implementasi$wp$, $wp$<p>Berikut adalah penjabaran lengkap dari setiap tahapan praktikum yang telah dilakukan beserta penjelasan detail mengenai fungsi dari perintah dan kode programnya:</p><h3>A. Migrasi Tabel Jurusan</h3><p>Tahapan paling awal dalam membuat database yang saling berelasi adalah membuat tabel induk yang posisinya tidak bergantung pada tabel lain. Tabel jurusan ini bertindak sebagai tabel induk pertama. Kita memulai dengan menjalankan perintah artisan make migration di dalam terminal untuk menciptakan file struktur tabel jurusan. Setelah file tersebut tercipta, kita membuka kodenya dan menambahkan kolom nama jurusan yang menggunakan tipe data string. Tabel ini sengaja dibuat pertama kali karena nantinya data dari tabel jurusan ini akan ditarik dan dirujuk oleh tabel mahasiswa.</p><img src="/images/legacy/g1.webp" alt="Screenshot Perintah Migration Majors"><p style="text-align: center"><em>Gambar 2.1: Perintah membuat file migrasi jurusan di terminal</em></p><img src="/images/legacy/g2.webp" alt="Screenshot Kode Migration Majors"><p style="text-align: center"><em>Gambar 2.2: Kode migrasi untuk merancang struktur tabel jurusan</em></p><h3>B. Migrasi Tabel Mahasiswa</h3><p>Setelah tabel induk selesai dibuat, kita melanjutkannya dengan membuat file migrasi untuk tabel mahasiswa. Tabel mahasiswa ini memiliki hubungan relasi dengan tabel jurusan dengan jenis relasi banyak ke satu. Artinya banyak mahasiswa bisa tergabung ke dalam satu jurusan yang sama. Oleh karena itu pada kode migrasinya, selain kita menambahkan kolom identitas diri seperti nama dan Nomor Induk Mahasiswa, kita juga wajib menambahkan sebuah kolom foreign key bernama major id. Kolom inilah yang akan bertugas menyimpan nomor urut jurusan dan menghubungkan identitas mahasiswa tersebut secara langsung dengan tabel jurusan yang sudah kita buat sebelumnya.</p><img src="/images/legacy/g3.webp" alt="Screenshot Perintah Migration Students"><p style="text-align: center"><em>Gambar 2.3: Perintah pembuatan file migrasi mahasiswa di terminal</em></p><img src="/images/legacy/g4.webp" alt="Screenshot Kode Migration Students"><p style="text-align: center"><em>Gambar 2.4: Kode migrasi penambahan foreign key menuju tabel jurusan</em></p><h3>C. Migrasi Tabel Mata Kuliah</h3><p>Tahapan ketiga adalah mempersiapkan wadah untuk menampung seluruh daftar mata kuliah. Serupa dengan langkah awal tadi, file migrasi baru dibuat melalui pengetikan perintah di terminal. Pada bagian pengisian kode migrasinya, kita cukup mendefinisikan kolom untuk menampung nama mata kuliah serta sebuah kolom tambahan bertipe data angka bulat untuk menyimpan jumlah Satuan Kredit Semester. Tabel mata kuliah ini dirancang untuk berdiri sendiri terlebih dahulu sebelum nantinya dihubungkan dengan para mahasiswa yang memilih kelas tersebut pada tahap berikutnya.</p><img src="/images/legacy/g5.webp" alt="Screenshot Perintah Migration Subjects"><p style="text-align: center"><em>Gambar 2.5: Perintah pembuatan file migrasi mata kuliah</em></p><img src="/images/legacy/g6.webp" alt="Screenshot Kode Migration Subjects"><p style="text-align: center"><em>Gambar 2.6: Kode migrasi penambahan kolom nama dan satuan kredit semester</em></p><h3>D. Migrasi Tabel Perantara</h3><p>Karena satu mahasiswa bisa mengambil banyak pilihan mata kuliah dan satu mata kuliah juga bisa diambil oleh banyak peserta mahasiswa, maka kita dihadapkan pada jenis relasi banyak ke banyak. Sistem database mewajibkan kita untuk membuat sebuah tabel perantara khusus guna menjembatani relasi yang rumit ini. Tabel perantara ini diberi nama gabungan yaitu tabel student subject. Di dalam susunan kodenya kita hanya perlu memasukkan dua kolom rujukan utama yaitu kolom yang memuat ID dari tabel mahasiswa dan kolom yang memuat ID dari tabel mata kuliah. Kita juga menambahkan satu baris aturan kode unik pada kedua kolom tersebut untuk menolak masuknya data kembar jika ada seorang mahasiswa yang mendaftarkan kelas yang persis sama dua kali.</p><img src="/images/legacy/g7.webp" alt="Screenshot Perintah Migration Pivot"><p style="text-align: center"><em>Gambar 2.7: Perintah pembuatan file migrasi tabel perantara</em></p><img src="/images/legacy/g10.webp" alt="Screenshot Kode Migration Pivot"><p style="text-align: center"><em>Gambar 2.8: Kode tabel perantara dengan tambahan sistem pencegahan data ganda</em></p><h3>E. Pembuatan Model dan Definisi Relasi</h3><p>Setelah struktur tabel di dalam database rampung dikerjakan, langkah selanjutnya adalah menciptakan file Model untuk tiap tabel tersebut. Model ini bertugas memberitahu bahasa pemrograman PHP mengenai hubungan apa saja yang terjalin antar tabel. Pada model jurusan, kita menyisipkan fungsi yang memberitahu bahwa jurusan ini memiliki banyak mahasiswa melalui tipe relasi hasMany. Selanjutnya pada model mahasiswa, kita membuat fungsi kebalikan yang menandakan bahwa ia merupakan bagian dari sebuah jurusan menggunakan relasi belongsTo. Selain itu pada model mahasiswa juga ditambahkan fungsi relasi belongsToMany yang mengarah kepada model mata kuliah. Seluruh file model ini turut diamankan dengan mendaftarkan nama kolom yang diizinkan untuk menerima inputan data dari pengguna.</p><img src="/images/legacy/g9.webp" alt="Perintah Model Major"><p style="text-align: center"><em>Gambar 2.9: Perintah pembuatan model jurusan</em></p><img src="/images/legacy/g11.webp" alt="Kode Model Major"><p style="text-align: center"><em>Gambar 2.10: Penulisan fungsi relasi yang mengarah ke tabel anak</em></p><img src="/images/legacy/g12.webp" alt="Perintah Model Student"><p style="text-align: center"><em>Gambar 2.11: Perintah pembuatan model mahasiswa</em></p><img src="/images/legacy/g13.webp" alt="Kode Model Student"><p style="text-align: center"><em>Gambar 2.12: Penulisan kombinasi dua buah relasi pada model mahasiswa</em></p><img src="/images/legacy/g14.webp" alt="Perintah Model Subject"><p style="text-align: center"><em>Gambar 2.13: Perintah pembuatan model mata kuliah</em></p><img src="/images/legacy/g15.webp" alt="Kode Model Subject"><p style="text-align: center"><em>Gambar 2.14: Penulisan relasi banyak ke banyak pada model mata kuliah</em></p><h3>F. Persiapan Data Awal Menggunakan Seeder</h3><p>Supaya aplikasi bisa langsung diuji coba dengan data yang menyerupai kondisi asli, kita memanfaatkan fitur pengisi data otomatis bernama Seeder. Pada file pengisi data jurusan dan mata kuliah, kita menuliskan daftar program studi beserta beban SKS ke dalam format himpunan array. Data tersebut lalu dimasukkan secara otomatis menggunakan fungsi perulangan. Bagian paling menarik berada pada file pengisi data mahasiswa, karena selain menyimpan profil lengkap mahasiswa, skrip ini turut ditugaskan untuk memilih rentetan mata kuliah secara acak. Pilihan mata kuliah acak tersebut langsung diikatkan kepada identitas mahasiswa dengan memanggil fungsi tempel bernama attach. Terakhir semua susunan kelas pengisi data ini disatukan ke dalam satu file pemanggil utama agar siap dieksekusi secara serentak pada terminal.</p><img src="/images/legacy/g16.webp" alt="Perintah Major Seeder"><p style="text-align: center"><em>Gambar 2.15: Perintah pembuatan seeder jurusan</em></p><img src="/images/legacy/g17.webp" alt="Kode Major Seeder"><p style="text-align: center"><em>Gambar 2.16: Skrip penyimpanan data barisan jurusan melalui perulangan</em></p><img src="/images/legacy/g18.webp" alt="Perintah Subject Seeder"><p style="text-align: center"><em>Gambar 2.17: Perintah pembuatan seeder mata kuliah</em></p><img src="/images/legacy/g19.webp" alt="Kode Subject Seeder"><p style="text-align: center"><em>Gambar 2.18: Skrip pendataan nama mata kuliah beserta nominal SKS</em></p><img src="/images/legacy/g20.webp" alt="Perintah Student Seeder"><p style="text-align: center"><em>Gambar 2.19: Perintah pembuatan seeder mahasiswa</em></p><img src="/images/legacy/g21.webp" alt="Kode Student Seeder"><p style="text-align: center"><em>Gambar 2.20: Skrip pemilihan kombinasi mata kuliah secara acak bagi mahasiswa</em></p><img src="/images/legacy/g22.webp" alt="Kode Database Seeder"><p style="text-align: center"><em>Gambar 2.21: Kompilasi pendaftaran pemanggilan seeder pada file utama</em></p><img src="/images/legacy/g23.webp" alt="Eksekusi DB Seed"><p style="text-align: center"><em>Gambar 2.22: Hasil laporan dari eksekusi serentak seluruh skrip pengisian data</em></p><h3>G. Perancangan Logika pada Controller</h3><p>Langkah esensial sesudah pendataan selesai adalah mengatur lalu lintas data menggunakan file Controller. Saat memanggil data mahasiswa untuk ditampilkan ke layar, kita menggunakan teknik cerdas bernama Eager Loading. Teknik ini difungsikan agar data jurusan beserta kumpulan data mata kuliah ditarik dalam satu kali kerja saja sehingga database tidak merasa terbebani. Pada fungsi untuk menyimpan data peserta baru, pengontrol akan menampung seluruh isian dari form, mengecek kebenarannya, menyimpan ke tabel mahasiswa, lalu mengaitkan deretan mata kuliah yang dicentang ke dalam tabel perantara menggunakan fungsi attach. Sedangkan pada saat pengguna ingin mengedit profil mahasiswa, pengontrol menggunakan fungsi pintar bernama sync yang akan otomatis menghapus catatan mata kuliah lama dan menggantinya dengan susunan mata kuliah yang baru saja dipilih.</p><img src="/images/legacy/g24.webp" alt="Perintah Controller"><p style="text-align: center"><em>Gambar 2.23: Pembuatan file pengontrol utama untuk halaman mahasiswa</em></p><img src="/images/legacy/g25.webp" alt="Kode Controller Atas"><p style="text-align: center"><em>Gambar 2.24: Penulisan fungsi pemuatan data gabungan dan fungsi penambahan peserta</em></p><img src="/images/legacy/g26.webp" alt="Kode Controller Bawah"><p style="text-align: center"><em>Gambar 2.25: Penulisan fungsi pembaruan rekaman serta penghapusan data relasi</em></p><h3>H. Pendaftaran Rute dan Perancangan Tampilan Web</h3><p>Untuk menjamin seluruh fungsi di dalam pengontrol tadi dapat diakses dari browser, kita diwajibkan mendaftarkan rutenya. Penggunaan format rute resource sangat menghemat waktu karena semua kombinasi alamat URL untuk kebutuhan manipulasi data akan disediakan secara otomatis. Selanjutnya untuk mendesain wajah aplikasi, kita merakit satu file tampilan induk bernama app blade php yang sudah disuntikkan dengan komponen desain Bootstrap. Halaman penyaji tabel dirancang secara teliti dengan menambahkan perulangan bersarang di dalam struktur kolom tabelnya agar daftar panjang mata kuliah bisa disulap menjadi deretan label warna yang sedap dipandang. Halaman untuk mendaftar mahasiswa baru juga dirancang menjadi sebuah form yang dinamis dimana kotak isian jurusan disajikan dalam bentuk pilihan menu tarik turun sementara daftar mata kuliah disajikan melalui form centang yang lebih bersahabat dengan pengguna.</p><img src="/images/legacy/g27.webp" alt="Kode Routing"><p style="text-align: center"><em>Gambar 2.26: Konfigurasi jalur rute serba guna untuk operasi database</em></p><img src="/images/legacy/g28.webp" alt="Kode View Layout"><p style="text-align: center"><em>Gambar 2.27: Kode penyusunan kerangka desain induk antarmuka halaman</em></p><img src="/images/legacy/g29.webp" alt="Kode View Index"><p style="text-align: center"><em>Gambar 2.28: Kode penyusunan tabel penampil data keseluruhan secara perulangan</em></p><img src="/images/legacy/g30.webp" alt="Kode View Create"><p style="text-align: center"><em>Gambar 2.29: Kode perancangan kotak isian formulir penambahan peserta baru</em></p><h3>I. Pengujian Antarmuka Aplikasi</h3><p>Tahap pembuktian akhir dilakukan dengan membuka aplikasi tersebut melalui browser. Layar akan langsung menampilkan sebuah tabel lebar yang sangat rapi memuat kolom nama jurusan dari tabel sebelah serta menampilkan setiap mata kuliah ke dalam bentuk label berwarna abu-abu beserta penjumlahan angka total SKS nya. Apabila tombol tambah disentuh, pengguna akan diarahkan menuju halaman pendaftaran yang sangat rapi. Apabila seluruh proses pendaftaran berhasil disimpan tanpa kendala, sistem dengan sendirinya memulangkan pengguna menuju daftar tabel dan menyematkan satu kotak notifikasi keberhasilan yang menyejukkan mata. Pengujian mendalam pada fitur membaca riwayat utuh seorang mahasiswa maupun upaya untuk merombak susunan data lamanya turut membuktikan bahwa seluruh intruksi yang dititipkan pada bagian pengontrol berhasil tereksekusi dengan ketelitian yang tinggi.</p><img src="/images/legacy/g31.webp" alt="UI Index Mahasiswa"><p style="text-align: center"><em>Gambar 2.30: Antarmuka utama halaman tabel rekapitulasi daftar mahasiswa</em></p><img src="/images/legacy/g32.webp" alt="UI Tambah Mahasiswa"><p style="text-align: center"><em>Gambar 2.31: Tampilan halaman form isian khusus penambahan mahasiswa baru</em></p><img src="/images/legacy/g33.webp" alt="UI Notifikasi Sukses"><p style="text-align: center"><em>Gambar 2.32: Tampilan kotak pemberitahuan bahwasanya penyimpanan berjalan sukses</em></p><img src="/images/legacy/g34.webp" alt="UI Detail Mahasiswa"><p style="text-align: center"><em>Gambar 2.33: Tampilan halaman saat melihat rincian detail profil setiap mahasiswa</em></p><img src="/images/legacy/g35.webp" alt="UI Edit Mahasiswa"><p style="text-align: center"><em>Gambar 2.34: Tampilan formulir untuk memperbarui atau mengoreksi data lama</em></p><h3>J. Latihan Penerapan Kueri Pemanggilan Data</h3><p>Pada tahapan kueri pertama, penarikan data berhasil mengambil seluruh nama peserta lengkap membawa atribut jurusan beserta mata kuliahnya tanpa ada bagian yang cacat. Pada pengujian kueri kedua, fokus diarahkan pada perhitungan matematis untuk memunculkan nama jurusan yang paling banyak digemari atau paling padat penduduknya. Latihan ketiga menyajikan praktik filterasi pencarian yang hanya akan memuntahkan daftar mata kuliah milik satu sampel nama mahasiswa yang diincar. Pada latihan pamungkas, implementasi kueri dirancang secara brilian untuk mengakumulasi setiap digit angka Satuan Kredit Semester secara akurat untuk tiap individu mahasiswa.</p><img src="/images/legacy/l1.webp" alt="Latihan Query 1"><p style="text-align: center"><em>Gambar 2.35: Hasil tangkapan kueri pertama menampilkan relasi keseluruhan anggota</em></p><img src="/images/legacy/l2.webp" alt="Latihan Query 2"><p style="text-align: center"><em>Gambar 2.36: Hasil tangkapan kueri kedua memilah populasi jurusan terbanyak</em></p><img src="/images/legacy/l3.webp" alt="Latihan Query 3"><p style="text-align: center"><em>Gambar 2.37: Hasil tangkapan kueri ketiga membidik informasi riwayat studi secara personal</em></p><img src="/images/legacy/l4.webp" alt="Latihan Query 4"><p style="text-align: center"><em>Gambar 2.38: Hasil tangkapan kueri keempat memuat kalkulasi bersih nilai Satuan Kredit Semester</em></p>$wp$, 1 from public.reports where slug = 'web-laravel-crud-relationships';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Kesimpulan$wp$, $wp$<p>Berdasarkan hasil praktikum yang telah dilakukan, dapat disimpulkan bahwa penggunaan model pada framework Laravel mempermudah pengelolaan relasi antar tabel dalam database. Pembuatan struktur database melalui migration, pengisian data awal menggunakan seeder, serta pengambilan data melalui model dapat dilakukan dengan lebih efisien dibandingkan menggunakan query database secara langsung. Selain itu, kode program menjadi lebih terstruktur, mudah dipelihara, dan lebih mudah dikembangkan untuk penambahan fitur di masa mendatang.</p><h4>Teknologi yang digunakan:</h4><p>HTMLLaravelMySQL</p>$wp$, 2 from public.reports where slug = 'web-laravel-crud-relationships';
update public.reports set updated_at = now() where slug = 'web-laravel-crud-relationships';

-- laporan9.html
delete from public.report_sections where report_id = (select id from public.reports where slug = 'web-laravel-sisfo');
insert into public.report_sections (report_id, title, content, position) select id, $wp$1. Pendahuluan$wp$, $wp$<p>Praktikum ini merupakan kelanjutan dari modul sebelumnya yang membahas pembuatan proyek Laravel dasar. Pada sesi ini, fokus utama adalah membangun sistem autentikasi pengguna (user authentication) secara lengkap menggunakan paket resmi Laravel yaitu <code>laravel/ui</code> dengan framework Bootstrap, kemudian melakukan kustomisasi tampilan menggunakan template SB Admin 2, serta mengimplementasikan fitur manajemen data pengguna secara penuh mulai dari menampilkan daftar, membuat, memperbarui, hingga menghapus data (CRUD). Studi kasus yang digunakan adalah Sistem Informasi Sekolah (Sisfo).</p><h3>Tujuan Praktikum:</h3><ul><li><p>Memahami cara menginstal dan mengkonfigurasi paket <code>laravel/ui</code> untuk membuat sistem autentikasi berbasis Bootstrap secara otomatis.</p></li><li><p>Mampu melakukan kustomisasi tabel <code>users</code> melalui migration untuk menambahkan field baru sesuai kebutuhan aplikasi.</p></li><li><p>Memahami cara mengisi data awal ke database menggunakan fitur Seeding pada Laravel.</p></li><li><p>Mampu membangun tampilan aplikasi yang konsisten menggunakan konsep Templating (Layouts) dengan Blade, memanfaatkan template SB Admin 2.</p></li><li><p>Mampu mengimplementasikan fitur CRUD pengguna menggunakan Resource Controller.</p></li></ul>$wp$, 0 from public.reports where slug = 'web-laravel-sisfo';
insert into public.report_sections (report_id, title, content, position) select id, $wp$2. Langkah Kerja dan Implementasi$wp$, $wp$<h3>A. Membuat Project dan Konfigurasi Database</h3><p>Langkah pertama adalah membuat project Laravel baru. Terdapat dua cara yang bisa digunakan, yaitu menggunakan Laravel Global Installer atau menggunakan Composer. Pada praktikum ini digunakan Composer. Setelah project berhasil dibuat, langkah berikutnya adalah membuka file <code>.env</code> dan mengisi konfigurasi database agar Laravel dapat terhubung ke database MySQL lokal. Database yang digunakan pada studi kasus ini diberi nama <code>laravel_sisfo</code>.</p><p><code>.env</code></p><pre><code class="language-ini">DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=laravel_sisfo
DB_USERNAME=root
DB_PASSWORD=</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan konfigurasi file .env pada editor</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.1: Konfigurasi file .env untuk koneksi database</em></p><h3>B. Instalasi Package Laravel/UI dan Scaffolding Autentikasi</h3><p>Untuk membuat fitur autentikasi secara otomatis, Laravel menyediakan paket bernama <code>laravel/ui</code>. Paket ini perlu diinstal terlebih dahulu menggunakan Composer. Setelah paket berhasil diinstal, perintah <code>php artisan ui bootstrap --auth</code> dijalankan untuk membuat scaffolding autentikasi lengkap berbasis Bootstrap. Perintah ini secara otomatis akan menghasilkan halaman login, register, forgot password, beserta controller dan route yang diperlukan. Langkah terakhir adalah menjalankan <code>npm install &amp;&amp; npm run dev</code> untuk mengompilasi file aset (CSS dan JavaScript) yang dibutuhkan.</p><p><code>Terminal</code></p><pre><code class="language-bash"># Langkah 1: Install package laravel/ui
composer require laravel/ui

# Langkah 2: Generate scaffolding autentikasi dengan Bootstrap
php artisan ui bootstrap --auth

# Langkah 3: Install dan compile asset (CSS &amp; JS)
npm install &amp;&amp; npm run dev</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Hasil instalasi composer require laravel/ui</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.2: Proses instalasi laravel/ui berhasil</em></p><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Output perintah php artisan ui bootstrap --auth</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.3: Scaffolding autentikasi berhasil digenerate</em></p><h3>C. Menjalankan Migration</h3><p>Setelah scaffolding autentikasi berhasil, langkah berikutnya adalah menjalankan perintah <code>php artisan migrate</code> agar Laravel membuat tabel-tabel yang dibutuhkan di database secara otomatis. Tabel yang akan dibuat antara lain adalah tabel <code>users</code>, <code>password_resets</code>, <code>failed_jobs</code>, dan <code>personal_access_tokens</code>. Jika database belum tersedia, Laravel akan meminta konfirmasi untuk membuatkannya terlebih dahulu.</p><p><code>Terminal</code></p><pre><code class="language-bash">php artisan migrate</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Hasil perintah php artisan migrate</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.4: Proses migration berhasil, tabel berhasil dibuat di database</em></p><h3>D. Kustomisasi Tabel Users (Custom Migration)</h3><p>Tabel <code>users</code> yang dihasilkan secara default oleh Laravel hanya memiliki kolom dasar seperti <code>name</code>, <code>email</code>, dan <code>password</code>. Pada studi kasus Sisfo, dibutuhkan tiga kolom tambahan yaitu <code>username</code> (unik), <code>level</code> (untuk peran pengguna), dan <code>status</code> (dengan pilihan ACTIVE atau INACTIVE). Untuk menambahkan kolom-kolom ini, dibuat sebuah migration baru menggunakan perintah artisan, kemudian file migration yang terbentuk diisi dengan kode penambahan kolom pada tabel <code>users</code>.</p><p><code>Terminal</code></p><pre><code class="language-bash">php artisan make:migration costum_table_users</code></pre><p>Setelah file migration terbuat di folder <code>database/migrations/</code>, buka file tersebut dan isi method <code>up()</code> dengan kode berikut untuk menambahkan ketiga kolom baru ke tabel <code>users</code>. Method <code>down()</code> diisi dengan kode untuk menghapus kolom tersebut apabila migration di-rollback.</p><p><code>database/migrations/..._costum_table_users.php</code></p><pre><code class="language-php">&lt;?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table-&gt;string('username')-&gt;unique();
            $table-&gt;string('level');
            $table-&gt;enum('status', ['ACTIVE', 'INACTIVE']);
        });
    }

    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table-&gt;dropColumn('username');
            $table-&gt;dropColumn('level');
            $table-&gt;dropColumn('status');
        });
    }
};</code></pre><p><code>Terminal</code></p><pre><code class="language-bash">php artisan migrate</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Struktur tabel users setelah custom migration</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.5: Struktur tabel users setelah ditambahkan kolom username, level, dan status</em></p><h3>E. Seeding: Membuat Akun Admin Awal</h3><p>Setelah struktur tabel sesuai kebutuhan, langkah berikutnya adalah membuat data akun admin secara otomatis menggunakan fitur Seeding. Seeder dibuat dengan perintah artisan, kemudian file <code>AdminSeeder.php</code> yang terbentuk diisi dengan kode untuk membuat satu akun admin. Password disimpan dalam bentuk hash menggunakan <code>Hash::make()</code> agar aman. Level disimpan dalam format JSON karena satu user dapat memiliki lebih dari satu level. Setelah seeder siap, dijalankan dengan perintah <code>php artisan db:seed</code>.</p><p><code>Terminal</code></p><pre><code class="language-bash">php artisan make:seeder AdminSeeder</code></pre><p><code>database/seeders/AdminSeeder.php</code></p><pre><code class="language-php">&lt;?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    public function run()
    {
        $admin = new \App\Models\User;
        $admin-&gt;username = 'admin';
        $admin-&gt;name     = 'Admin Aplikasi';
        $admin-&gt;email    = 'admin@sisfo.com';
        $admin-&gt;level    = json_encode(['ADMIN']);
        $admin-&gt;status   = 'ACTIVE';
        $admin-&gt;password = \Hash::make('12345678');
        $admin-&gt;save();

        $this-&gt;command-&gt;info('User Admin berhasil ditambahkan');
    }
}</code></pre><p><code>Terminal</code></p><pre><code class="language-bash">php artisan db:seed --class=AdminSeeder</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Hasil perintah db:seed --class=AdminSeeder</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.6: Seeding berhasil, user Admin berhasil ditambahkan</em></p><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan dashboard setelah login menggunakan akun admin</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.7: Berhasil login menggunakan akun admin yang baru dibuat</em></p><h3>F. Templating: Membuat Layout Global dengan SB Admin 2</h3><p>Pada tahap ini dilakukan konfigurasi tampilan aplikasi menggunakan template SB Admin 2 yang diunduh dari situs resminya. Seluruh file aset template (CSS, JS, font, dan gambar) disalin ke folder <code>public/sbadmin</code> pada project Laravel. Terdapat tiga layout utama yang dibuat, yaitu <code>app.blade.php</code> khusus untuk halaman login, dan <code>main.blade.php</code> sebagai layout utama yang menyertakan komponen <code>sidebar.blade.php</code> dan <code>topbar.blade.php</code>. Konsep <code>@yield</code> dan <code>@section</code> digunakan agar setiap halaman cukup mengisi bagian judul dan konten saja tanpa mengulang keseluruhan struktur HTML.</p><p><code>resources/views/layouts/main.blade.php (ringkasan struktur)</code></p><pre><code class="language-html">&lt;!DOCTYPE html&gt;
&lt;html lang="en"&gt;
&lt;head&gt;
    &lt;title&gt;Sisfo - @yield('judul')&lt;/title&gt;
    &lt;link href="{{ asset('sbadmin/css/sb-admin-2.min.css') }}" rel="stylesheet"&gt;
&lt;/head&gt;
&lt;body id="page-top"&gt;
    &lt;div id="wrapper"&gt;
        @include('layouts.sidebar')
        &lt;div id="content-wrapper"&gt;
            @include('layouts.topbar')
            &lt;div class="container-fluid"&gt;
                &lt;h1 class="h3 mb-4"&gt;@yield('judul')&lt;/h1&gt;
                @yield('konten')
            &lt;/div&gt;
        &lt;/div&gt;
    &lt;/div&gt;
    &lt;script src="{{ asset('sbadmin/js/sb-admin-2.min.js') }}"&gt;&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre><p>Untuk menggunakan layout tersebut pada sebuah halaman, cukup tambahkan direktif <code>@extends</code> dan <code>@section</code> di bagian atas file Blade. Sebagai contoh, halaman dashboard hanya perlu menuliskan kode berikut tanpa harus mengulang seluruh struktur HTML:</p><p><code>resources/views/home.blade.php</code></p><pre><code class="language-php">@extends('layouts.main')

@section('judul') Dashboard @endsection

@section('konten')
    &lt;p&gt;Selamat datang di halaman Dashboard.&lt;/p&gt;
@endsection</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan halaman login dengan template SB Admin 2</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.8: Halaman login setelah menggunakan template SB Admin 2</em></p><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan dashboard dengan sidebar dan topbar</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.9: Tampilan dashboard menggunakan layout main.blade.php</em></p><h3>G. Manajemen Users: Resource Controller dan Routing</h3><p>Untuk fitur manajemen pengguna, digunakan Resource Controller yang secara otomatis menyediakan tujuh method standar CRUD (index, create, store, show, edit, update, destroy). Controller dibuat menggunakan perintah artisan dengan flag <code>--resource</code>, kemudian route resource didaftarkan pada file <code>routes/web.php</code>. Dengan satu baris <code>Route::resource()</code>, Laravel otomatis mendaftarkan semua jalur URL yang diperlukan untuk operasi CRUD.</p><p><code>Terminal</code></p><pre><code class="language-bash">php artisan make:controller UserController --resource</code></pre><p><code>routes/web.php</code></p><pre><code class="language-php">use App\Http\Controllers\UserController;

Route::resource('users', UserController::class);</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Hasil php artisan route:list untuk route users</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.10: Pemetaan route resource users menggunakan php artisan route:list</em></p><h3>H. Create User (Tambah Data)</h3><p>Fitur tambah user diimplementasikan pada method <code>create()</code> dan <code>store()</code> di UserController. Method <code>create()</code> bertugas menampilkan form isian, sedangkan <code>store()</code> menangani proses penyimpanan data yang dikirim dari form tersebut. Form menggunakan elemen select dengan library Select2 agar pemilihan level (ADMIN, GURU, STAFF) dapat dilakukan secara multi-pilihan. Password disimpan dalam kondisi ter-hash, dan level disimpan dalam format JSON untuk mendukung satu user dengan banyak level.</p><p><code>app/Http/Controllers/UserController.php — method create() &amp; store()</code></p><pre><code class="language-php">public function create()
{
    return view('user.create');
}

public function store(Request $request)
{
    $user           = new \App\Models\User;
    $user-&gt;name     = $request-&gt;get('nama');
    $user-&gt;username = $request-&gt;get('username');
    $user-&gt;email    = $request-&gt;get('email');
    $user-&gt;password = \Hash::make($request-&gt;get('password'));
    $user-&gt;level    = json_encode($request-&gt;get('level'));
    $user-&gt;save();

    return redirect()-&gt;route('users.index')
                     -&gt;with('status', 'User baru berhasil ditambahkan');
}</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan form Create User di browser</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.11: Tampilan form Create User dengan field Nama, Email, Username, Password, dan Level</em></p><h3>I. Read / List Users (Tampilkan Data)</h3><p>Fitur menampilkan daftar seluruh pengguna diimplementasikan pada method <code>index()</code>. Data diambil dari model <code>User</code> menggunakan <code>::all()</code>, kemudian dikirimkan ke view <code>users/index.blade.php</code> sebagai variabel. Pada tampilan, data ditampilkan dalam bentuk tabel menggunakan library DataTables agar mendukung fitur pencarian, pengurutan, dan pagination secara otomatis. Sebuah tombol "Tambah User" juga ditampilkan untuk mengarahkan ke halaman form create.</p><p><code>app/Http/Controllers/UserController.php — method index()</code></p><pre><code class="language-php">public function index()
{
    $users = \App\Models\User::all();
    return view('users.index', ['users' =&gt; $users]);
}</code></pre><p><code>resources/views/users/index.blade.php (bagian tabel)</code></p><pre><code class="language-html">@extends('layouts.main')
@section('judul') Users @endsection
@section('konten')

@if(session('status'))
    &lt;div class="alert alert-success"&gt;{{ session('status') }}&lt;/div&gt;
@endif

&lt;p&gt;
    &lt;a href="{{ route('users.create') }}" class="btn btn-primary btn-sm"&gt;Tambah User&lt;/a&gt;
&lt;/p&gt;

&lt;table class="table table-bordered" id="dataTable"&gt;
    &lt;thead&gt;
        &lt;tr&gt;
            &lt;th&gt;Name&lt;/th&gt;
            &lt;th&gt;Username&lt;/th&gt;
            &lt;th&gt;Email&lt;/th&gt;
            &lt;th&gt;Action&lt;/th&gt;
        &lt;/tr&gt;
    &lt;/thead&gt;
    &lt;tbody&gt;
        @foreach($users as $user)
        &lt;tr&gt;
            &lt;td&gt;{{ $user-&gt;name }}&lt;/td&gt;
            &lt;td&gt;{{ $user-&gt;username }}&lt;/td&gt;
            &lt;td&gt;{{ $user-&gt;email }}&lt;/td&gt;
            &lt;td&gt;[tombol action]&lt;/td&gt;
        &lt;/tr&gt;
        @endforeach
    &lt;/tbody&gt;
&lt;/table&gt;
@endsection</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan halaman list Users di browser</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.12: Tampilan daftar users menggunakan DataTables</em></p><h3>J. Update User (Edit Data)</h3><p>Fitur edit data pengguna diimplementasikan melalui method <code>edit()</code> dan <code>update()</code>. Tombol Edit pada setiap baris tabel list user diarahkan ke URL <code>users/{id}/edit</code>. Method <code>edit()</code> mengambil data user berdasarkan ID menggunakan <code>findOrFail()</code> lalu mengirimkannya ke view form edit. Form edit menampilkan data yang sudah ada sehingga pengguna cukup mengubah bagian yang diperlukan. Karena HTML tidak mendukung method PUT secara langsung, digunakan input hidden dengan <code>name="_method"</code> bernilai <code>PUT</code>. Method <code>update()</code> kemudian menyimpan perubahan ke database.</p><p><code>app/Http/Controllers/UserController.php — method edit() &amp; update()</code></p><pre><code class="language-php">public function edit($id)
{
    $user = \App\Models\User::findOrFail($id);
    return view('user.edit', ['user' =&gt; $user]);
}

public function update(Request $request, $id)
{
    $user        = \App\Models\User::findOrFail($id);
    $user-&gt;name  = $request-&gt;get('nama');
    $user-&gt;level = json_encode($request-&gt;get('level'));
    $user-&gt;save();

    return redirect()-&gt;route('users.index', [$id])
                     -&gt;with('status', 'User berhasil diubah');
}</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan form Edit User</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.13: Tampilan form Edit User dengan data yang sudah terisi</em></p><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Halaman users setelah data berhasil diubah</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.14: Alert sukses muncul setelah data user berhasil diubah</em></p><h3>K. Delete User (Hapus Data)</h3><p>Fitur hapus data diimplementasikan melalui method <code>destroy()</code>. Tombol Hapus pada tabel list user menggunakan sebuah form HTML dengan method POST dan input hidden bernilai <code>DELETE</code> agar Laravel mengenalinya sebagai request DELETE. Sebelum data dihapus, ditampilkan dialog konfirmasi menggunakan atribut <code>onsubmit</code> pada form. Jika pengguna mengonfirmasi, method <code>destroy()</code> akan mengambil data berdasarkan ID, menghapusnya, lalu mengarahkan kembali ke halaman daftar users disertai pesan sukses.</p><p><code>resources/views/users/index.blade.php — tombol Hapus</code></p><pre><code class="language-html">&lt;form onsubmit="return confirm('Hapus data user ?')"
      class="d-inline"
      action="{{ route('users.destroy', [$user-&gt;id]) }}"
      method="POST"&gt;
    @csrf
    &lt;input type="hidden" name="_method" value="DELETE"&gt;
    &lt;input type="submit" value="Hapus" class="btn btn-danger btn-sm"&gt;
&lt;/form&gt;</code></pre><p><code>app/Http/Controllers/UserController.php — method destroy()</code></p><pre><code class="language-php">public function destroy($id)
{
    $user = \App\Models\User::findOrFail($id);
    $user-&gt;delete();

    return redirect()-&gt;route('users.index')
                     -&gt;with('status', 'User berhasil dihapus');
}</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Dialog konfirmasi hapus data muncul</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.15: Pop-up konfirmasi sebelum data user dihapus</em></p><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Halaman users setelah data berhasil dihapus</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.16: Alert sukses muncul setelah data user berhasil dihapus</em></p><h3>L. Menambahkan Menu Users pada Sidebar</h3><p>Agar menu Users dapat diakses dari sidebar navigasi, ditambahkan sebuah item menu baru pada file <code>layouts/sidebar.blade.php</code>. Item menu ini berisi ikon dan teks "Users" yang mengarah ke route <code>users.index</code>. Dengan penambahan ini, pengguna dapat langsung berpindah ke halaman manajemen users melalui sidebar tanpa harus mengetik URL secara manual.</p><p><code>resources/views/layouts/sidebar.blade.php</code></p><pre><code class="language-html">&lt;li class="nav-item"&gt;
    &lt;a class="nav-link" href="{{ route('users.index') }}"&gt;
        &lt;i class="fas fa-fw fa-users"&gt;&lt;/i&gt;
        &lt;span&gt;Users&lt;/span&gt;
    &lt;/a&gt;
&lt;/li&gt;</code></pre><p>Klik untuk upload screenshot</p><p style="text-align: center"><em>Tampilan sidebar dengan menu Users sudah muncul</em></p><p><strong>[Screenshot belum ditambahkan: Preview]</strong></p><p style="text-align: center"><em>Gambar 2.17: Menu Users berhasil muncul pada sidebar navigasi</em></p>$wp$, 1 from public.reports where slug = 'web-laravel-sisfo';
insert into public.report_sections (report_id, title, content, position) select id, $wp$3. Kesimpulan$wp$, $wp$<p>Melalui praktikum ini dapat disimpulkan bahwa Laravel menyediakan ekosistem yang sangat lengkap dan efisien untuk membangun aplikasi web. Paket <code>laravel/ui</code> memungkinkan pembuatan sistem autentikasi yang lengkap hanya dengan beberapa perintah di terminal. Kustomisasi tabel database melalui migration memberikan kontrol penuh atas struktur data tanpa harus menyentuh antarmuka database secara manual. Konsep Templating dengan Blade dan layout yang dapat diwariskan melalui <code>@extends</code> dan <code>@yield</code> sangat mempercepat pengembangan tampilan yang konsisten di seluruh halaman aplikasi. Terakhir, Resource Controller membuat implementasi CRUD menjadi jauh lebih terstruktur, karena seluruh method yang diperlukan sudah tersedia secara otomatis dengan konvensi penamaan yang baku.</p><h4>Teknologi yang digunakan:</h4><p>PHPLaravel 9Bootstrap 4SB Admin 2MySQLBlade Template</p>$wp$, 2 from public.reports where slug = 'web-laravel-sisfo';
update public.reports set updated_at = now() where slug = 'web-laravel-sisfo';

commit;
