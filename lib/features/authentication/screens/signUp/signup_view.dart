import 'package:get/get.dart';
import 'package:graduateproject/common/widgets/widgets_login_signup/form_divider.dart';
import 'package:graduateproject/common/widgets/widgets_login_signup/social_buttons.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/utils/constants/text_strings.dart';
import 'package:graduateproject/utils/consts/consts.dart';
import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
import 'package:graduateproject/features/authentication/screens/signUp/widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var isDoctor = false;
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.defaultSpace),
              //The Form
              const SignUpForm(),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Form Divider
              FormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Social Buttons
              const SocialButtons(),

              //The Logic
              // Expanded(
              //     child: Image.asset(
              //   icsignup,
              //   width: 100,
              // )),
              // AppStyle.bold(title: "wellcome in sign up", size: 25),
              // Expanded(
              //     flex: 3,
              //     child: Form(
              //         child: SingleChildScrollView(
              //       child: Column(
              //         children: [
              //           60.heightBox,
              //           CustomTextField(
              //             hint: fullName,
              //             textController: controller.fullnameController,
              //           ),
              //           const SizedBox(height: 10),
              //           CustomTextField(
              //             hint: email,
              //             textController: controller.emailController,
              //           ),
              //           const SizedBox(height: 10),
              //           CustomTextField(
              //             hint: password,
              //             textController: controller.passwordController,
              //           ),
              //           10.heightBox,
              //           SwitchListTile(
              //             title: "SignUp as a Doctor".text.make(),
              //               value: isDoctor,
              //               onChanged: (newValue) {
              //                 setState(() {
              //                   isDoctor = newValue;
              //                 });
              //               }),
              //           Visibility(
              //             visible: isDoctor,
              //             child: Column(
              //               children: [
              //                 CustomTextField(
              //                   hint: "about",
              //                   textController: controller.aboutController,
              //                 ),
              //                 10.heightBox,
              //                 CustomTextField(
              //                   hint: "category",
              //                   textController: controller.categoryController,
              //                 ),
              //                 10.heightBox,
              //                 CustomTextField(
              //                   hint: "services",
              //                   textController: controller.servicesController,
              //                 ),
              //                 10.heightBox,
              //                 CustomTextField(
              //                   hint: "Address",
              //                   textController: controller.addressController,
              //                 ),
              //                 10.heightBox,
              //                 CustomTextField(
              //                   hint: "Phone Number",
              //                   textController: controller.phoneController,
              //                 ),
              //                 10.heightBox,
              //                 CustomTextField(
              //                   hint: "Timing",
              //                   textController: controller.timingController,
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(height: 20),
              //           CustomButton(
              //             buttonText: "Sign Up ",
              //             onTap: () async {
              //               await controller.signupUser(isDoctor);
              //               if (controller.userCredential != null) {
              //                 Get.offAll(() => const Home());
              //               }
              //             },
              //           ),
              //           20.heightBox,
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
              //     )))
            ],
          ),
        ),
      ),
    );
  }
}
