import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? title;
  String? author;
  String? storedLocation;
  String? boughtLocation;
  DateTime? dateBought;
  double? price;
  String? reasonBought;
  Timestamp? timestamp;

  Book(
      {this.title,
      this.author,
      this.storedLocation,
      this.boughtLocation,
      this.dateBought,
      this.price,
      this.reasonBought,
      this.timestamp});
}
