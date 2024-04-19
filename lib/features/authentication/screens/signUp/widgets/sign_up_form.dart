import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/constants/text_strings.dart';
import 'terms_and_conditions_checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var isDoctor = false;

  List<String> categoryList = [
    "Cardiolo", //أمراض القلب
    "Ophthalmology", //طب العيون
    "pulmonology", //أمراض الرئة
    "Dentist", //طبيب أسنان
    "Neurology", //علم الأعصاب
    "Orthopedic", //تقويم العظام
    "Nephrology", //أمراض الكلى
    "Otolaryngolgy",
    // Add more categories as needed
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //UserName
          TextFormField(
            keyboardType: TextInputType.name,
            controller: controller.fullnameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user_edit),
              labelText: TTexts.username,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required!';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
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

          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Password
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: controller.passwordController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required.';
              }

              // Check for minimum password length
              if (value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }

              // Check for uppercase letters
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one uppercase letter.';
              }

              // Check for numbers
              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Password must contain at least one number.';
              }

              // Check for special characters
              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return 'Password must contain at least one special character.';
              }

              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          SwitchListTile(
            title: const Text("Sign up as a Doctor"),
            value: isDoctor,
            onChanged: (newValue) {
              setState(() {
                isDoctor = newValue;
              });
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Visibility(
            visible: isDoctor,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.aboutController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.info_circle),
                    labelText: "About",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'About is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                //  DropdownButtonFormField<String>(
                //     controller: controller.categoryController,
                //     decoration: const InputDecoration(
                //       prefixIcon: Icon(Iconsax.category),
                //       labelText: "Category",
                //     ),
                //     items: categoryList.map((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(value),
                //       );
                //     }).toList(),
                //     value: selectedCategory,
                //     onChanged: (String? value) {
                //       setState(() {
                //         selectedCategory = value;
                //       });
                //     },
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Category is required.';
                //       }
                //       return null;
                //     },
                //   ),

                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.categoryController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.category),
                    labelText: "Category",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.servicesController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.medical_services),
                    labelText: "Services",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Services are required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: controller.addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: "Phone Number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: controller.timingController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.timelapse_outlined),
                    labelText: "Timing",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Timing is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.salaryController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.timelapse_outlined),
                    labelText: "Add Your Salary",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Salary is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Terms & Conditions of CheckBox
          const TermsAndConditionsCheckBox(),

          const SizedBox(height: TSizes.spaceBtwSections),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  controller.signupUser(isDoctor);
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Do you have an account?"),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  " Log in",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


// import 'package:get/get.dart';
// import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
// import 'package:graduateproject/navigation_menu.dart';
// import 'package:graduateproject/utils/consts/consts.dart';
// import 'package:iconsax/iconsax.dart';

// import '../../../../../../../utils/constants/sizes.dart';
// import '../../../../../../../utils/constants/text_strings.dart';
// import 'terms_and_conditions_checkbox.dart';

// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   var isDoctor = false;
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           //UserName
//           TextFormField(
//             expands: false,
//             keyboardType: TextInputType.name,
//             controller: controller.fullnameController,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Iconsax.user_edit),
//               label: Text(TTexts.username),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'User name is required !';
//               }
//             },
//           ),

//           const SizedBox(height: TSizes.spaceBtwInputFields),

//           //Email
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             controller: controller.emailController,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Iconsax.direct),
//               label: Text(TTexts.email),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Email is required.';
//               }

//               // Regular expression for email validation
//               final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

//               if (!emailRegExp.hasMatch(value)) {
//                 return 'Invalid email address.';
//               }

//               return null;
//             },
//           ),

//           const SizedBox(height: TSizes.spaceBtwInputFields),

//           //Password
//           TextFormField(
//             keyboardType: TextInputType.visiblePassword,
//             controller: controller.passwordController,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Iconsax.password_check),
//               label: Text(TTexts.password),
//               suffixIcon: Icon(Iconsax.eye_slash),
//             ),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Password is required.';
//               }

//               // Check for minimum password length
//               if (value.length < 6) {
//                 return 'Password must be at least 6 characters long.';
//               }

//               // Check for uppercase letters
//               if (!value.contains(RegExp(r'[A-Z]'))) {
//                 return 'Password must contain at least one uppercase letter.';
//               }

//               // Check for numbers
//               if (!value.contains(RegExp(r'[0-9]'))) {
//                 return 'Password must contain at least one number.';
//               }

//               // Check for special characters
//               if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
//                 return 'Password must contain at least one special character.';
//               }

//               return null;
//             },
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           SwitchListTile(
//               title: "SignUp as a Doctor".text.make(),
//               value: isDoctor,
//               onChanged: (newValue) {
//                 setState(() {
//                   isDoctor = newValue;
//                 });
//               }),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           Visibility(
//             visible: isDoctor,
//             child: Column(
//               children: [
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   controller: controller.aboutController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.info_circle),
//                     label: Text("about"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   controller: controller.categoryController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.category),
//                     label: Text("category"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   controller: controller.servicesController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.medical_services),
//                     label: Text("services"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//                 TextFormField(
//                   keyboardType: TextInputType.streetAddress,
//                   controller: controller.addressController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.location_on),
//                     label: Text("address"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//                 TextFormField(
//                   keyboardType: TextInputType.phone,
//                   controller: controller.phoneController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Iconsax.call),
//                     label: Text("phone number"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//                 TextFormField(
//                   keyboardType: TextInputType.datetime,
//                   controller: controller.timingController,
//                   decoration: const InputDecoration(
//                     prefixIcon: Icon(Icons.timelapse_outlined),
//                     label: Text("timing"),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required.';
//                     }
//                   },
//                 ),
//                 const SizedBox(height: TSizes.spaceBtwInputFields),
//               ],
//             ),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),

//           // Terms & Conditions of CheckBox
//           const TermsAndConditionsCheckBox(),

//           const SizedBox(height: TSizes.spaceBtwSections),

//           // create account Button
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//                 onPressed: () async {
//                   await controller.signupUser(isDoctor);
//                   if (controller.userCredential != null) {
//                     Get.offAll(() => const NavigationMenu());
//                   }
//                   // Get.to(() => const VerifyEmailScreen());
//                 },
//                 child: const Text(TTexts.createAccount)),
//           ),
//           const SizedBox(height: TSizes.spaceBtwInputFields),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppStyle.normal(title: "do have an acount ?"),
//               8.widthBox,
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: AppStyle.normal(title: " Log in", size: 15),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
