import 'package:flutter/material.dart';

// 1) A simple Model Class for Snacks
class SnackItem {
  final String name;
  final double price;

  SnackItem({required this.name, required this.price});
}
// 2) Mock list of snacks (used in the Snack List Screen)
final List<SnackItem> allSnacks = [
  SnackItem(name: 'Chocolate Bar', price: 1.50),
  SnackItem(name: 'Potato Chips', price: 2.00),
  SnackItem(name: 'Gummy Bears', price: 1.25),
  SnackItem(name: 'Pretzels', price: 1.75),
];
// 3) A global cart to keep this demo simple (just a list of SnackItem)
List<SnackItem> cart = [];
void main() {
  runApp(MyApp());
}
// A helper widget to give each screen a blue-yellow gradient background
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(

          colors: [Colors.blue, Colors.yellowAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // Place the content inside a SafeArea + Padding so it doesn't clash with system bars
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order My Snacks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Make app bar a bit more distinct
        appBarTheme: AppBarTheme(
          color: Colors.blue.shade800,
          foregroundColor: Colors.white, // Text color on the AppBar
        ),
        // Style for elevated buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow.shade700,
            foregroundColor: Colors.black, // Text color
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/snacks': (context) => SnackListScreen(),
        '/cart': (context) => CartScreen(),
        '/checkout': (context) => CheckoutScreen(),
        '/confirmation': (context) => ConfirmationScreen(),
      },
    );
  }
}
//-----------------------------------
//  HOME SCREEN
//-----------------------------------
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order My Snacks'),
        centerTitle: true,
      ),
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // A GestureDetector on an image (optional)
              GestureDetector(
                onTap: () {
                  // Example action when tapping the image
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You tapped the image!')),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  width: 150,
                  height: 150,
                  // A playful placeholder: an icon inside a Container
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.fastfood, size: 64, color: Colors.black87),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Start Ordering'),
                onPressed: () {
                  Navigator.pushNamed(context, '/snacks');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//-----------------------------------
//  SNACK LIST SCREEN
//-----------------------------------
class SnackListScreen extends StatefulWidget {
  @override
  _SnackListScreenState createState() => _SnackListScreenState();
}
class _SnackListScreenState extends State<SnackListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Snacks'),
        centerTitle: true,
        actions: [
          // Cart button on top-right
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: GradientBackground(
        child: ListView.builder(
          itemCount: allSnacks.length,
          itemBuilder: (context, index) {
            final snack = allSnacks[index];
            return Card(
              color: Colors.white.withOpacity(0.8), // Slightly transparent card
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: ListTile(
                title: Text(
                  snack.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('\$${snack.price.toStringAsFixed(2)}'),
                trailing: ElevatedButton(
                  child: Text('Add'),
                  onPressed: () {
                    setState(() {
                      cart.add(snack);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${snack.name} added to cart')),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
//-----------------------------------
//  CART SCREEN
//-----------------------------------
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    double total = 0;
    for (var item in cart) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: GradientBackground(
        child: cart.isEmpty
            ? Center(
          child: Text(
            'Your cart is empty.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final snack = cart[index];
                  return Card(
                    color: Colors.white.withOpacity(0.8),
                    child: ListTile(
                      title: Text(snack.name),
                      subtitle:
                      Text('\$${snack.price.toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Proceed to Checkout'),
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//-----------------------------------
//  CHECKOUT SCREEN
//-----------------------------------
class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        centerTitle: true,
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // For validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle('Full Name'),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!.trim(),
                ),
                SizedBox(height: 16),
                _buildTitle('Address'),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    hintText: 'Enter your address',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Address is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _address = value!.trim(),
                ),
                SizedBox(height: 16),
                _buildTitle('Phone Number'),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    hintText: 'Enter phone number',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone number is required';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                      return 'Enter only numbers';
                    }
                    return null;
                  },
                  onSaved: (value) => _phone = value!.trim(),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      // Validate form fields
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Pass user info to Confirmation screen
                        Navigator.pushNamed(
                          context,
                          '/confirmation',
                          arguments: {
                            'name': _name,
                            'address': _address,
                            'phone': _phone,
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
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
//-----------------------------------
//  CONFIRMATION SCREEN
//-----------------------------------
class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments (user info) passed from Checkout Screen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final name = args['name'] ?? '';
    final address = args['address'] ?? '';
    final phone = args['phone'] ?? '';

    // Calculate total price again
    double total = 0;
    for (var item in cart) {
      total += item.price;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Confirm Your Order'),
          centerTitle: true,
        ),
        body: GradientBackground(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: $name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Address: $address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Phone: $phone',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final snack = cart[index];
                      return Card(
                        color: Colors.white.withOpacity(0.8),
                        child: ListTile(
                          title: Text(snack.name),
                          subtitle: Text('\$${snack.price.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    child: Text('Place Order'),
                    onPressed: () {
                      // Clear the cart
                      cart.clear();
                      // Show a simple success message
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Order Placed!'),
                          content: Text('Thank you, $name. Your snacks are on the way!'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context); // close dialog
                                // Pop all the way back to Home Screen
                                Navigator.popUntil(context, ModalRoute.withName('/'));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
             ),
            );
      }
}import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
