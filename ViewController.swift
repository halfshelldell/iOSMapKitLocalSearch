//
//  ViewController.swift
//  iOSMapKitLocalSearch
//
//  Created by Lydell Simmons on 5/14/17.
//  Copyright © 2017 Lydell Simmons. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var MySearchBar: UISearchBar!
    @IBOutlet weak var MyMapView: MKMapView!
    
    let request = MKLocalSearchRequest()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        MySearchBar.delegate = self
        MyMapView.delegate = self
        
        //request.region = MyMapView.region
        request.region.center = MyMapView.region.center
        //request.region.center.latitude = MyMapView.region.center.latitude
        
        let search = MKLocalSearch(request : request)
        
        search.start(completionHandler: {(response,error) in
            
            if error != nil
            {
                print("Error...!!!!")
                }
                else if response!.mapItems.count == 0
            {
                print("Not Found...!!!")
                }
                else
                {
                for item in response!.mapItems
                {
                    print("Name=\(item.name ?? "Does not work!")")
                    print("Tel.No=\(item.phoneNumber ?? "No telephone")")
                    print("Address:=\(item)")
                    
                    let annoation = MKPointAnnotation()
                    annoation.coordinate = item.placemark.coordinate
                    annoation.title = item.name
                    annoation.subtitle = item.phoneNumber
                    self.MyMapView.addAnnotation(annoation)
                    
                }
            }
        
        })
    
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.view.endEditing(true)
        
        request.naturalLanguageQuery = searchBar.text! // "Pizza, vs..."
        
        if MyMapView.annotations.count > 0
        {
            MyMapView.removeAnnotations(MyMapView.annotations)
        }
        
        
        self.viewDidLoad()
        
    }
    

}









