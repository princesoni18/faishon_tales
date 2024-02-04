import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:fashion_tales/controllers/services/auth_service.dart';
import 'package:fashion_tales/utils/image_picker.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {

    on<SelectImageEvent>(selectImageEvent);
    on<CreateUser>(createUser);
    
  }

  FutureOr<void> selectImageEvent(SelectImageEvent event, Emitter<RegisterState> emit) async{
  
    {
  Uint8List img = await pickImage(ImageSource.gallery);
  

  emit(SelectedImageState(file: img));

  return ;
  }

    
  }



  FutureOr<void> createUser(CreateUser event, Emitter<RegisterState> emit)async {

    print("create user called");
   
    String response="";

    try{
       response=await AuthService().CreateUser(event.email, event.name, event.password, event.file);
       print(response);
       
    
    }
    catch(e){

      response=e.toString();
    }
   if(response!="success"){
    emit(ShowInfo(content: response));
   }  
   else{
    emit(RegisterSuccessState());
   }
  }
}
