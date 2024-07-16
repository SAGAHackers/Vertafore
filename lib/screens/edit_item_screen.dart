import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../models/item.dart';

class EditItemScreen extends StatelessWidget {
  final int index;
  final Item item;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  EditItemScreen({required this.index, required this.item}) {
    _nameController.text = item.name;
    _descriptionController.text = item.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedItem = Item(
                      name: _nameController.text,
                      description: _descriptionController.text,
                    );
                    Provider.of<ItemProvider>(context, listen: false).updateItem(index, updatedItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item updated successfully')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Update Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}