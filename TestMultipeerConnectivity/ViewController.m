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
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

NSString *const servicetype = @"myservice";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


# pragma mark -

- (void)discoveryPeers {
    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID serviceType:servicetype];
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];

}

- (void)advertisingForPeers {
    self.advetiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID discoveryInfo:nil serviceType:servicetype];
    self.advetiser.delegate = self;
    [self.advetiser startAdvertisingPeer];
}

- (void)initializeSessionWithPeerName:(NSString *)name {
    self.peerID = [[MCPeerID alloc] initWithDisplayName:name];
    self.session = [[MCSession alloc] initWithPeer:self.peerID];
    self.session.delegate = self;
    [self.nameTextField endEditing:YES];
}

- (void)startAdvertising {
    MCBrowserViewController *bvc = [[MCBrowserViewController alloc] initWithBrowser:self.browser session:self.session];
    bvc.delegate = self;
    
    [self presentViewController:bvc animated:YES completion:nil];
}

- (void)addEventLog:(NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", log);
        self.textView.text = [NSString stringWithFormat:@"%@\n%@", log, self.textView.text];
    });
}

# pragma mark - actions

- (IBAction)createSession:(id)sender {
    [self initializeSessionWithPeerName:self.nameTextField.text];
    [self addEventLog:@"Created session"];
}

- (IBAction)discovery:(id)sender {
    [self discoveryPeers];
    [self addEventLog:@"Start discovery for peers"];
}

- (IBAction)advertising:(id)sender {
    [self advertisingForPeers];
    [self addEventLog:@"Start advertising for peers"];
}

# pragma mark - session delegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    [self addEventLog:[NSString stringWithFormat:@"Did change state to: %ld with peerID: %@", state, peerID]];
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

# pragma mark - browser delegate

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info {
    [self addEventLog:[NSString stringWithFormat:@"found peerID: %@", peerID]];
    
    [browser invitePeer:peerID toSession:self.session withContext:nil timeout:0];
    [self addEventLog:[NSString stringWithFormat:@"Send invitation for peerID: %@", peerID]];

}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    [self addEventLog:[NSString stringWithFormat:@"lost peerID: %@", peerID]];
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
    [self addEventLog:[NSString stringWithFormat:@"Did not started advertising with error: %@", error]];
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession * _Nullable))invitationHandler {
    [self addEventLog:[NSString stringWithFormat:@"Receive invitation from peerID: %@", peerID]];
    
    invitationHandler(YES, self.session);
}

@end
