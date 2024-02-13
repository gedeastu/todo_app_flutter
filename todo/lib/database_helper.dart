class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper()=>_instance;
  static Database?
}