import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTasbeehPopup extends StatefulWidget {
  final String tasbeehName;

  EditTasbeehPopup({required this.tasbeehName});

  @override
  _EditTasbeehPopupState createState() => _EditTasbeehPopupState();
}

class _EditTasbeehPopupState extends State<EditTasbeehPopup> {
  TextEditingController _tasbeehNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tasbeehNameController.text = widget.tasbeehName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tasbeeh Popup'),
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
                editTasbeeh(widget.tasbeehName, _tasbeehNameController.text);
                Navigator.pop(context);
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> editTasbeeh(String oldTasbeehName, String newTasbeehName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasbeehs = prefs.getStringList('tasbeehs') ?? [];
    int index = tasbeehs.indexOf(oldTasbeehName);
    if (index != -1) {
      tasbeehs[index] = newTasbeehName;
      prefs.setStringList('tasbeehs', tasbeehs);
    }
  }

  @override
  void dispose() {
    _tasbeehNameController.dispose();
    super.dispose();
  }
}
