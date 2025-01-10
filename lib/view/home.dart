import 'package:book_tracker_app/components/home_card.dart';
import 'package:book_tracker_app/view/add_book.dart';
import 'package:flutter/material.dart';

import '../components/text_field.dart';
import 'view_library.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Hi User!",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFieldComponent(
                  label: "Search book in the library...",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 cards per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: 2, // For now, we have 2 cards
                  itemBuilder: (context, index) {
                    // Use the HomeCard widget from home_card.dart
                    if (index == 1) {
                      return HomeCard(
                        icon: Icons.add,
                        description: "Add Book",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddBook()),
                          );
                        },
                      );
                    } else {
                      return HomeCard(
                        icon: Icons.shelves,
                        description: "View Library",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewLibrary()),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
