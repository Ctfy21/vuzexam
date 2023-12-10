import 'package:flutter_bloc/flutter_bloc.dart';

class DataCubit extends Cubit<List<dynamic>>{
  DataCubit() : super([]);

  void addData(List<dynamic> tempData){
    return emit(state + tempData);
  }

  void deleteData(){
    return emit(const []);
  }

  void putData(List<dynamic> tempData) {
    return emit(tempData);
  }

}