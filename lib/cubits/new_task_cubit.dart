import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewTaskCubit extends Cubit<List<Map<String, dynamic>>> {
  NewTaskCubit() : super([]);
  Future addNewTask(String title, bool isCompleted) async {
    final user = Supabase.instance.client.auth.currentUser;
    final database = Supabase.instance.client.from('tasks');
    emit([
      ...state,
      {"title": title, "isCompleted": isCompleted}
    ]);
    await database.insert(
        {"title": title, "isCompleted": isCompleted, 'user_id': user!.id});
  }

  Future toggleState(int index) async {
    final list = List<Map<String, dynamic>>.from(state);
        final database = Supabase.instance.client.from('tasks');
    list[index]['isCompleted'] = !list[index]['isCompleted'];
    emit(list);
    await database.update({'isCompleted': list[index]['isCompleted']}).eq(
      'id', index + 1 
    );
  }

  void updateState(List<Map<String, dynamic>> list){
    emit(list);
  }
}
