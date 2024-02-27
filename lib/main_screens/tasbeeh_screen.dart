import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'count_screen.dart'; // Import the CountScreen

class TasbeehScreen extends StatefulWidget {
  @override
  _TasbeehScreenState createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  List<String> myTasbeehs = [];
  TextEditingController tasbeehNameController = TextEditingController();
  TextEditingController tasbeehCountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadMyTasbeehs();
  }

  Future<void> loadMyTasbeehs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myTasbeehs = prefs.getStringList('myTasbeehs') ?? [];
    });
  }

  Future<void> saveMyTasbeehs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('myTasbeehs', myTasbeehs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xffd6a75f),
        title: Text('Tasbeeh Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Tasbeeh:',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xffe1b983),
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: myTasbeehs.map((tasbeeh) {
                  return GestureDetector(
                    onTap: () {
                      _navigateToCountScreen(tasbeeh);
                    },
                    child: _buildTasbeehItem(tasbeeh),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: double.infinity,
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            _showAddTasbeehDialog(context);
          },
          child: Text('Add Tasbeeh', textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
          style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Color(0xffd6a75f)),),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTasbeehItem(String tasbeeh) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffe1b983),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.only(left: 10.0, top: 0.0),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          tasbeeh.split(' (')[0],
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          tasbeeh.split('(')[1].replaceAll(')', ''),
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditTasbeehDialog(context, tasbeeh);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteTasbeeh(tasbeeh);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddTasbeehDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Tasbeeh'),
          content: SizedBox(
            height: 150, // Adjusted height
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tasbeehNameController,
                  decoration: InputDecoration(labelText: 'Tasbeeh Name'),
                ),
                TextField(
                  controller: tasbeehCountController,
                  decoration: InputDecoration(labelText: 'Tasbeeh Count'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String tasbeehName = tasbeehNameController.text.trim();
                String tasbeehCount = tasbeehCountController.text.trim();
                if (tasbeehName.isNotEmpty && tasbeehCount.isNotEmpty) {
                  setState(() {
                    myTasbeehs.insert(0, '$tasbeehName ($tasbeehCount)');
                    saveMyTasbeehs();
                  });
                  tasbeehNameController.clear();
                  tasbeehCountController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe1b983)),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditTasbeehDialog(BuildContext context, String tasbeeh) async {
    tasbeehNameController.text = tasbeeh.split(' (')[0];
    tasbeehCountController.text = tasbeeh.split('(')[1].replaceAll(')', '');
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Tasbeeh'),
          content: SizedBox(
            height: 150, // Set a fixed height for the content area
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: tasbeehNameController,
                  decoration: InputDecoration(labelText: 'Tasbeeh Name'),
                ),
                TextField(
                  controller: tasbeehCountController,
                  decoration: InputDecoration(labelText: 'Tasbeeh Count'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red),),
            ),
            ElevatedButton(
              onPressed: () {
                String newTasbeehName = tasbeehNameController.text.trim();
                String newTasbeehCount = tasbeehCountController.text.trim();
                if (newTasbeehName.isNotEmpty && newTasbeehCount.isNotEmpty) {
                  setState(() {
                    int index = myTasbeehs.indexOf(tasbeeh);
                    myTasbeehs[index] = '$newTasbeehName ($newTasbeehCount)';
                    saveMyTasbeehs();
                  });
                  tasbeehNameController.clear();
                  tasbeehCountController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffe1b983)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteTasbeeh(String tasbeeh) {
    setState(() {
      myTasbeehs.remove(tasbeeh);
      saveMyTasbeehs();
    });
  }

  void _navigateToCountScreen(String tasbeeh) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CountScreen(tasbeehName: tasbeeh.split(' (')[0], tasbeehCount: int.parse(tasbeeh.split('(')[1].replaceAll(')', '')), onCountUpdated: (int ) {  },)),
    );
    if (result != null) {
      setState(() {
        // Update the count for the corresponding tasbeeh in myTasbeehs list if needed
      });
    }
  }

  @override
  void dispose() {
    tasbeehNameController.dispose();
    tasbeehCountController.dispose();
    super.dispose();
  }
}
