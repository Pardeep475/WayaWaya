class VenueProfileTable{

  static final VenueProfileTable _venueProfileTable = VenueProfileTable._internal();

  factory VenueProfileTable() {
    return _venueProfileTable;
  }

  VenueProfileTable._internal();
  
   static final String TABLE_NAME_VENUE_PROFILE = "venue_profile";
   static final String COLUMN_NAME = "name";
   static final String COLUMN_LABEL = "label";
   static final String COLUMN_KEY = "key";
   static final String COLUMN_IDENTIFIER = "identifier";
   static final String COLUMN_DB_NAME = "db_name";
   static final String COLUMN_GEOFENCE = "geofence";
   static final String COLUMN_LOGO_BASE64 = "logo_base64";
   static final String COLUMN_IBEACON_UUID = "ibeacon_uuid";
   static final String COLUMN_DEFAULT = "active";
   static final String COLUMN_DATA = "venue_data";

   static final String CREATE =
      "CREATE TABLE " + TABLE_NAME_VENUE_PROFILE + " (" +
          COLUMN_IDENTIFIER + " TEXT PRIMARY KEY, " +
          COLUMN_NAME + " TEXT NOT NULL, " +
          COLUMN_LABEL + " TEXT NOT NULL, " +
          COLUMN_KEY + " TEXT NOT NULL, " +
          COLUMN_LOGO_BASE64 + " TEXT NOT NULL, " +
          COLUMN_DB_NAME + " TEXT, " +
          COLUMN_GEOFENCE + " TEXT, " +
          COLUMN_DEFAULT + " INTEGER, " +
          COLUMN_IBEACON_UUID + " TEXT, " +
          COLUMN_DATA + " TEXT" +
          " ); ";
}