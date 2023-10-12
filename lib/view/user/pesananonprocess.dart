import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redlenshoescleaning/view/user/pesananselesai.dart';

import '../../controller/authcontroller.dart';
import '../../controller/pesanancontroller.dart';
import '../loginpage.dart';
import 'dashboarduser.dart';
import 'detailpesanan.dart';

class PesananOnProcess extends StatefulWidget {
  const PesananOnProcess({
    Key? key,
    required this.selectedDate,
    required this.namapemilik,
    required this.notelepon,
    required this.sepatu,
    required this.listitem,
    required this.harga,
    required this.status,
  }) : super(key: key);

  final String selectedDate;
  final String namapemilik;
  final String notelepon;
  final String sepatu;
  final String listitem;
  final String harga;
  final String status;
  @override
  State<PesananOnProcess> createState() => _PesananOnProcessState();
}

class _PesananOnProcessState extends State<PesananOnProcess> {
  final AuthController authController = AuthController();
  var pesc = PesananController();

  @override
  void initState() {
    pesc.getPesanan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD9D9D9),
        centerTitle: true,
        title: Text(
          'On Process',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -15,
                    right: -10,
                    child: IconButton(
                      icon: const Icon(Icons.logout),
                      color: Colors.black,
                      onPressed: () {
                        authController.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REDLEN APPS',
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pending_actions_outlined),
              title: const Text('Pesanan Pending'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardUser(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.downloading_outlined),
              title: const Text('Pesanan On Process'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PesananOnProcess(
                      harga: '',
                      listitem: '',
                      namapemilik: '',
                      notelepon: '',
                      selectedDate: '',
                      sepatu: '',
                      status: '',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_turned_in),
              title: const Text('Pesanan Selesai'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PesananSelesai(
                      harga: '',
                      listitem: '',
                      namapemilik: '',
                      notelepon: '',
                      selectedDate: '',
                      sepatu: '',
                      status: '',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<DocumentSnapshot>>(
              stream: pesc.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<DocumentSnapshot> data = snapshot.data!;
                final List<DocumentSnapshot> finishedData = [];

                // Filter data berdasarkan status "Finished"
                for (final document in data) {
                  final status = document['status'];
                  if (status == 'On Process') {
                    finishedData.add(document);
                  }
                }

                return ListView.builder(
                  itemCount: finishedData.length,
                  itemBuilder: (context, index) {
                    final document = finishedData[index];

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
                              builder: (context) => DetailPesanan(
                                selectedDate: document['selectedDate'],
                                namapemilik: document['namapemilik'],
                                notelepon: document['notelepon'],
                                sepatu: document['sepatu'],
                                listitem: document['listitem'],
                                harga: document['harga'],
                                status: document['status'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color(0xFFD9D9D9),
                          elevation: 4,
                          child: ListTile(
                            title: Text(document['selectedDate']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(document['sepatu']),
                                Text(document['listitem']),
                                Text(document['harga']),
                                Text(document['status']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
