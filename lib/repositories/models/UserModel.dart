import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  //Фамилия
  final String lastName;

  //Имя
  final String firstName; //Имя

  //Номер телефона
  final String? email;

  //Пароль
  final String password;

  //Номер корпуса
  final int numberHouse;

  //Номер комнаты
  final int numberRoom;

  bool isAdmin = false;

  UserModel(this.lastName, this.firstName, this.email, this.password, this.numberHouse, this.numberRoom, {this.isAdmin=false});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      data['lastName'],
      data['firstName'],
      data['email'],
      data['password'],
      data['numberHouse'],
        data['numberRoom']
    );
  }
}

/*
class StudentModel extends UserModel{


  StudentModel(super.lastName, super.firstName, super.numberPhone, super.password, super.numberHouse, this.numberRoom);
}*/