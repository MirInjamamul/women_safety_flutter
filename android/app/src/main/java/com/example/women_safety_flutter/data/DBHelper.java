package com.example.women_safety_flutter.data;

import android.annotation.SuppressLint;
import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.DatabaseUtils;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

import java.util.ArrayList;
import java.util.HashMap;

public class DBHelper extends SQLiteOpenHelper {

    public static final String DATABASE_NAME = "Safety.db";
    public static final String CONTACTS_TABLE_NAME = "contacts";
    public static final String CONTACTS_COLUMN_NAME = "name";
    public static final String CONTACTS_COLUMN_PHONE = "phone";
    private HashMap hp;

    public DBHelper(Context context){
        super(context,DATABASE_NAME,null,1);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        sqLiteDatabase.execSQL(
                "create table contacts " +
                        "(id integer primary key, name text,phone text)"
        );
        sqLiteDatabase.execSQL(
                "create table auth " +
                        "(id integer primary key, name text,email text,phone text,password text)"
        );

        sqLiteDatabase.execSQL(
                "create table status " +
                        "(id integer primary key, loggedInStatus boolean)"
        );
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS contacts");
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS auth");
        sqLiteDatabase.execSQL("DROP TABLE IF EXISTS status");
        onCreate(sqLiteDatabase);
    }

    public boolean insertContact (String name, String phone) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", name);
        contentValues.put("phone", phone);
        db.insert("contacts", null, contentValues);
        return true;
    }

    public boolean insertSignUp (String name, String email, String phone, String password) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", name);
        contentValues.put("email", email);
        contentValues.put("phone", phone);
        contentValues.put("password", password);
        db.insert("auth", null, contentValues);
        return true;
    }

    public boolean insertStatus(Boolean s) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("loggedInStatus", s);
        Cursor res =  db.rawQuery( "select * from status", null );
        System.out.println("Get Count insert "+ res.getCount());
        if(res.getCount() == 0)
            db.insert("status", null, contentValues);
        else
            db.update("status", contentValues, "id = ? ", new String[] { Integer.toString(1) } );
        return true;
    }

    public Boolean getStatus() {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "select * from status", null );
        res.moveToFirst();
        Boolean status = false;
        System.out.println("Get Count get "+ res.getCount());
        if(res.getCount()< 1){
            status = false;
        }
        else{
            @SuppressLint("Range") String val = res.getString(res.getColumnIndex("loggedInStatus"));
            if(val.equals("1")){
                System.out.println(true);
                status = true;
            }
            else{
                System.out.println(false);
                status = false;
            }
        }
        return status;
    }

    public boolean updateContact (Integer id, String name, String phone, String email, String street,String place, String category) {
        SQLiteDatabase db = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", name);
        contentValues.put("phone", phone);
        contentValues.put("email", email);
        contentValues.put("street", street);
        contentValues.put("place", place);
        contentValues.put("category", category);
        db.update("contacts", contentValues, "id = ? ", new String[] { Integer.toString(id) } );
        return true;
    }

    public Integer deleteContact (Integer id) {
        SQLiteDatabase db = this.getWritableDatabase();
        return db.delete("contacts",
                "id = ? ",
                new String[] { Integer.toString(id) });
    }

    @SuppressLint("Range")
    public ArrayList<String> getAllCotacts() {
        ArrayList<String> array_list = new ArrayList<String>();

        //hp = new HashMap();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "select * from contacts", null );
        res.moveToFirst();

        while(res.isAfterLast() == false){
            array_list.add(res.getString(res.getColumnIndex(CONTACTS_COLUMN_NAME)));
            res.moveToNext();
        }
        return array_list;
    }

    @SuppressLint("Range")
    public ArrayList<String> getAllCotactsNumber() {
        ArrayList<String> array_list = new ArrayList<String>();

        //hp = new HashMap();
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "select * from contacts", null );
        res.moveToFirst();

        while(res.isAfterLast() == false){
            array_list.add(res.getString(res.getColumnIndex(CONTACTS_COLUMN_PHONE)));
            res.moveToNext();
        }
        return array_list;
    }

    public Cursor getData(int id) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "select * from contacts where id="+id+"", null );
        return res;
    }

    @SuppressLint("Range")
    public boolean getAuthData(String email , String password) {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor res =  db.rawQuery( "select * from auth", null );

        String db_email = "asdrew";
        String db_password = "asdasdas";

        res.moveToFirst();

        while(res.isAfterLast() == false){
            db_email = res.getString(res.getColumnIndex("email"));
            db_password = res.getString(res.getColumnIndex("password"));
            break;
        }

        if(db_email.equals(email) && db_password.equals(password))
            return true;
        else
            return false;
    }

    public int numberOfRows(){
        SQLiteDatabase db = this.getReadableDatabase();
        int numRows = (int) DatabaseUtils.queryNumEntries(db, CONTACTS_TABLE_NAME);
        return numRows;
    }
}
