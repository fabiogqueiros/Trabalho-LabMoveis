import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> iniciaBanco() async {
  String path = join(await getDatabasesPath(), 'gamesTracker.db');
  const String scriptUser =
      "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL, email VARCHAR NOT NULL, password VARCHAR NOT NULL);";
  const String scriptGenre =
      "CREATE TABLE genre(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR NOT NULL);";
  const String scriptGame =
      "CREATE TABLE game(id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER NOT NULL, name VARCHAR NOT NULL UNIQUE, description TEXT NOT NULL, release_date VARCHAR NOT NULL, FOREIGN KEY(user_id) REFERENCES user(id));";

  return await openDatabase(path, version: 1, onCreate: (db, version) async {
    await db.execute(scriptUser);
    await db.execute(scriptGenre);
    await db.execute(scriptGame);
  });
}