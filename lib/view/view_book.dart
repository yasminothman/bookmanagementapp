import 'package:book_tracker_app/services/firestore_service.dart';
import 'package:book_tracker_app/view/edit_book.dart';
import 'package:flutter/material.dart';

import '../model/book.dart';

class ViewBook extends StatefulWidget {
  final String? docID;
  const ViewBook({super.key, this.docID});

  @override
  State<ViewBook> createState() => _ViewBookState();
}

class _ViewBookState extends State<ViewBook> {
  final FirestoreService firestoreService = FirestoreService();
  Book? book;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBook();
  }

  Future<void> _fetchBook() async {
    book = await firestoreService.getBookById(widget.docID!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Book",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              if (widget.docID != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBook(docID: widget.docID!),
                  ),
                );
              } else {
                // Show a message if docID is null
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Document ID is null")),
                );
              }
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : book == null
              ? const Center(
                  child: Text(
                  'Book not found',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${book!.title}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${book!.author}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Stored Location: ${book!.storedLocation}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Bought Location: ${book!.boughtLocation}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            "Date Bought: ${book!.dateBought ?? "Not Specified"}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Price: ${book!.price}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Reason: ${book!.reasonBought}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
