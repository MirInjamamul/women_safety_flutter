import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:women_safety_flutter/data/message_model.dart';
import 'package:women_safety_flutter/utils/api_config.dart';

class DatabaseHelper{
  static final DatabaseHelper instance = DatabaseHelper._init();
  Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async{
    if(_database != null) {
      return _database!;
    }

    _database = await _initDB('gypsy.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version)async{
    await db.execute('''
      create table ${ApiConfig.messageTableName}(
      id integer primary key autoincrement,
      messageId integer,
      replyId text,
      name text not null,
      photo text,
      message text,
      lastMessage text,
      isActive boolean not null,
      isSeen boolean not null,
      isMe boolean not null,
      messageType text,
      withUserId text,
      toUserId text,
      mediaUrl text,
      unreadMessageCount integer,
      isRequest boolean,
      isHide boolean,
      isDeleteAccount boolean,
      isBlockedByMe boolean,
      isBlockedByYou boolean,
      createdAt text,
      updatedAt text not null)
    ''');

    await db.execute('''
      create table ${ApiConfig.requestTableName}(
      id integer primary key autoincrement,
      withUserId text,
      createdAt text,
      updatedAt text not null)
    ''');
  }

  Future<void> insert({required MessageModel messageModel})async{
    try{
      final db = await instance.database;

      print(jsonEncode(messageModel));

      db.insert(ApiConfig.messageTableName, messageModel.toJson());
    }catch(e){
      print(e.toString());
    }
  }

  Future<bool> insertRequestData({required RequestModel requestModel})async{
    try{
      final db = await instance.database;

      // Check already existed the userId or Not
      final existingRecordCount = await db.rawQuery(
          'SELECT COUNT(*) FROM ${ApiConfig.requestTableName} WHERE withUserId = ?',
          [requestModel.withUserId]
      );

      if(Sqflite.firstIntValue(existingRecordCount) != null && Sqflite.firstIntValue(existingRecordCount)! > 0){
        return false;
      }


      db.insert(ApiConfig.requestTableName, requestModel.toJson());

      return true;
    }catch(e){
      print(e.toString());

      return false;
    }
  }

  List<MessageModel> messageList = [];
  Future<List<MessageModel>> getMessagesByUserId(String userId,String ownUserId, int pageNumber, int itemPerPage, bool reload)async{
    try{
      final db = await instance.database;
      final offset = ((pageNumber - 1) * itemPerPage);
      final List<Map<String, dynamic>> maps =  await db.query(
        ApiConfig.messageTableName,
        where: 'withUserId = ? AND toUserId = ?',
        whereArgs: [userId, ownUserId],
        orderBy: 'id Desc',
        limit: itemPerPage,
        offset: offset,
      );

      if(reload){
        messageList = [];
      }

      maps.reversed.toList();

      for(final map in maps){
        final message = MessageModel.fromJson(map);
        messageList.add(message);
      }


      return messageList.reversed.toList();
    }catch(e){
      print("Error Retrieving Chat "+e.toString());
    }

    return messageList;
  }

  Future<void> deleteMessagesByUserId(String withUserId,String ownUserId)async{

    try{
      final db = await instance.database;
      await db.delete(
        ApiConfig.messageTableName,
        where: 'withUserId = ? AND toUserId = ?',
        whereArgs: [withUserId, ownUserId],
      );

    }catch(e){
      print("Error Retrieving Chat "+e.toString());
    }
  }

  List<MessageModel> chatList = [];
  Future<List<MessageModel>> getChatList(int pageNumber,String ownUserId,bool isRequest, int itemPerPage, bool reload)async{
    try{
      final db = await instance.database;
      final offset = (pageNumber - 1) * itemPerPage;

      final List<Map<String, dynamic>> maps =  await db.query(
        ApiConfig.messageTableName,
        where: 'toUserId = ? AND isRequest = ?',
        whereArgs: [ownUserId, isRequest],
        orderBy: 'createdAt ASC',
        limit: itemPerPage,
        offset: offset,
        groupBy: 'name',
      );


      if(reload){
        chatList = [];
      }
      for(final map in maps){
        final message = MessageModel.fromJson(map);

        final countResult = await db.rawQuery(
            'SELECT COUNT(*) as count FROM ${ApiConfig.messageTableName} WHERE withUserId = ? AND isSeen = ?',
            [message.withUserId, false]
        );

        message.unreadMessageCount = Sqflite.firstIntValue(countResult);

        chatList.add(message);
      }

      return chatList.reversed.toList();
    }catch(e){
      print("Error Retrieving Chat "+e.toString());
    }

    return chatList;
  }



  List<MessageModel> requestList = [];
  Future<List<MessageModel>> getRequestChatList(int pageNumber,String ownUserId,bool isRequest, int itemPerPage, bool reload)async{
    try{
      final db = await instance.database;
      final offset = (pageNumber - 1) * itemPerPage;

      final List<Map<String, dynamic>> maps =  await db.query(
        ApiConfig.messageTableName,
        groupBy: 'name',
        where: 'toUserId = ? AND isRequest = ?',
        whereArgs: [ownUserId, isRequest],
        orderBy: 'createdAt ASC',
        limit: itemPerPage,
        offset: offset,
      );


      if(reload){
        requestList = [];
      }
      for(final map in maps){
        final message = MessageModel.fromJson(map);

        final countResult = await db.rawQuery(
            'SELECT COUNT(*) as count FROM ${ApiConfig.messageTableName} WHERE withUserId = ? AND isSeen = ?',
            [message.withUserId, false]
        );

        message.unreadMessageCount = Sqflite.firstIntValue(countResult);

        requestList.add(message);
      }

      return requestList.reversed.toList();
    }catch(e){
      print("Error Retrieving Chat "+e.toString());
    }

    return requestList;
  }

  Future<bool> getUnreadMessage(String toUserId)async{
    try{
      final db = await instance.database;
      // Check unread Message
      final unreadMessageCount = await db.rawQuery(
          'SELECT COUNT(*) FROM ${ApiConfig.messageTableName} WHERE toUserId = ? AND isSeen = ?',
          [toUserId, 0]
      );

      if(Sqflite.firstIntValue(unreadMessageCount) != null && Sqflite.firstIntValue(unreadMessageCount)! > 0){
        return true;
      }


      return false;
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<void> updateRequest(String withUserId,)async{
    try{
      final db = await instance.database;

      // the value need to update
      final updateValue = {
        'isRequest': 0,
      };

      // Perform the update
      await db.update(
        ApiConfig.messageTableName,
        updateValue,
        where: 'withUserId = ? AND isRequest = ?',
        whereArgs: [withUserId, 1],
      );
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> updateIsActive(String withUserId,bool isActive)async{
    try{
      final db = await instance.database;

      // the value need to update
      final updateValue = {
        'isActive': isActive,
      };

      // Perform the update
      await db.update(
        ApiConfig.messageTableName,
        updateValue,
        where: 'withUserId = ?',
        whereArgs: [withUserId],
      );
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> updateIsSeen(String withUserId,)async{
    try{
      final db = await instance.database;

      // the value need to update
      final updateValue = {
        'isSeen': 1,
      };

      // Perform the update

      await db.update(
        ApiConfig.messageTableName,
        updateValue,
        where: 'withUserId = ? AND isSeen = ?',
        whereArgs: [withUserId, 0],
      );
    }catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> updateBlockedByMe(String toUserId, String withUserId, bool blocked)async{
    try{
      final db = await instance.database;

      // the value need to update
      final updateValue = {
        'isBlockedByMe': blocked,
        'isRequest': 0,
      };

      // Perform the update

      await db.update(
        ApiConfig.messageTableName,
        updateValue,
        where: 'toUserId = ? AND withUserId = ?',
        whereArgs: [toUserId, withUserId],
      );
    }catch(e){
      debugPrint(e.toString());
    }
  }
}