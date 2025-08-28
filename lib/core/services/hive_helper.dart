import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/models/task_model.dart';

class HiveHelper {
  // singelton design pattern  : 1 object from box
  static late Box box;
  static late Box<TaskModel> taskBox;

  static String userImagePath = 'imagePath';
  static String userName = 'name';
  static String isDarkTheme = 'isDarkTheme';

  static String tasksBox = 'tasks';
  static String taskID = 'taskID';
  // static String userName = 'name';

  static init() async {
    await Hive.openBox('userInfo'); // refers to database

    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    await Hive.openBox<TaskModel>(tasksBox); // refers to database

    box = Hive.box('userInfo');
    taskBox = Hive.box(tasksBox);
  }

  static cacheData(String key, dynamic value) async {
    await box.put(key, value);
  }

  static dynamic getData(String key) {
    return box.get(key);
  }

    static void deleteData(String userName) async {
    await box.delete(userName);
    await box.delete(isDarkTheme);
    taskBox.clear();
    }

  static cacheTask(String key, TaskModel task) async{
    await taskBox.put(key, task);
  }

  static dynamic getTask(String key) {
    return taskBox.get(key);
  }

  static Future<void> deleteTask(String id) async {
    await taskBox.delete(id);
  }
  static Future<void> updateTask(TaskModel task) async {
    await taskBox.put(task.id, task);
  }

}
