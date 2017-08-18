//
//  ViewController.m
//  TestMultipeerConnectivity
//
//  Created by 清 貴幸 on 2017/08/18.
//  Copyright © 2017年 daybysay. All rights reserved.
//

#import "ViewController.h"
@import MultipeerConnectivity;

@interface ViewController () <MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCBrowserViewControllerDelegate, MCNearbyServiceAdvertiserDelegate>
@property (nonnull, strong) MCPeerID *peerID;
@property (nonnull, strong) MCSession *session;
@property (nonnull, strong) MCNearbyServiceBrowser *browser;
@property (nonnull, strong) MCNearbyServiceAdvertiser *advetiser;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.peerID = [[MCPeerID alloc] initWithDisplayName:@"unpotan"];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    
    NSString *servicetype = @"unkoservice";
    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID serviceType:servicetype];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
    
    self.advetiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID discoveryInfo:nil serviceType:servicetype];
    self.advetiser.delegate = self;
    [self.advetiser startAdvertisingPeer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    MCBrowserViewController *bvc = [[MCBrowserViewController alloc] initWithBrowser:self.browser session:self.session];
    bvc.delegate = self;
    
    [self presentViewController:bvc animated:YES completion:nil];
}

# pragma mark - session delegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    
}

- (void)session:(MCSession *)session didReceiveCertificate:(NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL))certificateHandler {
    
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}


- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

# pragma mark - browser delegate

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info {
    NSLog(@"peerID: %@", peerID);
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    
}

# pragma mark - browser vc delegate

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController {
    
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController {
    
}

- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info {
    return YES;
}

# pragma mark - advertiser delegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
    
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession * _Nullable))invitationHandler {
    
}

@end
