abstract class ITasksDataManager {
  Future createTask(String data, Map<int, String> tasks, String id);
  Future updateTask(Map<int, String> tasks, String id);
  Future deleteTask(int innerIndex, Map<int, String> tasks, String id);
  Future moveTask(Map<int, String> oldTasks, String oldId, Map<int, String> newTasks, String newId);
}