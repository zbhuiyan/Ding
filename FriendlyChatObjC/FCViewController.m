//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "FCViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@import Photos;

@import Firebase;
@import GoogleMobileAds;
@import FirebaseMessaging;

@interface FCViewController () <CLLocationManagerDelegate>

@property(nonatomic,retain) CLLocationManager *locationManager;
@property GMSMapView *mapView;


@end

@implementation FCViewController

- (void)loadView {
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager startUpdatingLocation];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_locationManager.location.coordinate.latitude
                                 
                                                            longitude:_locationManager.location.coordinate.longitude
                                 
                                                                 zoom:20];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    _mapView.delegate = self;
    self.view = _mapView;
    
}


- (void)viewDidLoad {
    //The event handling method
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);
}

- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)position {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"" delegate:self cancelButtonTitle:@"Make It Public!" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    marker.title = [[alert textFieldAtIndex:0] text];
    marker.map = _mapView;
    NSString *fcmToken = [FIRMessaging messaging].FCMToken;
    NSLog(@"FCM registration token: %@", fcmToken);

}

@end
