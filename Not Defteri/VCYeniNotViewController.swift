//
//  VCYeniNotViewController.swift
//  Not Defteri
//
//  Created by Ali Can on 6.03.2016.
//  Copyright © 2016 Ali Can. All rights reserved.
//

import UIKit
import CoreData

class VCYeniNotViewController: UIViewController {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var txtIcerik: UITextView!
    @IBOutlet weak var btnKaydet: UIButton!
    
    @IBOutlet weak var txtBaslik: UITextField!
    var _id : Int? = 0
    var _baslik : String?
    var _icerik : String?
    var _notForDb : NSManagedObject?
    
    @IBAction func btnKaydetClick(sender: AnyObject) {
        
        _baslik = txtBaslik.text
        _icerik = txtIcerik.text
        
        if _id > 0
        {
            UpdateItem()
        }
        else
        {
            SaveItem()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        if _id > 0
        {
            txtBaslik.text = _baslik
            txtIcerik.text = _icerik!
        }
        else
        {
            txtBaslik.text = ""
            txtIcerik.text = ""
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SaveItem()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Notlar", inManagedObjectContext: managedContext)
        
        _notForDb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
      
    
        // TODO: userdefaulttaki son id değerini bir arttırıp al
        _id = CreateNewId()
        
        _notForDb!.setValue(_id, forKey: "id")
        _notForDb!.setValue(_baslik, forKey: "baslik")
        _notForDb!.setValue(_icerik, forKey: "icerik")
  
        try! managedContext.save()
    }
    
    func UpdateItem()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Notlar", inManagedObjectContext: managedContext)
        
        //let notForDb = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        _notForDb!.setValue(_id, forKey: "id")
        _notForDb!.setValue(_baslik, forKey: "baslik")
        _notForDb!.setValue(_icerik, forKey: "icerik")
        
        //try! managedContext.save()
        
    
        //var context:NSManagedObjectContext = appDel.managedObjectContext!
        
        //var en = NSEntityDescription.entityForName("ENTITIES_NAME", inManagedObjectContext: context)
        
        let batchUpdateRequest = NSBatchUpdateRequest(entity: entity!)
        batchUpdateRequest.resultType = NSBatchUpdateRequestResultType.UpdatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = ["id": _id!]
        var batchUpdateRequestError: NSError?
        try! managedContext.executeRequest(batchUpdateRequest)
        if let error = batchUpdateRequestError {print("error")}
        
        
        
        
    }
    
    
    func CreateNewId() ->Int
    {
        var lastId : Int? =  userDefaults.objectForKey("notId") as! Int?
        
        if lastId == nil
        {
            lastId = 1
        }
        else
        {
            lastId = lastId! + (Int?(1))!
        }
        
        userDefaults.setObject(lastId, forKey: "notId")
        userDefaults.synchronize()
        
        return lastId!
    }

}
