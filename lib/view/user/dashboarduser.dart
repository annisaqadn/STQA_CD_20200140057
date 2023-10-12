import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redlenshoescleaning/controller/pesanancontroller.dart';

import 'package:redlenshoescleaning/view/user/createpesanan.dart';

import 'package:redlenshoescleaning/view/user/pesananselesai.dart';
import 'package:redlenshoescleaning/view/user/pesananonprocess.dart';

import '../../controller/authcontroller.dart';
import '../loginpage.dart';
import 'detailpesanan.dart';

class DashboardUser extends StatefulWidget {
  const DashboardUser({Key? key});

  @override
  State<DashboardUser> createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
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
          'Menunggu Konfirmasi',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
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
                final List<DocumentSnapshot> onProcessData = [];
                final List<DocumentSnapshot> otherData = [];

                // Separate data based on the status of the order
                for (final document in data) {
                  final status = document['status'];
                  if (status == 'Finished') {
                    finishedData.add(document);
                  } else if (status == 'On Process') {
                    onProcessData.add(document);
                  } else {
                    otherData.add(document);
                  }
                }

                return ListView.builder(
                  itemCount: otherData.length,
                  itemBuilder: (context, index) {
                    final document = otherData[index];

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePesanan(),
            ),
          );
        },
        backgroundColor: const Color(0xFFD9D9D9),
        child: const Icon(Icons.add),
      ),
    );
  }
}
