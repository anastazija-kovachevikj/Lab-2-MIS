import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labs2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Clothes App - Index 203060'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> _clothesData = [];

  @override
  void initState() {
    super.initState();
    _clothesData = [
      {'price': '500 ден.', 'name': 'Graphic T-shirt 1', 'imageUrl': 'lib/images/tshirt1.jpg'},
      {'price': '500 ден.', 'name': 'Graphic T-shirt 2', 'imageUrl': 'lib/images/tshirt2.jpg'},
      {'price': '500 ден.', 'name': 'Graphic T-shirt 3', 'imageUrl': 'lib/images/thsirt3.jpg'},
      {'price': '1200 ден.', 'name': 'Printed Hoodie 1', 'imageUrl': 'lib/images/hoodie1.jpg'},
      {'price': '1200 ден.', 'name': 'Printed Hoodie 2', 'imageUrl': 'lib/images/hoodie2.jpg'},
    ];
  }

  void _deleteCard(int index) {
    setState(() {
      _clothesData.removeAt(index);
    });
  }

  Widget _buildClothesCard(String type, String clothesName, String imageUrl, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 10),
                  Text(
                    clothesName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(height: 5),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _editCard(index);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(int.parse('0xFFAAF0D2')),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(int.parse('0xFFB42034')),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _deleteCard(index);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(int.parse('0xFFAAF0D2')),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Color(int.parse('0xFFB42034')),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editCard(int index) {
    final TextEditingController nameController = TextEditingController(text: _clothesData[index]['name']);
    final TextEditingController priceController = TextEditingController(text: _clothesData[index]['price']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _clothesData[index]['name'] = nameController.text;
                  _clothesData[index]['price'] = priceController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _addCard() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _clothesData.add({
                    'name': nameController.text,
                    'price': priceController.text,
                    'imageUrl': 'lib/images/tshirt1.jpg',
                  });
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Clothes App - Index 203060',
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _clothesData.length,
              itemBuilder: (context, index) {
                final clothing = _clothesData[index];
                return _buildClothesCard(
                  clothing['price']!,
                  clothing['name']!,
                  clothing['imageUrl']!,
                  index,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        backgroundColor: Color(int.parse('0xFFAAF0D2')),
        tooltip: 'Add New Item',
        child: Text(
          'Add',
          style: TextStyle(
           color: Color(int.parse('0xFFB42034')),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    );
  }
}
