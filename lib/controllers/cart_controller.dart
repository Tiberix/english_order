import 'package:english_order/models/product.dart';
import 'package:english_order/models/product_item.dart';
import 'package:flutter/material.dart';

enum HomeState { normal, cart }

int _quantity = 1;
int _currentTable = 1;
List<ProductItem> _productList = [];
List<ProductItem> cart() =>
    _productList.where((element) => element.table == _currentTable).toList();
int totalCartItems() => cart()
    .fold(0, (previousValue, element) => previousValue + element.quantity);
double totalCartPrice() => cart().fold(
    0,
    (previousValue, element) =>
        previousValue + element.price * element.quantity);

class CartController extends ChangeNotifier {
  HomeState homeState = HomeState.normal;

//Setter
  void changeHomeState(HomeState state) {
    homeState = state;
    notifyListeners();
  }

  void deleteProdukt(String name) {
    _productList.removeWhere((element) =>
        element.product!.title == name && element.table == _currentTable);
    notifyListeners();
  }

  void checkOut() {
    _productList.removeWhere((element) => element.table == _currentTable);
    notifyListeners();
  }

  void changeTisch(int neu) {
    _currentTable = neu;
  }

  void setQunatity(int neu) {
    _quantity = neu;
  }

  void addProductToCart(Product product) {
    for (ProductItem item in cart()) {
      if (item.product!.title == product.title) {
        item.quantity = item.quantity + _quantity;
        notifyListeners();
        return;
      }
    }
    _productList.add(ProductItem(
        product: product,
        price: product.preis,
        table: _currentTable,
        quantity: _quantity));
    notifyListeners();
  }
  //Getter

  int getTischNr() {
    return _currentTable;
  }

  int getAnzBest(int tischnr) {
    List<ProductItem> tisch = getTischList(tischnr);
    return tisch.fold(
        0, (previousValue, element) => previousValue + element.quantity);
  }

  List<ProductItem> getTischList(int id) {
    return _productList.where((element) => element.table == id).toList();
  }
}
