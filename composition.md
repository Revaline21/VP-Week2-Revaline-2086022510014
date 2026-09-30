
State yang dipakai bersama (`item`, `filter bar`, `goalValue`) itu dipegang oleh
`VaultScreen`. Jadi widget anak hanya akan menerima data lewat constructor dan melaporkannnya lewat callback.

VaultSummaryCard
- Trigger: readability. Hanya dipakai sekali, tapi blok Card + progress bar membuat `build()` layar utama terlalu panjang.
- Owns: tampilan ringkasan, termasuk hitungan persentase progres (`totalValue / goalValue`, dibatasi 0–1). sehingga tidak punya state sendiri.
- Reports upward: tidak ada. Widget ini hanya menampilkan data.

ConditionFilterBar
- Trigger: readability. Deretan ChoiceChip dan scroll dipisah  dari layar utama.
- Owns: tampilan chip "Semua" + satu chip per `Condition`. Tidak punya state endiri, pilihan aktif (`selected`) datang dari parent.
- Reports upward: `onChanged(Condition?)`. `null` berarti "Semua".

aultItemTile
- Trigger: reuse. Dirender sekali per item di `ListView.builder`.
- Owns: tampilan satu item (avatar kategori, nama, kondisi, tanggal beli, harga). Tidak punya state sendiri.
- Reports upward: `onDelete` tanpa argumen. Widget tidak mengenal id-nya sendiri untuk dihapus; parent yang mengikat id lewat closure.

AddItemSheet
- Trigger: readability. Form berisi banyak field dan logika sendiri, jadi dipisah supaya `VaultScreen` tidak ikut membengkak.
- Owns: state draf form (dua `TextEditingController`, kategori, kondisi, tanggal), pemilihan tanggal, validasi sederhana, dan `dispose` controller. State ini sengaja tidak di-hoist karena parent tidak perlu tahu isi draf sebelum disimpan.
- Reports upward:`onSubmit(VaultItem)` saat Simpan ditekan. Sheet membangun `VaultItem` lengkap (termasuk id) lalu menutup dirinya sendiri.

