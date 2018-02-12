# flicKI

FlicKI is a test application that provides the possibility to download and filter images from Flickr. Official public API was used.

## Next mandatory requirments are fullfilled:
  - Third party libraries are used
  - App is pulled to GitHub
  - Fetch data from the public API
  - Metadata is visible for each image

#### As some optional:
  - Image caching
  - Share image
  - Open image in browser
  - Save image
 
#### Step by step development history
- Look into Flickr API, create singleton NetworkHandler class, connect Alamofire;
- Look for ready-to-go solutions for image caching. Connect Kingfisher;
- Decide to use ObjectMapper instead of checking all keys in dictionary manually, connect AlamofireObjectMapper, ObjectMapper, write PhotoResponse and Photo classes for handling Model
- Put some general stuff to storyboard, decide to create collectionView inside tableRow. [This tutorial](https://ashfurrow.com/blog/putting-a-uicollectionview-in-a-uitableviewcell-in-swift/) was used;
- Put textField to the Navigation Bar. Now all API calling are served with Activity Indicator from LLSpinner;
- Create DetailViewController with all views. Pass Photo instance to the Detail with the manual segue call from didSelect;
- Look for EXIF data extractor. Put all data to separate TextView that could be hidden/visible by pressing "Info" button;
- Implement UIActivityController passing UIImage to it;
- Create "Go" button for redirecting to the original FLickr web-page


#### Pods that are used
* [Alamofire](https://github.com/Alamofire/Alamofire) - HTTP networking library written in Swift;
* [AlamofireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) - An extension to Alamofire which automatically converts JSON response data into swift objects using ObjectMapper;
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) - framework written in Swift that makes it easy for you to convert your model objects (classes and structs) to and from JSON;
* [Kingfisher](https://github.com/onevcat/Kingfisher) - lightweight, pure-Swift library for downloading and caching images from the web;
* [LLSpinner](https://github.com/alaphao/LLSpinner) - An easy way to handle full screen activity indicator.


