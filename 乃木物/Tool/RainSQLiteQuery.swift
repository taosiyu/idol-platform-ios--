//
//  RainSQLiteQuery.swift
//  乃木物
//
//  Created by ncm on 2017/5/15.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class RainSQLiteQuery: NSObject {
    
    //获取全部数据，也可以是部分
    static func getRows(tableName:String,filter:String="", order:String="", limitFrom:Int=0,to:Int=0,finishClo:([DataListModel])->()) {
        var sql = "SELECT * FROM \(tableName)"
        if !filter.isEmpty {
            sql += " WHERE \(filter)"
        }
        if !order.isEmpty {
            sql += " ORDER BY \(order)"
        }
        if to > 0 {
            sql += " LIMIT \(limitFrom), \(to)"
        }
    
        finishClo(RainSQLiteQuery.rowsFor(tableName: tableName, sql: sql))
    }
    
    //获取数据
    static func rowsFor(tableName:String,sql:String="") -> [DataListModel] {
        var res = [DataListModel]()
        let db = RainSQLiteDB.shared
        let fsql = sql.isEmpty ? "SELECT * FROM \(tableName)" : sql
        let arr = db.query(sql:fsql)
        if let models = Mapper<DataListModel>().mapArray(JSONObject: arr){
            res = models
        }
        return res
    }
    
    //MARK:保存
    static func save(tableName:String,detailId:String,data:[String:String])->Int{
        let db = RainSQLiteDB.shared
        var insert = true
        let sql = "SELECT COUNT(*) AS count FROM \(tableName) WHERE detailId=\(detailId)"
        let arr = db.query(sql:sql)
        if arr.count == 1 {
            if let cnt = arr[0]["count"] as? Int {
                insert = (cnt == 0)
            }
        }
        if !insert{
            HitMessage.showInfoWithMessage(message: "已收藏")
            return 0
        }
        let (sqlite, params) = RainSQLiteQuery.getSQL(tableName: tableName, detailId: detailId, data: data, forInsert: insert)
        let rc = db.execute(sql:sqlite, parameters:params)
        if rc == 0 {
            NSLog("Error saving record!")
            return 0
        }
        HitMessage.showInfoWithMessage(message: "收藏成功")
        return rc
        
    }
    
    static func getSQL(tableName:String,detailId:String,data:[String:String], forInsert:Bool = true) -> (String, [Any]?) {
        var sql = ""
        var params:[String]? = nil
        if forInsert {
            sql = "INSERT INTO \(tableName)("
        } else {
            sql = "UPDATE \(tableName) SET "
        }
        var wsql = ""
        var first = true
        var rid:String?
        for (key, val) in data {
            if "detailId" == key {
                if forInsert {
                    if val is Int && (val as! Int) == -1 {
                        continue
                    }
                } else {
                    wsql += " WHERE " + key + " = ?"
                    rid = val
                    continue
                }
            }
            if first && params == nil {
                params = [String]()
            }
            if forInsert {
                sql += first ? "\(key)" : ", \(key)"
                wsql += first ? " VALUES (?" : ", ?"
                params!.append(val)
            } else {
                sql += first ? "\(key) = ?" : ", \(key) = ?"
                params!.append(val)
            }
            first = false
        }
        if forInsert {
            sql += ")" + wsql + ")"
        } else if params != nil && !wsql.isEmpty {
            sql += wsql
            params!.append(rid!)
        }
        
        return (sql, params)
    }
}
