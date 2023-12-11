import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vuzexam/db/database.dart';
import 'package:vuzexam/model/data_model.dart';

class DataCubit extends Cubit<List<Data>>{
  DataCubit() : super([]);

  void addData(List<Data> tempData){
    return emit(state + tempData);
  }

  void deleteData(){
    return emit(const []);
  }

  void putData(List<Data> tempData) async {
    try{
        var res = await DataDatabase.instance.readAllData();
        if(res.isEmpty){
          tempData.forEach((value) {
            final data = Data(id: value.id, name: value.name, localizedName: value.localizedName, primaryAttr: value.primaryAttr, attackType: value.attackType, roles: value.roles, legs: value.legs, image: value.image);
            DataDatabase.instance.create(data);
          });
        }
      }
    catch (e){
          tempData.forEach((value) {
            final data = Data(id: value.id, name: value.name, localizedName: value.localizedName, primaryAttr: value.primaryAttr, attackType: value.attackType, roles: value.roles, legs: value.legs, image: value.image);
            DataDatabase.instance.create(data);
          });
    }
    return emit(tempData);
    }
  }