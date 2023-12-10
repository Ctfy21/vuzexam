import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuzexam/db/database.dart';
import 'package:vuzexam/model/data_model.dart';

class DataCubit extends Cubit<List<dynamic>>{
  DataCubit() : super([]);

  void addData(List<dynamic> tempData){
    return emit(state + tempData);
  }

  void deleteData(){
    return emit(const []);
  }

  void putData(List<dynamic> tempData) {
    // tempData.forEach((value) {
    //   // final data = Data(id: value['id'], name: value['name'], localizedName: value['localized_name'], primaryAttr: value['primary_attr'], attackType: value['attack_type'], roles: value['roles'], legs: value['legs']);
    //   // DataDatabase.instance.create(data);
    // });
    return emit(tempData);
  }

}