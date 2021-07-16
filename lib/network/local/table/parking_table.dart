import 'package:sqflite/sqflite.dart';

class ParkingTable {
  static final ParkingTable _parkingTable = ParkingTable._internal();

  factory ParkingTable() {
    return _parkingTable;
  }

  ParkingTable._internal();

  static final String PARKING_TABLE_NAME = "parking";
  static final String COLUMN_ID = "order_id";
  static final String COLUMN_ORDER_DATE = "order_date";
  static final String COLUMN_PAYMENT_STATUS = "payment_status";
  static final String COLUMN_STATUS_MESSAGE = "status_message";
  static final String COLUMN_PAYABLE_AMOUNT = "payable_amount";
  static final String COLUMN_GATE = "gate";
  static final String COLUMN_IS_ENTRY_DATA = "is_entry_data";
  static final String COLUMN_ENTRY_TIME = "entry_time";
  static final String COLUMN_EXIT_TIME = "exit_time";
  static final String COLUMN_TICKET_NUMBER = "ticket_number";
  static final String COLUMN_PAYMENT_STATE = "payment_state";

  static Future parkingCreateTable({Database db, int version}) async {
    final String createTable = "CREATE TABLE " +
        PARKING_TABLE_NAME +
        " (" +
        COLUMN_ID +
        " TEXT , " +
        COLUMN_ORDER_DATE +
        " TEXT,  " +
        COLUMN_PAYMENT_STATUS +
        " INTEGER,  " +
        COLUMN_STATUS_MESSAGE +
        " TEXT,  " +
        COLUMN_PAYABLE_AMOUNT +
        " REAL,  " +
        COLUMN_GATE +
        " TEXT,  " +
        COLUMN_IS_ENTRY_DATA +
        " INTEGER,  " +
        COLUMN_ENTRY_TIME +
        " TEXT,  " +
        COLUMN_EXIT_TIME +
        " TEXT,  " +
        COLUMN_PAYMENT_STATE +
        " INTEGER,  " +
        COLUMN_TICKET_NUMBER +
        " INTEGER  " +
        " ); ";
    await db.execute(createTable);
  }

  static Future<int> parkingTableLength({Database db}) async {
    (await db.query('sqlite_master', columns: ['type', 'name'])).forEach((row) {
      print(row.values);
    });

    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $PARKING_TABLE_NAME'));
    return count;
  }

  static Future<int> insertParkingTable(
      {Database db, Map<String, dynamic> row}) async {
    return await db.insert(PARKING_TABLE_NAME, row);
  }
}
