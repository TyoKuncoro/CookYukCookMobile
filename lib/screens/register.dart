import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_yuk_cook/screens/authPage.dart';
import 'package:cook_yuk_cook/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Register());

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // TextEditingController untuk input email dan password
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final kpasswordController = TextEditingController();

  bool obscureText = true;
  bool _obscureText = true;

  Future signUserUp() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
    // try to sign un
    if (passwordController.text != kpasswordController.text) {
      showErrorMessage('Password dan Konfirmasi Password tidak sama');
    } else {
      print('goes to else condition');
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUserDetails(
          nameController.text.trim(),
          phoneNumberController.text.trim(),
          addressController.text.trim(),
          emailController.text.trim());
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));

    // Navigator.pop(context);
  }

  Future addUserDetails(
    String nama,
    String phoneNumber,
    String address,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'nama': nama,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email
    });
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // Membersihkan TextEditingController ketika widget dihapus
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    kpasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Daftar Cook Yuk Cook'),
          automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/cyc.png"),
              SizedBox(height: 20),
              // Input email
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              // Input password
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        // Ubah status obscureText saat tombol ditekan
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
                obscureText:
                    obscureText, // Sembunyikan teks password secara default
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: kpasswordController,
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        // Ubah status obscureText saat tombol ditekan
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText:
                    _obscureText, // Sembunyikan teks password secara default
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sudah punya akun? '),
                  GestureDetector(
                      child: const Text(
                        'Masuk disini',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      }),
                ],
              ),
              SizedBox(height: 15.0),
              // Tombol login
              ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol login ditekan
                  // Validasi email dan password
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      phoneNumberController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      kpasswordController.text.isNotEmpty) {
                    // Lakukan penanganan register di sini
                    signUserUp();
                  } else {
                    // Tampilkan pesan jika input kosong
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Data diatas harus diisi semua.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
