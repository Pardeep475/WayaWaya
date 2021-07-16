import 'package:sqflite/sqflite.dart';

class EventTable{

  static final EventTable _eventTable = EventTable._internal();

  factory EventTable() {
    return _eventTable;
  }

  EventTable._internal();


   static final String EVENT_TABLE_NAME = "event";

   static final String COLUMN_NAME = "name";
   static final String COLUMN_DESCRIPTION = "description";
   static final String COLUMN_URL = "url";
   static final String COLUMN_LASTDATE = "last_date";
   static final String COLUMN_TIMING = "timing";
   static final String COLUMN_LOCATION = "location";
   static final String COLUMN_START_DATE = "start_date";
   static final String COLUMN_END_DATE = "end_date";
   static final String COLUMN_SHARES = "coupon";
   static final String COLUMN_VIEWS = "likes";

   static Future eventCreateTable(
       {Database db, int version}) async {
      final String createTable =
         "CREATE TABLE " + EVENT_TABLE_NAME + " (" +
             COLUMN_NAME + " TEXT PRIMARY KEY, " +
             COLUMN_DESCRIPTION + " TEXT NOT NULL, " +
             COLUMN_URL + " TEXT NOT NULL, " +
             COLUMN_LASTDATE + " TEXT NOT NULL, " +
             COLUMN_TIMING + " TEXT NOT NULL, " +
             COLUMN_LOCATION + " TEXT NOT NULL, " +
             COLUMN_START_DATE + " INTEGER NOT NULL, " +
             COLUMN_END_DATE + " INTEGER NOT NULL, " +
             COLUMN_SHARES + " TEXT, " +
             COLUMN_VIEWS + " TEXT" +
             " ); ";

     await db.execute(createTable);
   }

   static Future<int> eventTableLength({Database db}) async {
     (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
       print(row.values);
     });

     int count = Sqflite.firstIntValue(await db
         .rawQuery('SELECT COUNT(*) FROM $EVENT_TABLE_NAME'));
     return count;
   }

   static Future<int> insertEventTable(
       {Database db, Map<String, dynamic> row}) async {
     return await db.insert(EVENT_TABLE_NAME, row);
   }

}