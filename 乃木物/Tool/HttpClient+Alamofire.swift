//
//  HttpClient+Alamofire.swift
//  PoliceTool
//
//  Created by ncm on 2017/5/7.
//  Copyright © 2017年 peachRain All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class HttpClient_Alamofire: NSObject {
    
    private static let worker: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // seconds
        configuration.timeoutIntervalForResource = configuration.timeoutIntervalForRequest
        return Alamofire.SessionManager(configuration:configuration)
    }()
    
    //MARK:全部
    static func dataList(params:Dic,success: @escaping SuccessedClosure,failed:@escaping FailedClosure,errorClo:ErrorClosure)->Request{
        return HttpClient_Alamofire.requestGET(urlStr: API.data.list, params: params, success:success, failed: failed, error: errorClo)
    }
    
    //MARK:博客文章
    static func blogList(params:Dic,success: @escaping SuccessedClosure,failed:@escaping FailedClosure,errorClo:ErrorClosure)->Request{
        return HttpClient_Alamofire.requestGET(urlStr: API.data.list, params: params, success:success, failed: failed, error: errorClo)
    }
    
//    //MARK:身份证属地
//    static func idCardFind(idcard:String,success:SuccessedClosure,failed:FailedClosure,errorClo:ErrorClosure){
//        
//        let dic = ["idcard":idcard,"appkey": API.AppKey]
//        _ = HttpClient_Alamofire.requestGET(urlStr: "", params: dic, success: { (param) in
//            print(param)
//        }, failed: { (er) in
//            print(er.localizedDescription)
//        }) { (er, lr) in
//            print(lr)
//        }
//    }
//    
//    //MARK:银行卡归属地
//    static func bankCardFind(bankcard:String,success:SuccessedClosure,failed:FailedClosure,errorClo:ErrorClosure){
//        
//        _ = HttpClient_Alamofire.requestGET(urlStr: "", params: dic, success: { (param) in
//            print(param)
//        }, failed: { (er) in
//            print(er.localizedDescription)
//        }) { (er, lr) in
//            print(lr)
//        }
//    }
    
    
    
    //Alamofire 相关的设置
    //MARK:get请求
    static func requestGET(urlStr:String,params:Dic,success:SuccessedClosure!,failed: FailedClosure!,error:ErrorClosure) -> Request{
        return request(type: HTTPMethod.get, urlStr: urlStr, params: params, success: success, failed: failed, error: error)
    }
    
    //MARK:post请求
    static func requestPOST(urlStr:String,params:Dic,success:SuccessedClosure!,failed: FailedClosure!,error:ErrorClosure) -> Request{
        
        return request(type: HTTPMethod.post, urlStr: urlStr, params: params, success: success, failed: failed, error: error)
    }
    
    //MARK:上传文件
    static func requestUpload(urlStr:String,dataArray:[Data],success: SuccessedClosure!){
        
        let url = createUrlAndHeaders(urlStr: urlStr).url
//        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //多图上传
            for i in 0...dataArray.count {
                multipartFormData.append(dataArray[i], withName: "appPhoto", fileName: "image\(i)", mimeType: "image/png")
            }
        }, to: url) { (result) in
            switch result{
                case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                    request.uploadProgress(closure: { (Progress) in
                        print("上传的进度\(Progress)")
                    }).responseJSON(completionHandler: { (response) in
                        HitMessage.showSuccessWithMessage(message: "上传成功")
                    })
            case .failure(let error):
                HitMessage.showErrorWithMessage(message: error.localizedDescription)
            }
        }
        
    }
    //MARK:上传图片通过路径
    static func requestUploadWithFile(urlStr:String,dataArray:[String],success: SuccessedClosure!){
        
        let url = createUrlAndHeaders(urlStr: urlStr).url
        //        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //多图上传
            for i in 0...dataArray.count {
                let url = URL(fileURLWithPath: dataArray[i])
                multipartFormData.append(url, withName: "appPhoto", fileName: "fileimage\(i)", mimeType: "image/png")
            }
        }, to: url) { (result) in
            switch result{
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                request.uploadProgress(closure: { (Progress) in
                    print("上传的进度\(Progress)")
                }).responseJSON(completionHandler: { (response) in
                    HitMessage.showSuccessWithMessage(message: "上传成功")
                })
            case .failure(let error):
                HitMessage.showErrorWithMessage(message: error.localizedDescription)
            }
        }
        
    }
    
    //MARK:下载文件
    static func requestDownload(urlStr:String,params:Dic){
        
        let url = createUrlAndHeaders(urlStr: urlStr).url
        
        let fileURL: URL = URL.init(string: "")!
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        Alamofire.download(url, method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default, headers: nil, to: destination).downloadProgress { (progress) in
            
        }
        .validate { request, response, temporaryURL, destinationURL in
                // 自定义的校验闭包, 现在包含了 fileURL (必要时可以获取到错误信息)
                return .success
            }
        .responseJSON { response in
                debugPrint(response)
//                print(response.temporaryURL)
//                print(response.destinationURL)
        }
        
    }
    
    
    
    //普遍的请求
    static func request(type:HTTPMethod,urlStr:String,params:Dic,success:SuccessedClosure!,failed: FailedClosure!,error:ErrorClosure) -> Request{
        
        let encoding:ParameterEncoding = ((type.rawValue == Alamofire.HTTPMethod.get.rawValue) ? URLEncoding.default : JSONEncoding.default)
        
        let URL = createUrlAndHeaders(urlStr: urlStr)
        let req = Alamofire.request(URL.url, method: type, parameters: params, encoding: encoding, headers:URL.headers).responseJSON { (Response) in
            switch Response.result{
                case .success:
                    print("--======\(Response.response?.statusCode)")
                    if Response.response?.statusCode == 204 {
                        if let block = success {
                            block([String: Any]())
                        }
                        return
                    }
                    if let block = success{
                        if Response.response?.statusCode == 200{
                            if let resp = (Response.result.value! as? [String: Any]) {
                                block(resp)
                            }else if let data = Response.result.value! as? [Any] {
                                block(["results":data as Any])
                            }
                        }
                    }
                case .failure(let error):
                    guard let block = failed else{
                        return
                }
                    block(error as NSError)
                    dLog("url:\(urlStr) error:\(error.localizedDescription)")
            }
            
        }
        return req
    }

    
    
    //MARK:获取完整地址和header
    private static func createUrlAndHeaders(urlStr: String) -> (url: String, headers: [String: String]){
        
        var Url = ""

        Url = API.ServerHost + urlStr

        let headers = ["Accept": "application/json"]

        return (Url, headers)
    }

}
