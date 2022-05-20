import 'package:flutter/material.dart';
import 'package:getx_tutorial/sizes_helpers.dart';
import 'package:getx_tutorial/veri_girme.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(180),
            child: AppBar(
              title: const Text(""),
              centerTitle: true,
              /*             flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.contain)),
              ),*/
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(90))),
              backgroundColor: Color.fromARGB(255, 50, 59, 61),
            )),
        body: Container(
          width: displayWidth(context),
          height: displayHeight(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFD67C53)],
              stops: [0, 1],
              begin: AlignmentDirectional(0, -1),
              end: AlignmentDirectional(0, 1),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 50, 59, 61), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 50, 59, 61),
                              width: 1.5)),
                      hintText: "Mailinizi giriniz",
                      labelText: "Mail",
                      labelStyle:
                          new TextStyle(color: Color.fromARGB(255, 50, 59, 61)),
                      prefixIcon: Icon(
                        Icons.mail,
                        color: Color.fromARGB(255, 50, 59, 61),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 50, 59, 61), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 50, 59, 61),
                              width: 1.5)),
                      hintText: "Şifrenizi giriniz",
                      labelText: "Şifre",
                      labelStyle:
                          new TextStyle(color: Color.fromARGB(255, 50, 59, 61)),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Color.fromARGB(255, 50, 59, 61),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 110,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Şifremi unuttum",
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 50, 59, 61))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 50, 59, 61))),
                    child: Text("Giriş"),
                    onPressed: () {
                      _authService
                          .signIn(
                              _emailController.text, _passwordController.text)
                          .then((value) {
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GozlemPage()));
                      }).catchError((dynamic error) {
                        print(error);
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                Container(
                    decoration: const BoxDecoration(border: Border()),
                    child: const Text(
                      "egetechno.com",
                      style: TextStyle(
                        color: Color.fromARGB(255, 50, 59, 61),
                      ),
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          ),
        ));
  }
}
