import 'package:flutter/material.dart';

import 'data/userService.dart';
import 'home.dart';
import 'myTextFormField.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UserService userService = UserService();
  bool isLoading = false;


  void login(BuildContext context) async {

    if (!formKey.currentState!.validate()) {
      return;
    }

    String username = usernamecontroller.text.trim();
    String password = passwordcontroller.text;
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      bool userFound = await userService.login(username, password);
      if (!context.mounted) return;
      if (userFound) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(username)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid username or password'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            //backgroundColor: Colors.amber,
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to connect to server'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Login page"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
              key: formKey,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 100, color: Colors.indigo),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: usernamecontroller,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
    const SizedBox(
    height: 20,
    ),
            TextFormField(
              controller: passwordcontroller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }

                if (value.length < 4) {
                  return 'Password must be at least 4 characters';
                }

                return null;
              },

            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                      ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Register(), // اسم كلاس صفحة التسجيل
                      ),
                    );
                  },
                  child: const Text(
                    "ليس لديك حساب؟ سجل الآن",
                    style: TextStyle(color: Colors.white),
                  ),

                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: isLoading ? null : () => login(context),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('دخول',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            )
        ],


      )),
      ),
    );
  }
}
