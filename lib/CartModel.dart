import 'Produk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel {
  List<Produk> cartItems = [];

  // Menyimpan keranjang ke SharedPreferences
  Future<void> saveCartToLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        cartItems.map((product) => product.toJson()).toList();
    await prefs.setStringList('cartItems', cartJson);
  }

  // Memuat keranjang dari SharedPreferences
  Future<void> loadCartFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cartItems');
    if (cartJson != null) {
      cartItems = cartJson.map((item) => Produk.fromJson(item)).toList();
    }
  }

  // Menambahkan produk ke dalam cartItems dan menyimpannya
  void addToCart(Produk product) {
    cartItems.add(product);
    saveCartToLocal(); // Menyimpan setelah penambahan
  }

  // Menghapus produk dari cartItems dan menyimpannya
  void removeFromCart(Produk product) {
    cartItems.remove(product);
    saveCartToLocal(); // Menyimpan setelah penghapusan
  }
}
