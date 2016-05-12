//
//  TileLayerDemoViewController.swift
//  BMKSwiftDemo
//
//  Created by wzy on 15/11/9.
//  Copyright © 2015年 baidu. All rights reserved.
//

import UIKit
var arr = Array<(x:Int,y:Int,zoom:Int)>()

class LocalTileLayer: BMKSyncTileLayer {
    override func tileForX(x: Int, y: Int, zoom: Int) -> UIImage! {
        arr.append((x,y,zoom))
        let image = UIImage(named: "\(zoom)_\(x)_\(y).jpg")
        return image;
    }
}

class TileLayerDemoViewController: UIViewController, BMKMapViewDelegate {
    
    @IBOutlet weak var _mapView: BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _mapView.zoomLevel = 16
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(31.37567, 121.593298)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _mapView.viewWillAppear()
        _mapView.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        _mapView.viewWillDisappear()
        _mapView.delegate = nil
    }

    // MARK: - IBAction
    
    @IBAction func changeTileStatus(sender: UISegmentedControl) {
        _mapView.removeOverlays(_mapView.overlays)
        if sender.selectedSegmentIndex == 1 {//本地
            addLocalTile()
        } else if sender.selectedSegmentIndex == 2 {//在线
            addUrlTile()
        } else {
            _mapView.mapType = UInt(BMKMapTypeStandard)
        }
    }
    //添加本地瓦片图
    func addLocalTile() {
        for (x,y,zoom) in arr {
            print("'http://online4.map.bdimg.com/onlinelabel/?qt=tile&x=\(x)&y=\(y)&z=\(zoom)'")
        }
        for (x,y,zoom) in arr {
            print("\(zoom)_\(x)_\(y).jpg'")
        }
        //限制地图显示范围
//        _mapView.maxZoomLevel = 17.4
//        _mapView.minZoomLevel = 16
//        let center = CLLocationCoordinate2DMake(39.924257, 116.403263)
//        let span = BMKCoordinateSpanMake(0.013142, 0.011678)
//        _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span)
//        _mapView.overlookEnabled = false
//        _mapView.rotateEnabled = false//禁用旋转手势
        _mapView.mapType = UInt(BMKMapTypeNone)
        let point = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(31.37567, 121.593298))
        let localTileLayer = LocalTileLayer()
        localTileLayer.visibleMapRect = BMKMapRectMake(point.x, point.y, 1024+256, 1024+256)
        localTileLayer.maxZoom = 18
        localTileLayer.minZoom = 16
        _mapView.addOverlay(localTileLayer)
    }
    //添加在线瓦片图
    func addUrlTile() {
        //限制地图显示范围
//        _mapView.maxZoomLevel = 18
//        _mapView.minZoomLevel = 16
//        let center = CLLocationCoordinate2DMake(39.924257, 116.403263)
//        let span = BMKCoordinateSpanMake(0.038325, 0.028045)
//        _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span)
//        _mapView.overlookEnabled = false
//        _mapView.rotateEnabled = false//禁用旋转手势
        _mapView.mapType = UInt(BMKMapTypeNone)
        
        let point = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(31.37567, 121.593298))
       
        
        //let urlTileLayer = BMKURLTileLayer(URLTemplate: "http://api0.map.bdimg.com/customimage/tile?&x={x}&y={y}&z={z}&udt=20150601&customid=light")
        let urlTileLayer = BMKURLTileLayer(URLTemplate: "http://online4.map.bdimg.com/onlinelabel/?qt=tile&x={x}&y={y}&z={z}")
        urlTileLayer.visibleMapRect = BMKMapRectMake(point.x, point.y, 1024+256, 1024+256)
        urlTileLayer.maxZoom = 18
        urlTileLayer.minZoom = 16
        _mapView.addOverlay(urlTileLayer)
    }
    
    // MARK: - BMKMapViewDelegate
    /**
    *根据overlay生成对应的View
    *@param mapView 地图View
    *@param overlay 指定的overlay
    *@return 生成的覆盖物View
    */
    func mapView(mapView: BMKMapView!, viewForOverlay overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay is BMKTileLayer {
            return BMKTileLayerView()
        }
        return nil;
    }
}