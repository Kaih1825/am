import 'package:sqflite/sqflite.dart';

class Ticket {
  Database? database;
  init() async {
    database ??= await openDatabase("db.db", version: 3,
        onUpgrade: (db, oldVersion, newVision) {
      db.execute(
          "CREATE TABLE IF NOT EXISTS ticket (id INTEGER,type TEXT,name TEXT,time TEXT,seat TEXT,image TEXT)");
    });
    return database;
  }

  insert(type, name, time, seat, image) async {
    Database db = await init();
    db.execute(
        "INSERT INTO ticket(type,name,time,seat,image) VALUES('$type','$name','$time','$seat','$image')");
  }

  opening() async {
    Database db = await init();
    return db.rawQuery("SELECT * FROM ticket WHERE type='Opening Ceremony'");
  }

  closing() async {
    Database db = await init();
    return db.rawQuery("SELECT * FROM ticket WHERE type='Closing Ceremony'");
  }
}
