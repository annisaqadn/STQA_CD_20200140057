import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redlenshoescleaning/view/admin/detaildaftarpesanan.dart';

enum FilterOptions {
  MenungguKonfirmasi,
  OnProcess,
  Finished,
}

class PesananPage extends StatefulWidget {
  const PesananPage({Key? key}) : super(key: key);

  @override
  State<PesananPage> createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FilterOptions _selectedFilter = FilterOptions.MenungguKonfirmasi;

  void _setFilter(FilterOptions option) {
    setState(() {
      _selectedFilter = option;
    });
  }

  List<DocumentSnapshot> _getFilteredData(QuerySnapshot snapshot) {
    switch (_selectedFilter) {
      case FilterOptions.MenungguKonfirmasi:
        return snapshot.docs
            .where((doc) => doc['status'] == 'Pending')
            .toList();
      case FilterOptions.OnProcess:
        return snapshot.docs
            .where((doc) => doc['status'] == 'On Process')
            .toList();
      case FilterOptions.Finished:
        return snapshot.docs
            .where((doc) => doc['status'] == 'Finished')
            .toList();
    }
  }

  void _selesaikanPesanan(DocumentSnapshot document) {
    _firestore
        .collection('pesanan')
        .doc(document.id)
        .update({'status': 'Finished'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD9D9D9),
        centerTitle: true,
        title: Text(
          'Daftar Pesanan',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<FilterOptions>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => <PopupMenuEntry<FilterOptions>>[
              const PopupMenuItem<FilterOptions>(
                value: FilterOptions.MenungguKonfirmasi,
                child: Text('Menunggu Konfirmasi'),
              ),
              const PopupMenuItem<FilterOptions>(
                value: FilterOptions.OnProcess,
                child: Text('On Process'),
              ),
              const PopupMenuItem<FilterOptions>(
                value: FilterOptions.Finished,
                child: Text('Finished'),
              ),
            ],
            onSelected: _setFilter,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('pesanan').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> data =
                _getFilteredData(snapshot.data!);

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final pesanan = data[index].data() as Map<String, dynamic>;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20.0,
                  ),
                  child: InkWell(
                    onLongPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailDataPesanan(
                            selectedDate: pesanan['selectedDate'],
                            namapemilik: pesanan['namapemilik'],
                            notelepon: pesanan['notelepon'],
                            sepatu: pesanan['sepatu'],
                            listitem: pesanan['listitem'],
                            harga: pesanan['harga'],
                            status: pesanan['status'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xFFD9D9D9),
                      elevation: 4,
                      child: ListTile(
                        title: Text(pesanan['selectedDate']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pesanan['namapemilik']),
                            Text(pesanan['sepatu']),
                            Text(pesanan['listitem']),
                            Text(pesanan['status']),
                          ],
                        ),
                        onTap: () {
                          if (pesanan['status'] == 'Pending') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Konfirmasi Pesanan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Tanggal: ${pesanan['selectedDate']}'),
                                    Text(
                                        'Nama Pemilik: ${pesanan['namapemilik']}'),
                                    Text('No Telepon: ${pesanan['notelepon']}'),
                                    Text('Sepatu: ${pesanan['sepatu']}'),
                                    Text(
                                        'Jenis Treatment: ${pesanan['listitem']}'),
                                    Text('Harga: ${pesanan['harga']}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _firestore
                                          .collection('pesanan')
                                          .doc(data[index].id)
                                          .update({'status': 'On Process'});
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Confirm',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (pesanan['status'] == 'On Process') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Selesaikan Pesanan',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Tanggal: ${pesanan['selectedDate']}'),
                                    Text(
                                        'Nama Pemilik: ${pesanan['namapemilik']}'),
                                    Text('No Telepon: ${pesanan['notelepon']}'),
                                    Text('Sepatu: ${pesanan['sepatu']}'),
                                    Text(
                                        'Jenis Treatment: ${pesanan['listitem']}'),
                                    Text('Harga: ${pesanan['harga']}'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      _selesaikanPesanan(data[index]);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Selesaikan Pesanan',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
