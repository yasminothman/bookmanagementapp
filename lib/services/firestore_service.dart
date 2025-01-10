import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/book.dart';

class FirestoreService {
  //get collection of books

  final CollectionReference books =
      FirebaseFirestore.instance.collection('books');

  //CREATE: Add new book
  Future<DocumentReference<Object?>> addBook(Book book) async {
    return books.add({
      'title': book.title,
      'author': book.author,
      'stored': book.storedLocation,
      'boughtLocation': book.boughtLocation,
      'timeBought': book.dateBought,
      'price': book.price,
      'reasonBought': book.reasonBought,
      'timestamp': book.timestamp
    });
  }

  //READ: Get the lists of books
  Stream<QuerySnapshot> getBooksStream() {
    final booksStream =
        books.orderBy('timestamp', descending: true).snapshots();
    return booksStream;
  }

  //GET: Get books by ID
  Future<Book?> getBookById(String docId) async {
    try {
      DocumentSnapshot document = await books.doc(docId).get();
      if (document.exists) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Create and return the Book object
        return Book(
          title: data['title'] ?? 'Unknown Title',
          author: data['author'] ?? 'Unknown Author',
          storedLocation: data['storedLocation'] ?? 'Unknown Location',
          boughtLocation: data['boughtLocation'] ?? 'Unknown Location',
          dateBought: (data['dateBought'] as Timestamp?)?.toDate(),
          price: (data['price'] as num?)?.toDouble(),
          reasonBought: data['reasonBought'] ?? 'No reason provided',
          timestamp: data['timestamp'] ?? Timestamp.now(),
        );
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (e) {
      print('Error fetching document: $e');
      return null;
    }
  }

  //UPDATE: Update book details
  Future<void> updateBook(Book book, String docID) {
    return books.doc(docID).update({
      'title': book.title,
      'author': book.author,
      'stored': book.storedLocation,
      'boughtLocation': book.boughtLocation,
      'timeBought': book.dateBought,
      'price': book.price,
      'reasonBought': book.reasonBought,
      'timestamp': book.timestamp
    });
  }
}
