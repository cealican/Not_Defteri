//
//  NotEntityClass.swift
//  Not Defteri
//
//  Created by Ali Can on 6.03.2016.
//  Copyright © 2016 Ali Can. All rights reserved.
//

import Foundation

class NotEntityClass
{
    var _id : Int
    var _baslik : String
    var _icerik : String
    
    init ()
    {
        _id = 0
        _baslik = ""
        _icerik = ""
    }
    
    init (id : Int, baslik : String, icerik : String)
    {
        _id = id
        _baslik = baslik
        _icerik = icerik
    }
    
}