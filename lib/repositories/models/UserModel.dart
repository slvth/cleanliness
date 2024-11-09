class UserModel{
  final String lastName; //Фамилия
  final String firstName; //Имя
  final String numberPhone; //Номер телефона
  final String password;
  final int numberHouse; //Пароль
  bool isAdmin = false;
  UserModel(this.lastName, this.firstName, this.numberPhone, this.password, this.numberHouse, {this.isAdmin=false});
}

class StudentModel extends UserModel{//Номер корпуса
  final int numberRoom;

  StudentModel(super.lastName, super.firstName, super.numberPhone, super.password, super.numberHouse, this.numberRoom); //Номер комнаты
}