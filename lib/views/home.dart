import 'package:flutter/material.dart';

import 'package:api_loacaldb_getx/utils/custom_textfield.dart';
import 'package:api_loacaldb_getx/utils/custom_button.dart';

enum AuthVal { signIn, signUp }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthVal _auth = AuthVal.signUp;

  final _signUpKey = GlobalKey<FormState>();
  final _signInKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        "images/api.jpg",
        width: 700,
        height: 300,
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Welcome to API",
        style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10,
      ),
      const Text(
        "Check out free post and user API info from jsonplaceholder",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
    ])));
  }
}





// Padding(
//         padding: const EdgeInsets.all(3),
//         child: Column(
//           children: [
//             // const Text(
//             //   "Acc",
//             //   style: TextStyle(
//             //     fontSize: 22,
//             //     fontWeight: FontWeight.w500,
//             //   ),
//             // ),
//             ListTile(
//               title: const Text(
//                 "Welcome",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               leading: Radio(
//                 value: AuthVal.signUp,
//                 groupValue: _auth,
//                 onChanged: (AuthVal? val) {
//                   setState(() {
//                     _auth = val!;
//                   });
//                 },
//               ),
//             ),
//             if (_auth == AuthVal.signUp)
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 child: Column(
//                   children: [
//                     CustomText(
//                       txt: "Enter Fullname",
//                       ctrl: _nameCtrl,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomText(
//                       txt: "Enter Email",
//                       ctrl: _emailCtrl,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomText(
//                       txt: "Enter Password",
//                       ctrl: _passCtrl,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     CustomButton(
//                       txt: "Sign Up",
//                       onTap: () {
//                         //
//                         if (_signInKey.currentState!.validate()) {
//                           // sign in function
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ListTile(
//               title: const Text(
//                 "Sign In",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               leading: Radio(
//                 value: AuthVal.signIn,
//                 groupValue: _auth,
//                 onChanged: (AuthVal? val) {
//                   _auth = val!;
//                 },
//               ),
//             ),
//             if (_auth == AuthVal.signIn)
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 child: Form(
//                   key: _signInKey,
//                   child: Column(
//                     children: [
//                       CustomText(
//                         txt: "Enter Email",
//                         ctrl: _emailCtrl,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       CustomText(
//                         txt: "Enter Password",
//                         ctrl: _passCtrl,
//                       ),
//                       CustomButton(
//                         txt: "LogIn",
//                         onTap: () {
//                           if (_signUpKey.currentState!.validate()) {
//                             // do something to save login info
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     )