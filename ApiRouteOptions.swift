////
////  ApiRouteOptions.swift
////  Proyecto
////
////  Created by MATEO  ALPUY on 26/7/21.
////
//
import Foundation
import Alamofire
enum Router: APIRoute{
    case getGenreWithPage(genreId: Int,page: Int)
    case getToken
    case getGenre
    case login(username: String,password: String,request_token: String)
    case getMoviesByGenre(genreId: Int)
    func asURLRequest() throws -> URLRequest {
        switch self{
        case .getGenreWithPage(genreId:  let genreId, page: let page):
            let url = "discover/movie?"
            return try encoded(path: url, params: ["with_genres" : genreId , "page" : page])
        case .login(username: let username, password: let password,request_token: let request_token):
            let url = "authentication/token/validate_with_login?"
            return try encoded(path: url, params: ["username": username, "password" : password, "request_token" : request_token])
        case .getGenre:
            let url = "genre/movie/list?"
            let params :[String:Any] =  [:]
            return try encoded(path: url, params: params)
        case .getToken:
            let url = "authentication/token/new?"
            let params :[String:Any] =  [:]
            return try encoded(path: url, params: params)
      
        case .getMoviesByGenre(genreId: let genreId):
            let url = "discover/movie?"
            return try encoded(path: url, params: ["with_genres" : genreId])
        }
    }
   
    var method: HTTPMethod{
        switch self{
        case .getGenreWithPage(genreId:  let genreId, page: let page):
            return .get
        case .login(username: let username, password: let password, request_token: let request_token):
            return .post
        case .getToken:
            return .get
        case .getGenre:
            return .get
        case .getMoviesByGenre(genreId: let genreId):
           return .get
        }
    }
    var sessionPolicy: APIRouteSessionPolicy{
        switch self{
        case .getGenreWithPage(genreId:  let genreId, page: let page ):
            return .privateDomain
        case .login(username: let username, password: let password, request_token: let request_token):
        return .privateDomain
        case.getToken:
        return .privateDomain
        case .getGenre:
        return .privateDomain
      
        case .getMoviesByGenre(genreId: let genreId):
            return .privateDomain
        }}
    
    
}

