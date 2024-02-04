import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fashion_tales/controllers/services/auth_service.dart';

import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    

    on<LoginUserEvent>(loginUserEvent);
  }

  FutureOr<void> loginUserEvent(LoginUserEvent event, Emitter<LoginState> emit) async{

    emit(LogInProccessState());
    String response="initial";

    try{

      response=await AuthService().LogInUser(event.email, event.password);


    }catch(e){
     
response=e.toString();
    }
    print("this is the response");
print(response);
    if(response=='success'){
      emit(LoginSuccessState());
    }

    else{
       emit(LoginErrorState(content: response));
       await Future.delayed(Duration(seconds: 5));
      emit(LoginInitial());
    }
    
  }
}
