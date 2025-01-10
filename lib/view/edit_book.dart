import 'package:book_tracker_app/components/text_field.dart';
import 'package:book_tracker_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/book.dart';

class EditBook extends StatefulWidget {
  final String docID;
  const EditBook({super.key, required this.docID});

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final FirestoreService firestoreService = FirestoreService();
  Book? book;
  final bool _customIcon = false;
  bool isLoading = true;

  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController storedController;
  late TextEditingController boughtLocationController;
  late TextEditingController dateController;
  late TextEditingController priceController;
  late TextEditingController reasonController;

  Future<void> _fetchBook() async {
    book = await firestoreService.getBookById(widget.docID);
    if (book != null) {
      // Initialize controllers with existing book data
      titleController = TextEditingController(text: book!.title);
      authorController = TextEditingController(text: book!.author);
      storedController = TextEditingController(text: book!.storedLocation);
      boughtLocationController =
          TextEditingController(text: book!.boughtLocation);
      dateController = TextEditingController(
          text: book!.dateBought != null ? book!.dateBought.toString() : '');
      priceController = TextEditingController(
          text: book!.price != null ? book!.price.toString() : '');
      reasonController = TextEditingController(text: book!.reasonBought);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Book"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                TextFieldComponent(
                  label: 'title',
                  controller: titleController,
                ),
                const SizedBox(height: 10),
                TextFieldComponent(
                  label: "Author",
                  controller: authorController,
                ),
                const SizedBox(height: 10),
                TextFieldComponent(
                  label: "Where stored",
                  controller: storedController,
                ),
                const SizedBox(height: 10),

                // Additional Information
                ExpansionTile(
                  title: const Text("Additional Information"),
                  trailing: Icon(
                      _customIcon ? Icons.arrow_upward : Icons.arrow_drop_down),
                  children: [
                    TextFieldComponent(
                      label: "Where did you buy the book?",
                      controller: boughtLocationController,
                    ),
                    const SizedBox(height: 10),
                    TextFieldComponent(
                      label: "When did you buy the book?",
                      controller: dateController,
                    ),
                    const SizedBox(height: 10),
                    TextFieldComponent(
                      label: "How much did you pay for the book?",
                      controller: priceController,
                    ),
                    const SizedBox(height: 10),
                    TextFieldComponent(
                      label: "Why did you buy the book",
                      controller: reasonController,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            // Button Save
            Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Book book = Book(
                        title: titleController.text,
                        author: authorController.text,
                        storedLocation: storedController.text,
                        boughtLocation: boughtLocationController.text,
                        dateBought: DateTime.tryParse(dateController.text),
                        price: double.tryParse(priceController.text),
                        reasonBought: reasonController.text,
                        timestamp: Timestamp.now());

                    // add new book
                    firestoreService.updateBook(book, widget.docID);

                    //clear
                    titleController.clear();
                    authorController.clear();
                    storedController.clear();
                    boughtLocationController.clear();
                    dateController.clear();
                    priceController.clear();
                    reasonController.clear();

                    // snackbar
                  },
                  child: const Text("Save"))),
        ));
  }
}
