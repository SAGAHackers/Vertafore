import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  ItemProvider() {
    _loadItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString('items');
    if (itemsString != null) {
      List<dynamic> decodedList = jsonDecode(itemsString);
      _items = decodedList.map((item) => Item.fromMap(item)).toList();
      notifyListeners();
    }
  }

  void addItem(Item item) {
    _items.add(item);
    _saveItems();
    notifyListeners();
  }

  void updateItem(int index, Item item) {
    _items[index] = item;
    _saveItems();
    notifyListeners();
  }

  bool deleteItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      _saveItems();
      notifyListeners();
      return true;
    }
    return false;
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String itemsString = jsonEncode(_items.map((item) => item.toMap()).toList());
    prefs.setString('items', itemsString);
  }
}
