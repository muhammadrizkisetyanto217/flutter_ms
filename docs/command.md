# Build flutter web
sebelum dipublish. Build dulu

muhammadrizkisetyanto@MacBook-Air-Muhammad flutter_ppkd % flutter build web    

# Upload ke vercel
muhammadrizkisetyanto@MacBook-Air-Muhammad flutter_ppkd % vercel --prod build/web


# Masuk ke sql lite

📌 Langkah 1: Masuk ke Emulator via ADB

Buka terminal macOS dan jalankan perintah berikut:
adb shell


📌 Langkah 2: Masuk ke Direktori Aplikasi

Buka file AndroidManifest.xml di Flutter project kamu:
📂 android/app/src/main/AndroidManifest.xml

hasilnya
run-as com.example.flutter_ppkd
cd databases


📌 Langkah 3: Cek Database yang Ada
ls -l

📌 Pastikan file database terlihat, contohnya:

-rw------- 1 u0_a190 u0_a190 24576 2025-03-11 11:15 app_database.db
-rw------- 1 u0_a190 u0_a190     0 2025-03-11 11:15 app_database.db-journal
Jika file app_database.db ada, lanjut ke langkah berikut.

📌 Langkah 4: Masuk ke SQLite CLI
sqlite3 app_database.db

📌 Jika berhasil, akan muncul tampilan seperti ini:
SQLite version 3.39.2 2022-07-21 15:24:47
Enter ".help" for usage hints.
sqlite>

📌 Langkah 5: Jalankan Query untuk Melihat Data
1️⃣ Cek isi tabel users:
SELECT * FROM users;
📌 Contoh hasil jika ada data di database:
1|Budi|budi@example.com|25
2|Siti|siti@example.com|30

2️⃣ (Opsional) Cek struktur tabel users:
PRAGMA table_info(users);
📌 Output contoh:
0|id|INTEGER|1||1
1|name|TEXT|1||0
2|email|TEXT|1||0
3|age|INTEGER|1||0


📌 Langkah 6: Keluar dari SQLite CLI
Ketik:
.exit


📌 Atau alternatif lain:
.quit


📌 Langkah 7: Keluar dari ADB Shell
Keluar dari direktori database:
exit


Keluar dari ADB Shell kembali ke terminal macOS:
exit


# Masuk ke Shared-Pref
emu64a:/data/user/0/com.example.flutter_ppkd $ cd shared_prefs/                                                                                    

 cat FlutterSharedPreferences.xml                                                                                                                                                 
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="flutter.username">John Doe</string>
    <string name="flutter.auth_token">eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDEzMjgwMjAsImlkIjoxfQ.7RqacxzS7CN1PKioRmujZpkkjIWfjY4pRK8Z5VaqsG4</string>
    <boolean name="flutter.isDarkMode" value="false" />
    <long name="flutter.age" value="25" />
</map>



# Ambil SHA-1
muhammadrizkisetyanto@MacBook-Air-Muhammad flutter_ppkd % keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android

Alias name: androiddebugkey
Creation date: Jan 7, 2024
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Sun Jan 07 10:18:19 WIB 2024 until: Tue Dec 30 10:18:19 WIB 2053
Certificate fingerprints:
         SHA1: 57:24:27:D8:5A:9A:43:40:29:0F:BD:3D:C0:40:A2:1D:8F:EF:F4:E3
         SHA256: 84:49:59:08:42:EE:99:25:52:FB:95:0C:67:21:1F:A5:59:B9:FD:7E:D6:6C:5A:70:F9:2D:BB:D4:98:5A:34:6C
Signature algorithm name: SHA256withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1


# OAuth client created
379070909623-n1fn7se8ku3j1n5p3odmmvm46bcj9dn0.apps.googleusercontent.com