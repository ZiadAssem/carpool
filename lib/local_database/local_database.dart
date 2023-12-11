// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class LocalDatabaseHelper {
//   static Database? _database;
//   static const String _tableName = 'userTable';

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     // If _database is null, instantiate it
//     _database = await initDatabase();
//     return _database!;
//   }

//   Future<Database> initDatabase() async {
//     String path = join(await getDatabasesPath(), 'user_database.db');
//     return await openDatabase(path, version: 1, onCreate: _createTable);
//   }

//   Future<void> _createTable(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $_tableName (
//         email TEXT PRIMARY KEY,
//         name TEXT,
//         phoneNumber TEXT,
//       )
//     ''');
//   }

//   Future<int> insertUser(Map<String, dynamic> user) async {
//     Database db = await database;
//     return await db.insert(_tableName, user);
//   }

//   Future<List<Map<String, dynamic>>> getUsers() async {
//     Database db = await database;
//     return await db.query(_tableName);
//   }

//   //check if user exists
//   Future<bool> checkUser(String email) async {
//     Database db = await database;
//     List<Map<String, dynamic>> users = await db.query(_tableName);
//     for (var user in users) {
//       if (user['email'] == email) {
//         return true;
//       }
//     }
//     return false;
//   }

//   //Function that gets the first user in the database
//   Future<Map<String, dynamic>> getCurrentUser() async {
//     Database db = await database;
//     List<Map<String, dynamic>> users = await db.query(_tableName);
//     if(users.isEmpty){
//       return {'email':'empty','name':'empty','phoneNumber':'empty'};
//     }
//     return users[0];
//   }

//   //Function that checks that db is not empty


//   //Function that deletes all user, then adds new user
//   Future<void> updateUser(Map<String, dynamic> user) async {
//     Database db = await database;
//     await db.delete(_tableName);
//     await db.insert(_tableName, user);
//   }
// }
