
import 'package:fashion_tales/controllers/services/auth_service.dart';
import 'package:fashion_tales/models/user_model.dart';
import 'package:flutter/material.dart';


class UserProvider with ChangeNotifier{
UserModel? _user;
final AuthService _authMethods=AuthService();
UserModel get  getUser=> _user!;

Future<void> refreshUser()async{
  UserModel user=await _authMethods.getUserDetails();
  _user=user;
  notifyListeners();
}


}