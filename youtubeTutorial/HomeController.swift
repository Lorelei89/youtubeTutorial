//
//  ViewController.swift
//  youtubeTutorial
//
//  Created by sabina on 04/09/16.
//  Copyright © 2016 sabina. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    var videos:[Video] = {
        var channel = Channel()
        channel.name = "This is the best channel"
        channel.profileImageName = "norahjones1"
        
        var blankSpaceVideo = Video()
        blankSpaceVideo.title = "Norah Jones - Blank Spce"
        blankSpaceVideo.thumbnailImageName = "norahjones4"
        blankSpaceVideo.channel = channel
        blankSpaceVideo.numberOfVideos = 5235246
        
        var badBladVideo = Video()
        badBladVideo.title = "Norah Jones - Bad Blood featuring"
        badBladVideo.thumbnailImageName = "norahjones2"
        badBladVideo.channel = channel
        badBladVideo.numberOfVideos = 254742
        
        var badBladVideo2 = Video()
        badBladVideo2.title = "Norah Jones - Bad Blood featuring and Easy"
        badBladVideo2.thumbnailImageName = "norahjones1"
        badBladVideo2.channel = channel
        badBladVideo2.numberOfVideos = 24324252
        
        return [badBladVideo,badBladVideo2, blankSpaceVideo]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame:CGRect(x: 0,y: 0,width: view.frame.width - 32 ,height: view.frame.height))
        navigationItem.titleView = titleLabel
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavButtons()
        
    }
    
    func setupNavButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        
        let searchBarButton =  UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        
        let moreBarButton =  UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButton , searchBarButton]
    }
    
    func handleSearch() {
        
    }
    
    func handleMore () {
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    fileprivate func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}



