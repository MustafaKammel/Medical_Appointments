import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduateproject/utils/consts/consts.dart';

import '../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import '../../../../../common/widgets/app_bar/appbar.dart';
import '../../../../../views/doctor_profile_view/doctor_profile_view.dart';

class SearchView extends StatelessWidget {
  final String searchQuery;
  const SearchView({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () {
          Get.back();
        },
        title: Text(
          "Search result",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('doctors').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data!.docs[index];
                  return !(doc['docName'].toString().toLowerCase())
                          .contains(searchQuery.toLowerCase())
                      ? const SizedBox.shrink()
                      : DoctorCardVertical(
                          image: doctor,
                          subtitle: doc['docCategory'],
                          title: doc['docName'],
                          onTap: () {
                            Get.to(() => DoctorProfileView(
                                  doc: doc,
                                ));
                          },
                        );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
