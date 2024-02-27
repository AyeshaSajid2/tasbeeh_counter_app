import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTasbeehPopup extends StatefulWidget {
  @override
  _AddTasbeehPopupState createState() => _AddTasbeehPopupState();
}

class _AddTasbeehPopupState extends State<AddTasbeehPopup> {
  TextEditingController _tasbeehNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tasbeeh Popup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _tasbeehNameController,
              decoration: InputDecoration(
                labelText: 'Tasbeeh Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addTasbeeh(_tasbeehNameController.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTasbeeh(String tasbeehName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasbeehs = prefs.getStringList('tasbeehs') ?? [];
    tasbeehs.add(tasbeehName);
    prefs.setStringList('tasbeehs', tasbeehs);
  }

  @override
  void dispose() {
    _tasbeehNameController.dispose();
    super.dispose();
  }
}
