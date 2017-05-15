//
//  RainSQLiteManager.swift
//  TSYCatogorysBytaosiyu
//
//  Created by peachRain on 2017/3/15.
//  Copyright © 2017年 ncm. All rights reserved.
//
//这里是一些简单的语句
//OpaquePointer: *db,数据库句柄，跟文件句柄FIFL类似，这里是sqlite3指针；
//sqlite3_stmt: *stmt,相当于ODBC的Command对象，用于保存编译好的SQL语句；
//sqlite3_open(): 打开数据库，没有数据库时创建；
//sqlite3_exec(): 执行非查询的SQL语句；
//sqlite3_step(): 在调用sqlite3_prepare后，使用这个函数在记录集中移动；
//sqlite3_close()：关闭数据库文件；
//sqlite3_column_text()：取text类型的数据；
//sqlite3_column_blob()：取blob类型的数据；
//sqlite3_column_int()：取int类型的数据

enum SQLliteExecType {
    case select,insert,delete,update
}

import UIKit

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to:sqlite3_destructor_type.self)
var DBNAME = "rain.sqlite"
private let localPath = DBNAME.appendDocument()

/// SQLite管理工具为了方便的使用sqlite，超小型的，只是提供基本的功能(可是好难啊)
class RainSQLiteDB: NSObject {
    
    //获取管理对象
    static let shared:RainSQLiteDB = {
        struct Static{
            static let instance = RainSQLiteDB()
        }
        return Static.instance
    }()
    
    var p:OpaquePointer? = nil
    
    //MARK:<------初始化对象和打开数据库----->
    private override init() {
        super.init()
        
        let file = FileManager.default.fileExists(atPath: localPath)
        if !file {
           let createDB = FileManager.default.createFile(atPath: localPath, contents: nil, attributes: nil)
            if createDB {
                var db:OpaquePointer? = nil
                if sqlite3_open_v2(localPath, &db,SQLITE_OPEN_READWRITE,nil) == SQLITE_OK {
                    p = db
                    debugPrint(localPath)
                }else{
                    debugPrint("文件打开失败")
                    self.close()
                }
            }else{
                debugPrint("创建数据库失败")
            }
        }else{
            debugPrint("数据库已经存在")
            var db:OpaquePointer? = nil
            if sqlite3_open_v2(localPath, &db,SQLITE_OPEN_READWRITE,nil) == SQLITE_OK {
                p = db
                debugPrint(localPath)
            }else{
                debugPrint("文件打开失败")
                self.close()
            }
        }
        
    }
    
    //MARK:<--------创建表格------->
    func createTable(sqlParam:String,tableName:String){
        if !isP() {
            debugPrint("数据率没有open")
            return
        }
        if existsTable(name: tableName) {
             debugPrint("表格存在")
            return
        }
        // 1.获取创建表的SQL语句
        let createTableSQL = "CREATE TABLE IF NOT EXISTS \(tableName) (\(sqlParam));"
        
        // 2.执行SQL语句
        if execSQL(sqlStr: createTableSQL) {
            debugPrint("创建表成功")
        }else{
            debugPrint("创建表失败(可能表格已经存在)")
        }
        
    }
    
    //MARK:最好使用这里的方法，其他方法太乱了，有待优化
    private var queue:DispatchQueue = DispatchQueue(label:"RAINSQLite", attributes:[])
    func execute(sql:String, parameters:[Any]?=nil)->Int {
        var result = 0
        queue.sync {
            if let stmt = self.prepare(sql:sql, params:parameters) {
                result = self.stepSQL(sql:sql, stmt:stmt)
            }
        }
        return result
    }

    func query(sql:String, parameters:[Any]?=nil)->[[String:Any]] {
        var rows = [[String:Any]]()
        queue.sync {
            if let stmt = self.prepare(sql:sql, params:parameters) {
                rows = self.query(stmt: stmt)
            }
        }
        return rows
    }
    
    
    
    
    
    //MARK:<--------增-删-改-查-------->
    
    private func prepare(sql:String, params:[Any]?) -> OpaquePointer? {
        var stmt:OpaquePointer? = nil
        let cSql = sql.cString(using: String.Encoding.utf8)
        let result = sqlite3_prepare_v2(p, cSql!, -1, &stmt, nil)
        if result != SQLITE_OK {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8:sqlite3_errmsg(p)) {
                let msg = "SQLiteDB - failed to prepare SQL: \(sql), Error: \(error)"
                NSLog(msg)
            }
            return nil
        }
        if params != nil {

            let cntParams = sqlite3_bind_parameter_count(stmt)
            let cnt = CInt(params!.count)
            if cntParams != cnt {
                let msg = "SQLiteDB - failed to bind parameters, counts did not match. SQL: \(sql), Parameters: \(params)"
                return nil
            }
            var flag:CInt = 0
            for ndx in 1...cnt {
                if let txt = params![ndx-1] as? String {
                    flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
                } else if let data = params![ndx-1] as? NSData {
                    flag = sqlite3_bind_blob(stmt, CInt(ndx), data.bytes, CInt(data.length), SQLITE_TRANSIENT)
                } else if let date = params![ndx-1] as? Date {
                    let txt = "\(date.timeIntervalSince1970)"
                    flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
                } else if let val = params![ndx-1] as? Bool {
                    let num = val ? 1 : 0
                    flag = sqlite3_bind_int(stmt, CInt(ndx), CInt(num))
                } else if let val = params![ndx-1] as? Double {
                    flag = sqlite3_bind_double(stmt, CInt(ndx), CDouble(val))
                } else if let val = params![ndx-1] as? Int {
                    flag = sqlite3_bind_int(stmt, CInt(ndx), CInt(val))
                } else {
                    flag = sqlite3_bind_null(stmt, CInt(ndx))
                }
                if flag != SQLITE_OK {
                    sqlite3_finalize(stmt)
                    if let error = String(validatingUTF8:sqlite3_errmsg(p)) {
                        let msg = "SQLiteDB - failed to bind for SQL: \(sql), Parameters: \(params), Index: \(ndx) Error: \(error)"
                    }
                    return nil
                }
            }
        }
        return stmt
    }

    //MARK:增-删-改-查
    ///
    /// - Parameters:
    ///   - paramArray: 数据数组
    ///   - paramDic: 数据字典
    ///   - tableName: 表格的名字
    func prepareForSQLite(type:SQLliteExecType,paramDic:[String:Any]?,tableName:String)->OpaquePointer?{
        
        if !existsTable(name: tableName) {
            debugPrint("表格不存在")
            return nil
        }
        var stmt : OpaquePointer? = nil
        
        guard let params = paramDic else{
            return nil
        }
        if params.keys.count < 0{
            return nil
        }
        
        // 1.获取创建表的SQL语句
        let querySQL = arrayToString(type:type,paramDic: paramDic!, tableName: tableName)
        
        var rc:Int32? = nil
        if !(stmt != nil) {
            rc = sqlite3_prepare_v2(p, querySQL.codeUTF8(),-1, &stmt, nil)
            if rc != SQLITE_OK {
                debugPrint("添加过程错误")
                sqlite3_finalize(stmt)
                return nil
            }
        }
        var idx = 0
        let queryCount = sqlite3_bind_parameter_count(stmt);
        for (key,value) in params {
            let parameterName = ":\(key)"
            let namedIdx = sqlite3_bind_parameter_index(stmt, parameterName.codeUTF8());
            if (namedIdx > 0) {
                // 在这里绑定
                self.bindObjectByIndexWithP(obj: value, ndx: namedIdx, stmt: stmt!)
                idx+=1;
            }
            else {
                debugPrint("Could not find index for \(key)")
            }
        }
        _ = stepSQL(sql: querySQL, stmt: stmt!)
        
        if (idx != Int(queryCount)) {
            print("Error: the bind count is not correct (executeQuery)")
            sqlite3_finalize(stmt)
        }
        return stmt
    }
    
    private func arrayToString(type:SQLliteExecType,paramDic:[String:Any],tableName:String)->String{
        switch type {
        case .insert:
            let values = paramDic.keys
            let keys = paramDic.keys.joined(separator: ",")
            let valuess = values.map { (str) -> String in
                return ":\(str)"
                }.joined(separator: ",")
            let querySQL = "INSERT OR REPLACE INTO \(tableName)(\(keys)) VALUES(\(valuess));"
            return querySQL
        case .delete:
            let querySQL = "DELETE FROM \(tableName);"
            return querySQL
        case .update:
            return ""
        default:
            let querySQL = "SELECT * FROM \(tableName);"
            return querySQL
        }
    }
    
    //MARK:<=======数据bind=======>
    //MARK:绑定数据
    ///
    /// - Parameters:
    ///   - obj: 数据
    ///   - index: 位置
    ///   - stmt: 指针sqlite3_stmt对象
    private func bindObjectByIndexWithP(obj:Any,ndx:Int32,stmt:OpaquePointer) {
        var flag:CInt = 0
        if let txt = obj as? String {
            flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
        } else if let data = obj as? NSData {
            flag = sqlite3_bind_blob(stmt, CInt(ndx), data.bytes, CInt(data.length), SQLITE_TRANSIENT)
        } else if let date = obj as? Date {
            let txt = "\(date.timeIntervalSince1970)"
            flag = sqlite3_bind_text(stmt, CInt(ndx), txt, -1, SQLITE_TRANSIENT)
        } else if let val = obj as? Bool {
            let num = val ? 1 : 0
            flag = sqlite3_bind_int(stmt, CInt(ndx), CInt(num))
        } else if let val = obj as? Double {
            flag = sqlite3_bind_double(stmt, CInt(ndx), CDouble(val))
        } else if let val = obj as? Int {
            flag = sqlite3_bind_int(stmt, CInt(ndx), CInt(val))
        } else {
            flag = sqlite3_bind_null(stmt, CInt(ndx))
        }
        if flag != SQLITE_OK {
            sqlite3_finalize(stmt)
        }
        
    }
    
    //MARK:<=======准备,查询和执行的方法=======>
    
    //MARK:获取数据
    private func query(stmt : OpaquePointer) -> [[String:Any]] {
        var array = [[String:Any]]()
        var result = sqlite3_step(stmt)
        var count:CInt = 0
        while result == SQLITE_ROW {
            // 1.获取字段个数
            count = sqlite3_column_count(stmt)
            var dict = [String:Any]()
            for i in 0..<count {
                // 2.取出字典对应的key
                let cKey = sqlite3_column_name(stmt, i)
                guard let keyName = String.init(cString: cKey!, encoding: String.Encoding.utf8) else {
                    continue
                }
                //数据类型
                if let value = getColumnValueByType(index: i, stmt: stmt) {
                    dict[keyName] = value
                }
            }
            array.append(dict)
            result = sqlite3_step(stmt)
        }
        sqlite3_finalize(stmt)
        
        return array
    }
    
    //MARK:执行语句(step)
    ///
    /// - Parameters:
    ///   - sql: sql语句
    ///   - stmt: db指针对象
    /// - Returns: 1:成功
    private func stepSQL(sql:String,stmt:OpaquePointer)->Int{
        let res = sqlite3_step(stmt)
        if res != SQLITE_OK && res != SQLITE_DONE {
            sqlite3_finalize(stmt)
            if let error = String(validatingUTF8:sqlite3_errmsg(p)) {
                let msg = "SQLiteDB - failed to execute SQL: \(sql), Error: \(error)"
                debugPrint(msg)
            }
            return 0
        }
        
        let upp = sql.uppercased()
        var result = 0
        //如果是插入
        if upp.hasPrefix("INSERT") {
            let rid = sqlite3_last_insert_rowid(p)
            result = Int(rid)
        } else if upp.hasPrefix("DELETE") || upp.hasPrefix("UPDATE") {
            //如果是删除更新
            var cnt = sqlite3_changes(p)
            if cnt == 0 {
                cnt += 1
            }
            result = Int(cnt)
        } else {
            result = 1
        }
        sqlite3_finalize(stmt)
        return result
        
    }
    //MARK:执行语sql句(exec)
    ///
    /// - Parameter sqlStr: 执行语句（非查询）
    /// - Returns: 执行是否成功
    private func execSQL(sqlStr:String)->Bool{
        if isP() {
            let o = sqlite3_exec(p, sqlStr.codeUTF8(), nil, nil, nil)
            if o == SQLITE_OK{
                return true
            }else{
                debugPrint("exec 执行失败 返回结果为：\(o),sql语句为:\(sqlStr)")
                return false
            }
        }
        return false
    }
    
    private let SQLITE_DATE = SQLITE_NULL + 1
    
    //MARK: 根据不同的数据类型转换值
    ///
    /// - Parameters:
    ///   - index: col位置
    ///   - stmt: DB
    /// - Returns: 字典数组数据
    private func getColumnValueByType(index:CInt, stmt:OpaquePointer)->Any?{
        var type:CInt = 0
        let blobTypes = ["BINARY", "BLOB", "VARBINARY"]
        let charTypes = ["CHAR", "CHARACTER", "CLOB", "NATIONAL VARYING CHARACTER", "NATIVE CHARACTER", "NCHAR", "NVARCHAR", "TEXT", "VARCHAR", "VARIANT", "VARYING CHARACTER"]
        let dateTypes = ["DATE", "DATETIME", "TIME", "TIMESTAMP"]
        let intTypes  = ["BIGINT", "BIT", "BOOL", "BOOLEAN", "INT", "INT2", "INT8", "INTEGER", "MEDIUMINT", "SMALLINT", "TINYINT"]
        let nullTypes = ["NULL"]
        let realTypes = ["DECIMAL", "DOUBLE", "DOUBLE PRECISION", "FLOAT", "NUMERIC", "REAL"]
        let buf = sqlite3_column_decltype(stmt, index)
        if buf != nil {
            var tmp = String(validatingUTF8:buf!)!.uppercased()
            if let pos = tmp.range(of:"(") {
                tmp = tmp.substring(to:pos.lowerBound)
            }
            if intTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_INTEGER, stmt: stmt)
            }
            if realTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_FLOAT, stmt: stmt)
            }
            if charTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_TEXT, stmt: stmt)
            }
            if blobTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_BLOB, stmt: stmt)
            }
            if nullTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_NULL, stmt: stmt)
            }
            if dateTypes.contains(tmp) {
                return self.getColumnValue(index: index, type: SQLITE_DATE, stmt: stmt)
            }
            return self.getColumnValue(index: index, type: SQLITE_TEXT, stmt: stmt)
        } else {
            type = sqlite3_column_type(stmt, index)
        }
        return self.getColumnValue(index: index, type: type, stmt: stmt)
    }
    
    private func getColumnValue(index:CInt, type:CInt, stmt:OpaquePointer)->Any? {
        if type == SQLITE_INTEGER {
            let val = sqlite3_column_int(stmt, index)
            return Int(val)
        }
        if type == SQLITE_FLOAT {
            let val = sqlite3_column_double(stmt, index)
            return Double(val)
        }
        if type == SQLITE_BLOB {
            let data = sqlite3_column_blob(stmt, index)
            let size = sqlite3_column_bytes(stmt, index)
            let val = NSData(bytes:data, length:Int(size))
            return val
        }
        if type == SQLITE_NULL {
            return nil
        }
        if type == SQLITE_DATE {
            if let ptr = UnsafeRawPointer.init(sqlite3_column_text(stmt, index)) {
                let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
                let txt = String(validatingUTF8:uptr)!
                let set = CharacterSet(charactersIn:"-:")
                if txt.rangeOfCharacter(from:set) != nil {
                    var time:tm = tm(tm_sec: 0, tm_min: 0, tm_hour: 0, tm_mday: 0, tm_mon: 0, tm_year: 0, tm_wday: 0, tm_yday: 0, tm_isdst: 0, tm_gmtoff: 0, tm_zone:nil)
                    strptime(txt, "%Y-%m-%d %H:%M:%S", &time)
                    time.tm_isdst = -1
                    let diff = TimeZone.current.secondsFromGMT()
                    let t = mktime(&time) + diff
                    let ti = TimeInterval(t)
                    let val = Date(timeIntervalSince1970:ti)
                    return val
                }
            }
            let val = sqlite3_column_double(stmt, index)
            let dt = Date(timeIntervalSince1970: val)
            return dt
        }
        if let ptr = UnsafeRawPointer.init(sqlite3_column_text(stmt, index)) {
            let uptr = ptr.bindMemory(to:CChar.self, capacity:0)
            let txt = String(validatingUTF8:uptr)
            return txt
        }
        return nil
    }
    
    
    //MARK:查询操作
    ///
    /// - Parameters:
    ///   - querySQL: 查询语句
    ///   - fn: 查询结果回调
    /// - Returns: 是否有查询数据 true：表示有数据
    private func querySQL(querySQL : String,fn:(Int32)->Void)->Bool{
        // 1.定义游标指针
        var stmt : OpaquePointer? = nil
        let status = sqlite3_prepare_v2(p, querySQL.codeUTF8(),-1, &stmt, nil)
        if status == SQLITE_OK
        {
            if sqlite3_step(stmt) == SQLITE_ROW
            {
                fn(1)
                sqlite3_finalize(stmt)
                return true
            }
            sqlite3_finalize(stmt)
            return false
        }
        else
        {
            debugPrint("sql错误,\(status):\(querySQL)")
            fn(0)
            sqlite3_finalize(stmt)
            return false
        }
        
    }
    
    //MARK:<=======判断的方法=======>
    //MARK:判断语句执行结果是否有数据
    /// - Parameter str: Sql语句
    /// - Returns: 1:表示执行成公有数据 -1：没有数据
    private func count(str:String)->Int
    {
        let isHas = querySQL(querySQL: str) { (stmt) -> Void in
            
        }
        return isHas ? 1 : -1
    }
    //MARK:表是否存在
    private func existsTable(name:String)->Bool
    {
        return count(str: "select name from sqlite_master where type='table' and name = '\(name)'") == 1
    }
    //MARK:关闭数据库
    private func close(){
        guard let point = p else{
            return
        }
        sqlite3_close(point)
    }
    
    //MARK:判断内容是否存在
    private func isP()->Bool{
        guard p != nil else{
            debugPrint("数据库没有打开")
            return false
        }
        return true
    }

}
