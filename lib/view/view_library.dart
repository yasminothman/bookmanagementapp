import 'package:book_tracker_app/services/firestore_service.dart';
import 'package:book_tracker_app/view/view_book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewLibrary extends StatefulWidget {
  const ViewLibrary({super.key});

  @override
  State<ViewLibrary> createState() => _ViewLibraryState();
}

class _ViewLibraryState extends State<ViewLibrary> {
  final FirestoreService firestoreService = FirestoreService();

  String author = "";
  String title = "";
  String storedLocation = "";
  String boughtLocation = "";
  DateTime? dateBought = DateTime.now();
  double? price = 0.0;
  String? reasonBought = "";
  Timestamp? timestamp = Timestamp.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: firestoreService.getBooksStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List bookList = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = bookList[index];
                    String docID = document.id;
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    title = data['title'] ?? 'Unknown Title';
                    author = data['author'] ?? 'Unknown Author';
                    storedLocation =
                        data['storedLocation'] ?? 'Unknown Location';
                    boughtLocation =
                        data['boughtLocation'] ?? 'Unknown Location';
                    dateBought = (data['dateBought'] as Timestamp?)?.toDate() ??
                        DateTime.now();
                    price = (data['price'] as num?)?.toDouble() ?? 0.0;
                    reasonBought = data['reasonBought'] ?? 'No reason provided';

                    //display
                    return Padding(
                        padding: const EdgeInsets.only(
                            top: 30, left: 20, right: 20, bottom: 20),
                        child: Card(
                          color: const Color(0xFF98DFEA),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ViewBook(docID: docID)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(author,
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                          ),
                        ));
                  });
            } else {
              return const Center(child: Text('No books yet... '));
            }
          }),
    );
  }
}
