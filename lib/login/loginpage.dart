import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(const Loginpage());
}

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _ContainerViewState();
}

class _ContainerViewState extends State<Loginpage> {
  bool pass = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          (Container(
            child: (const Image(
              image: NetworkImage(
                  "https://static.vecteezy.com/system/resources/thumbnails/009/368/914/small/3d-illustrations-computer-and-account-login-and-password-form-page-on-the-screen-sign-in-to-account-user-authorization-login-page-concept-username-password-fields-data-management-png.png"),
            )),
          )),
          Container(
              child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(255, 77, 56, 193),
            ),
          )),
          const SizedBox(
            width: 200,
            height: 50,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .9,
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  hintText: "Your Email",
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  prefixIcon: const Icon(Icons.email)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .9,
            child: TextField(
              controller: password,
              obscureText: pass,
              decoration: InputDecoration(
                hintText: "Your Password",
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                filled: true,
                fillColor: Colors.grey.shade300,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: pass
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      pass = !pass;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('Sign In'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blueAccent,
                  ),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
            ),
          )
        ],
      ),
    );
  }
}
