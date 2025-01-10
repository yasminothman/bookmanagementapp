import 'package:book_tracker_app/components/text_field.dart';
import 'package:book_tracker_app/model/book.dart';
import 'package:book_tracker_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final FirestoreService firestoreService = FirestoreService();

  final bool _customIcon = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController storedController = TextEditingController();
  final TextEditingController boughtLocationController =
      TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.camera,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 70),
              TextFieldComponent(label: "Title", controller: titleController),
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
                title: const Text(
                  "Additional Information",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(
                  _customIcon ? Icons.arrow_upward : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
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
                  firestoreService.addBook(book);

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
      ),
    );
  }
}
