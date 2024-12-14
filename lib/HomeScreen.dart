import 'package:flutter/material.dart';
import 'LocationPage.dart';
import 'CartModel.dart';
import 'Produk.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Homescreene());
}

class Homescreene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static CartModel cartModel = CartModel();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Halaman default
  List<Produk> globalCart = []; // Keranjang produk

  void saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = globalCart
        .map((product) => {
              'image': product.image,
              'name': product.name,
              'price': product.price,
              'description': product.description,
              'quantity': product.quantity,
            })
        .toList();
    prefs.setString('cartItems', jsonEncode(cartData));
  }

  // void loadCartFromPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final cartData = prefs.getString('cart');
  //   if (cartData != null) {
  //     final List<dynamic> decodedData = jsonDecode(cartData);
  //     setState(() {
  //       globalCart = decodedData
  //           .map((item) => Produk(
  //                 image: item['image'],
  //                 name: item['name'],
  //                 price: item['price'],
  //                 description: item['description'],
  //               ))
  //           .toList();
  //     });
  //   }
  // }

  void loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartItems');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      globalCart = decodedData
          .map((item) => Produk(
                image: item['image'],
                name: item['name'],
                price: item['price'],
                description: item['description'],
                quantity: item['quantity'] ?? 1,
              ))
          .toList();

      // Print each product to the console
      for (var product in globalCart) {
        print(
            'Produkaaa: ${product.name}, Harga: ${product.price}, Jumlah: ${product.quantity}');
      }
    }
  }

  void addProdukToCart(Produk product) {
    setState(() {
      globalCart.add(product);
      saveCartToPreferences(); // Simpan keranjang ke SharedPreferences
      _currentIndex = 4; // Pindahkan ke halaman CartPage
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    loadCartFromPreferences(); // Memuat keranjang dari SharedPreferences

    _pages = [
      FoodPage(),
      DrinksPage(),
      Homepage(),
      LocationPage(),
      CartPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.grey[900],
          unselectedItemColor: Colors.grey[700],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Makanan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink),
              label: 'Minuman',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Lokasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      print('Error in HomeScreen: $e');
      print(stackTrace);
      return Center(
        child: Text('Terjadi kesalahan.'),
      );
    }
  }
}

class Product {
  final String image;
  final String title;
  final String price;
  final String type;

  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.type,
  });
}

class Homepage extends StatelessWidget {
  final List<Product> products = [
    Product(
      image: 'assets/images/produk/cilok.png',
      title: 'Cilok Crispy',
      price: 'Rp 5.000',
      type: 'food', // Jenis makanan
    ),
    Product(
      image: 'assets/images/produk/makanan/makaronipedas.png',
      title: 'Makaroni Pedas',
      price: 'Rp 3.000',
      type: 'food', // Jenis minuman
    ),
    Product(
      image: 'assets/images/produk/oriental.png',
      title: 'Oriental',
      price: 'Rp 8.000',
      type: 'drink', // Jenis minuman
    ),
    // Tambahkan produk lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xFFFD9A7), // Warna latar belakang drawer
          child: Column(
            children: [
              // Header dengan informasi pengguna
              Container(
                color: Color(0xFFFF6F61),
                padding: EdgeInsets.only(top: 40, left: 16, bottom: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.orange),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '0854321++',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // List menu
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.black),
                      title: Text('Settings'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle, color: Colors.black),
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'For more information, check Instagram:',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt, color: Colors.purple),
                      title: Text(
                        'NikiNiku_FoodDrink',
                        style: TextStyle(color: Colors.purple),
                      ),
                      onTap: () {
                        // Logika untuk membuka Instagram
                      },
                    ),
                  ],
                ),
              ),
              // Tombol logout
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // Tidak ada radius pada tombol
                    ),
                  ),
                  child: Text('Log out'),
                  onPressed: () {
                    // Logika untuk logout
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFA17A), Color(0xFFFF6F61)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: 0.3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/produk/heroSection1.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Blessed Friday",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF611B00),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "BUY ONE CRISPY CILOK",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Orlega",
                            ),
                          ),
                          Text(
                            "FREE SNACKS",
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF611B00),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Inter",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Product Section
              Text(
                "Product",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 16),

              // Menampilkan daftar produk secara horizontal
              Container(
                height:
                    300, // Pastikan kita memberikan ukuran tetap pada container
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ProductCard(
                        image: product.image,
                        title: product.title,
                        price: product.price,
                        onOrderNow: () {
                          if (product.type == 'food') {
                            final state = context
                                .findAncestorStateOfType<_HomeScreenState>();
                            if (state != null) {
                              state.setState(() {
                                state._currentIndex = 0;
                              });
                            }
                          } else if (product.type == 'drink') {
                            final state = context
                                .findAncestorStateOfType<_HomeScreenState>();
                            if (state != null) {
                              state.setState(() {
                                state._currentIndex = 1;
                              });
                            }
                          }
                        },
                      ),
                    );
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

class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback onOrderNow;

  const ProductCard({
    required this.image,
    required this.title,
    required this.price,
    required this.onOrderNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Setting fixed width to avoid overflow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFA17A),
            Color(0xFFFCA469),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Image Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 150, // Reducing the image width to fit in the card
                height: 150, // Ensuring image aspect ratio
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Title Section
          Container(
            width: double.infinity, // Membuat lebar container 100%
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    price,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: onOrderNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: Text(
                      "Order Now",
                      style: TextStyle(
                        color: Color(0xFFFCA469),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrinksPage extends StatefulWidget {
  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  final List<Produk> drinks = [
    Produk(
      image: 'assets/images/produk/minuman/minuman1.png',
      name: 'Oriental',
      price: 8000,
      description: 'drink',
      quantity: 1,
    ),
    Produk(
      image: 'assets/images/produk/minuman/minuman1.png',
      name: 'Oriental 2',
      price: 8000,
      description: 'drink',
      quantity: 1,
    ),
    Produk(
      image: 'assets/images/produk/minuman/minuman1.png',
      name: 'Oriental 3',
      price: 8000,
      description: 'drink',
      quantity: 1,
    ),
  ];

  final cartModel = HomeScreen.cartModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Minuman",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 300, // Set fixed height for horizontal list
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: drinks.length,
                  itemBuilder: (context, index) {
                    final drink = drinks[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFD9A73),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                      child: Image.network(
                                        drink.image,
                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      drink.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      toRupiah(drink.price),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  final state = context.findAncestorStateOfType<
                                      _HomeScreenState>();
                                  if (state != null) {
                                    state.addProdukToCart(drink);
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
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

String toRupiah(double value) {
  return 'Rp. ' +
      value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.');
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Produk> cartItems = [];

  Future<void> loadCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cartItems');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      setState(() {
        cartItems = decodedData.map((item) => Produk.fromMap(item)).toList();
      });
    }
  }

  Future<void> saveCartToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartItems.map((item) => item.toMap()).toList();
    prefs.setString('cartItems', jsonEncode(cartData));
  }

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
    saveCartToPreferences();
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
    });
    saveCartToPreferences();
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
    saveCartToPreferences();
  }

  double calculateTotalPrice() {
    return cartItems.fold(
        0.0, (total, item) => total + (item.price * item.quantity));
  }

  @override
  void initState() {
    super.initState();
    loadCartFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cartItems[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: ${toRupiah(product.price)}'),
                              Text('Quantity: ${product.quantity}'),
                              Text(
                                'Total: ${toRupiah(product.price * product.quantity)}',
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => decrementQuantity(index),
                              ),
                              Text(product.quantity.toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () => incrementQuantity(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.orangeAccent,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Price:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${toRupiah(calculateTotalPrice())}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CheckoutPage(cartItems: cartItems)),
                          );
                        },
                        child: Text('Proceed to Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final List<Produk> cartItems;

  CheckoutPage({required this.cartItems});

  Future<void> clearCartFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    final TextEditingController instructionsController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity: ${product.quantity}'),
                        Text(toRupiah(product.price * product.quantity)),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Your Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: instructionsController,
              decoration: InputDecoration(
                labelText: 'Order Instructions',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${toRupiah(cartItems.fold(0.0, (total, item) => total + item.price * item.quantity))}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    final address = addressController.text;
                    final instructions = instructionsController.text;

                    if (address.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter your address')),
                      );
                    } else {
                      // Simulate order placement
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Order placed successfully!')),
                      );

                      clearCartFromPreferences();

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => CheckoutSuccessPage(),
                        ),
                      );
                    }
                  },
                  child: Text('Place Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final List<Produk> drinks = [
    Produk(
      image: 'assets/images/produk/cilok.png',
      name: 'Cilok Crispy',
      price: 5000,
      description: 'food',
    ),
    Produk(
      image: 'assets/images/produk/makanan/stikbawang.png',
      name: 'Stick Bawang',
      price: 5000,
      description: 'drink',
    ),
    Produk(
      image: 'assets/images/produk/makanan/makaroni.png',
      name: 'Makaroni Pedas',
      price: 5000,
      description: 'food',
    ),
  ];

  final cartModel = HomeScreen.cartModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Minuman",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 300, // Set fixed height for horizontal list
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: drinks.length,
                  itemBuilder: (context, index) {
                    final drink = drinks[index];
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFFD9A73),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.35),
                                      ),
                                      child: Image.network(
                                        drink.image,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      drink.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      toRupiah(drink.price),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[700],
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  final state = context.findAncestorStateOfType<
                                      _HomeScreenState>();
                                  if (state != null) {
                                    state.addProdukToCart(drink);
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    color: Colors.white,
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
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

class CheckoutSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Payment Successful!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Thank you for your order. Your payment was successful.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigasi ke halaman utama
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Back to Home',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
