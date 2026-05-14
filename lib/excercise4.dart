//class
class Car{
  //property
  String brand;
  //constructor
  Car(this.brand);
  //named constructor
  Car.electric(this.brand){
    print("$brand is a electric car");
  }
  //method
  void drive(){
    print("$brand is driving");
  }
}
//child class
class ElectricCar extends Car{
  //constructor
  ElectricCar(String brand) : super(brand);
  //override method
  @override
  void drive(){
    print("$brand is drive silently with electricity");
  }
}
void main(){
  Car car1 = new Car("Toyota");
  car1.drive();
  Car car2 = new Car.electric("Vinfast");
  car2.drive();
  ElectricCar electricCar = new ElectricCar("Tesla");
  electricCar.drive();
}