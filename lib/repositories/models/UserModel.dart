class UserModel{
  //Фамилия
  final String lastName;

  //Имя
  final String firstName; //Имя

  //Номер телефона
  final String numberPhone;

  //Пароль
  final String password;

  //Номер корпуса
  final int numberHouse;

  //Номер комнаты
  final int? numberRoom;

  bool isAdmin = false;

  UserModel(this.lastName, this.firstName, this.numberPhone, this.password, this.numberHouse, this.numberRoom, {this.isAdmin=false});
}

/*
class StudentModel extends UserModel{


  StudentModel(super.lastName, super.firstName, super.numberPhone, super.password, super.numberHouse, this.numberRoom);
}*/