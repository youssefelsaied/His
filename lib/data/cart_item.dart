// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

class CartItem {
  CartItem({
    required this.count,
    required this.item,
  });

  int count;
  dynamic item;
}
