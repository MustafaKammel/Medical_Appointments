import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/views/payment/stripe_payment/payment_manager.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/widgets/app_bar/appbar.dart';
import '../../utils/consts/consts.dart';
import '../../features/App/controllers/appointment_controller.dart';

class BookAppointmentView extends StatelessWidget {
  final String docId;
  final String docName;
  final double amount;
  const BookAppointmentView(
      {super.key,
      required this.docName,
      required this.docId,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmnetController());
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () => Get.back(),
        title: Text(
          "Dr $docName",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //UserName
              TextField(
                expands: false,
                controller: controller.appDayController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_view_day),
                  hintText: "Select day",
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                expands: false,
                controller: controller.appTimeController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.timelapse_outlined),
                  hintText: "Select time",
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                expands: false,
                controller: controller.appMobileController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.call),
                  hintText: "Mobile Number",
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                expands: false,
                controller: controller.appNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user_edit),
                  hintText: "Full Name",
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                expands: false,
                controller: controller.appMessageController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.message),
                  hintText: "Enter the message",
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      try {
                        await PaymentManager.makePayment(amount, "egp");
                        await controller.bookAppointment(
                            // ignore: use_build_context_synchronously
                            docId,
                            docName,
                            context);
                      } catch (e) {
                        if (e is StripeException) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'error from stripe ${e.error.localizedMessage}'),
                            ),
                          );
                        }
                      }
                    },
                    child: Row(
                      children: [
                        50.widthBox,
                        const Text('BOOKING NOW '),
                        60.widthBox,
                        Text(
                          '$amount   LE',
                          style: const TextStyle(
                              color: Colors.green, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
