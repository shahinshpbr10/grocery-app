import 'package:flutter/material.dart';
import 'AddItems.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  void _select(MenuOption option) {
    switch (option) {
      case MenuOption.addItems:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddItemsPage()));
        break;
    // Handle other menu options here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: <Widget>[
          PopupMenuButton<MenuOption>(
            onSelected: _select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOption>>[
              const PopupMenuItem<MenuOption>(
                value: MenuOption.addItems,
                child: Text('Add Items'),
              ),
              // Add more menu options here if needed
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Welcome to the Admin Dashboard', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Use the menu to add or manage items.'),
          ],
        ),
      ),
    );
  }
}

enum MenuOption { addItems }
