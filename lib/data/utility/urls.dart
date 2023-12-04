import 'package:task_manager_project/ui/widgets/task_item_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static String getNewTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getCompletedTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getInProgressTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCancelledTasks =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static String varifyEmail(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';

  static const String updateProfile = '$_baseUrl/profileUpdate';
  
  static const String resetPassword = '$_baseUrl/RecoverResetPass';

  static String verifyPin(String email, String pin) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$pin';
  

}
