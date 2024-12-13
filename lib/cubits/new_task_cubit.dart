import 'package:flutter_bloc/flutter_bloc.dart';

class NewTaskCubit extends Cubit<List<Map<String, dynamic>>> {
  NewTaskCubit() : super([]);
  void addNewTask(String title, bool isCompleted) {
    emit([
      ...state,
      {"title": title, "isCompleted": isCompleted}
    ]);
  }

  void toggleState(int index) {
    final list = List<Map<String, dynamic>>.from(state);
    list[index]['isCompleted'] = !list[index]['isCompleted'];
    emit(list);
  }

  
}
