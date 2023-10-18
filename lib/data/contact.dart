import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnPhone = 'phone';

  // make this a singleton class
  // Singleton pattern
  static final DatabaseHelper _DatabaseHelper = DatabaseHelper._internal();
  factory DatabaseHelper() => _DatabaseHelper;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'Safety.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store Contacts
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {Contacts} TABLE statement on the database.
    await db.execute('CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, phone TEXT)');

  }
  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  // Define a function that inserts Contacts into the database
  // Future<void> insertContact(Contact contact) async {
  //   // Get a reference to the database.
  //   final db = await _DatabaseHelper.database;
  //
  //   // Insert the Contact into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same Contact is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'contacts',
  //     contact.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
  //
  // // A method that retrieves all the Contacts from the Contacts table.
  // Future<List<Contact>> contacts() async {
  //   // Get a reference to the database.
  //   final db = await _DatabaseHelper.database;
  //
  //   // Query the table for all the Contacts.
  //   final List<Map<String, dynamic>> maps = await db.query('contacts');
  //
  //   // Convert the List<Map<String, dynamic> into a List<Contact>.
  //   return List.generate(maps.length, (index) => Contact.fromMap(maps[index]));
  // }
  //
  // Future<Contact> contact(int id) async {
  //   final db = await _DatabaseHelper.database;
  //   final List<Map<String, dynamic>> maps =
  //   await db.query('contacts', where: 'id = ?', whereArgs: [id]);
  //   return Contact.fromMap(maps[0]);
  // }
  //
  // // A method that updates a Contact data from the Contacts table.
  // Future<void> updateContact(Contact contact) async {
  //   // Get a reference to the database.
  //   final db = await _DatabaseHelper.database;
  //
  //   // Update the given Contact
  //   await db.update(
  //     'contacts',
  //     contact.toMap(),
  //     // Ensure that the Contact has a matching id.
  //     where: 'id = ?',
  //     // Pass the Contact's id as a whereArg to prevent SQL injection.
  //     whereArgs: [contact.id],
  //   );
  // }
  //
  // // A method that deletes a Contact data from the Contacts table.
  // Future<void> deleteContact(int id) async {
  //   // Get a reference to the database.
  //   final db = await _DatabaseHelper.database;
  //
  //   // Remove the Contact from the database.
  //   await db.delete(
  //     'contacts',
  //     // Use a `where` clause to delete a specific Contact.
  //     where: 'id = ?',
  //     // Pass the Contact's id as a whereArg to prevent SQL injection.
  //     whereArgs: [id],
  //   );
  // }
}

