//
//  ViewController.swift
//  Not Defteri
//
//  Created by Ali Can on 28.02.2016.
//  Copyright © 2016 Ali Can. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var notlar = [NSManagedObject]()
    
    @IBOutlet weak var lstNotlar: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FetchData()
        lstNotlar.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        FetchData()
        lstNotlar.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notlar.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell  = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        
        cell.textLabel?.text = notlar[indexPath.row].valueForKey("baslik") as? String
        cell.detailTextLabel?.text = notlar[indexPath.row].valueForKey("icerik") as? String
        
        return cell
    }
    var islem : Int = 0
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let id = notlar[indexPath.row].valueForKey("id") as? Int
        let baslik = notlar[indexPath.row].valueForKey("baslik") as? String
        let icerik = notlar[indexPath.row].valueForKey("icerik") as? String
islem = indexPath.row
        let not = NotEntityClass(id: id!, baslik:baslik!, icerik :icerik!)
        
        self.performSegueWithIdentifier("NotDetayGoster", sender: not)
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NotDetayGoster"
        {
            let notDetayVc: VCYeniNotViewController = segue.destinationViewController as! VCYeniNotViewController
            let data = sender as! NotEntityClass
            notDetayVc._id = data._id
            notDetayVc._baslik = data._baslik
            notDetayVc._icerik = data._icerik
            notDetayVc._notForDb = notlar[islem] as NSManagedObject?
        }
    }
    func FetchData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Notlar")
        let entityDescription = NSEntityDescription.entityForName("Notlar", inManagedObjectContext: managedContext)
        
        fetchRequest.entity = entityDescription
        
        do
        {
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            notlar = result
        }
        catch
        {
            let fetchError = error as NSError
            print(fetchError)
        }

    }

}

