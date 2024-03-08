import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loop extends StatefulWidget {
  const Loop({super.key});

  @override
  State<Loop> createState() => _LoopState();
}

class _LoopState extends State<Loop> {
  final List<String> daftarNama1 = [
    'Tomyam',
    'Soto rawon',
    'Telur dadar',
  ];

  final user = FirebaseAuth.instance.currentUser!;

  //sign user out method
  signUserOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
      ]),
      body: ListView.builder(
        itemCount: daftarNama1.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(daftarNama1[index]),
            // Tambahkan styling di sini
            tileColor: index % 2 == 0
                ? Colors.grey[200]
                : Colors.white, // Ganti warna setiap dua baris
            contentPadding:
                EdgeInsets.all(16.0), // Padding konten dalam ListTile
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8.0), // Border radius ListTile
              side: BorderSide(color: Colors.blue), // Garis tepi ListTile
            ),
          );
        },
      ),
    );
  }
}
