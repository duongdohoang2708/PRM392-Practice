import 'dart:async';
import 'dart:ffi';

class Product{
  int id;
  String name;
  double price;
  Product(this.id, this.name, this.price);
  @override
  String toString(){
    return "Product: id: $id, name: $name, price: $price";
  }
}
class ProductRepository{
  final List<Product> _products = [];
  Future<List<Product>> getAll() async{
    await Future.delayed(Duration(seconds: 1));
    return _products;
  }
  final StreamController<Product> _controller = StreamController<Product>.broadcast();

  Stream<Product> liveAdded(){
    return _controller.stream;
  }

  void addProduct(Product product){
    _products.add(product);
    _controller.add(product);
  }
}
void main() async{
  ProductRepository repository = ProductRepository();
  repository.liveAdded().listen((product) {print("New product added: $product");});

  await Future.delayed(Duration(seconds: 1));
  repository.addProduct(Product(1, "Shoes", 50.5));
  await Future.delayed(Duration(seconds: 1));
  repository.addProduct(Product(2, "Shirt", 21.3));
  await Future.delayed(Duration(seconds: 1));
  repository.addProduct(Product(3, "Watch", 60.2));

  List<Product> products =  await repository.getAll();
  print("LIST PRODUCT:");
  for(Product product in products){
    print(product);
  }
}