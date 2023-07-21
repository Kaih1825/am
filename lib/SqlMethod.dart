import 'package:sqflite/sqflite.dart';

import 'Screens/TicketsList.dart';

class Ticket {
  Database? database;
  init() async {
    database ??= await openDatabase("db.db", version: 1,
        onUpgrade: (db, oldVersion, newVision) {
      db.execute(
          "CREATE TABLE IF NOT EXISTS ticket (id INTEGER PRIMARY KEY,type TEXT,name TEXT,time TEXT,seat TEXT,image TEXT)");
    });
    return database;
  }

  insert(type, name, time, seat, image) async {
    Database db = await init();
    db.execute(
        "INSERT INTO ticket(type,name,time,seat,image) VALUES('$type','$name','$time','$seat','$image')");
    closingTickets.value = List.from(await Ticket().closing());
    openingTickets.value = List.from(await Ticket().opening());
  }

  opening() async {
    Database db = await init();
    return db.rawQuery(
        "SELECT * FROM ticket WHERE type='Opening Ceremony' ORDER BY id");
  }

  closing() async {
    Database db = await init();
    return db.rawQuery(
        "SELECT * FROM ticket WHERE type='Closing Ceremony' ORDER BY id");
  }

  remove(id) async {
    Database db = await init();
    print(id);
    await db.execute("DELETE FROM ticket WHERE id=$id");
    closingTickets.value = List.from(await Ticket().closing());
    openingTickets.value = List.from(await Ticket().opening());
  }

  removeAll() async {
    Database db = await init();
    await db.execute("DELETE FROM ticket");
  }
}
