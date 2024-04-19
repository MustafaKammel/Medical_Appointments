import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
import 'package:graduateproject/navigation_menu.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/utils/constants/text_strings.dart';
import 'package:graduateproject/features/authentication/screens/signUp/signup_view.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';

import '../../../../App/screens/Schedule/views/upcoming_schedule.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var isDoctor = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required.';
                }

                // Regular expression for email validation
                final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                if (!emailRegExp.hasMatch(value)) {
                  return 'Invalid email address.';
                }

                return null;
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            // Password
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: controller.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),

            SwitchListTile(
              value: isDoctor,
              onChanged: (newValue) {
                setState(() {
                  isDoctor = newValue;
                });
              },
              title: const Text("Sign in as a Doctor"),
            ),

            // Remember and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  // => Get.to(() => const ForgetPassword()),
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.lg,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await controller.loginUser();
                    if (controller.userCredential != null) {
                      if (isDoctor) {
                        Get.offAll(() => const Upcomingschedule());
                      } else {
                        Get.offAll(() => const NavigationMenu());
                      }
                    }
                  }
                },
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(
              height: TSizes.lg,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(() => const SignUpView());
                  // Get.to(() => const SignUpScreen());
                },
                child: const Text(TTexts.createAccount),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
// import 'package:graduateproject/navigation_menu.dart';
// import 'package:graduateproject/utils/consts/consts.dart';
// import 'package:graduateproject/features/authentication/screens/signUp/signup_view.dart';
// import 'package:graduateproject/utils/validator/validation.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../../../../utils/constants/sizes.dart';
// import '../../../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
// import '../../../../App/screens/Schedule/views/upcoming_schedule.dart';

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   var isDoctor = false;

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());
//     return Form(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
//         child: Column(
//           children: [
//             // Email
//             TextFormField(
//               validator: ,
//               keyboardType: TextInputType.emailAddress,
//               controller: controller.emailController,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Iconsax.direct_right),
//                 label: Text(TTexts.email),
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwInputFields,
//             ),

//             // Password
//             TextFormField(
//               validator: ,
//               keyboardType: TextInputType.visiblePassword,
//               controller: controller.passwordController,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Iconsax.password_check),
//                 label: Text(TTexts.password),
//                 suffixIcon: Icon(Iconsax.eye_slash),
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.spaceBtwInputFields,
//             ),

//             SwitchListTile(
//               value: isDoctor,
//               onChanged: (newValue) {
//                 setState(() {
//                   isDoctor = newValue;
//                 });
//               },
//               title: "Sign in as a Doctor".text.make(),
//             ),

//             // Remember and forget password
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(value: true, onChanged: (value) {}),
//                     const Text(TTexts.rememberMe),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   // => Get.to(() => const ForgetPassword()),
//                   child: const Text(TTexts.forgetPassword),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: TSizes.lg,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await controller.loginUser();
//                   if (controller.userCredential != null) {
//                     if (isDoctor) {
//                       Get.offAll(() => const Upcomingschedule());
//                     } else {
//                       Get.offAll(() => const NavigationMenu());
//                     }
//                   }
//                   //Get.to(() => const NavigationMenu());
//                 },
//                 child: const Text(TTexts.signIn),
//               ),
//             ),
//             const SizedBox(
//               height: TSizes.lg,
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () {
//                   Get.to(() => const SignUpView());
//                   // Get.to(() => const SignUpScreen());
//                 },
//                 child: const Text(TTexts.createAccount),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
