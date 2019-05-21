#import "ifunPhotoProvider.h"

@implementation ifunPhotoProvider
  - (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification {
    NSString *fullPath = [notification applicationUserInfo][@"custom"][@"a"][@"inAppUrl"];
    NSURL *url = [NSURL URLWithString:fullPath];
    NSError *error = nil;
    NSString *html = [NSString stringWithContentsOfURL:url encoding: NSUTF8StringEncoding error:&error];

    if (error == nil) {
      NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<meta name=\"twitter:image\" content=\"(.+)\">" options:0 error:&error];
      NSTextCheckingResult *result = [regex firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];

      if (error == nil){
        NSString *imageURLStr = [html substringWithRange: [result rangeAtIndex:1]];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        return [NSClassFromString(@"DDNotificationContactPhotoPromiseOffer") offerDownloadingPromiseWithPhotoIdentifier:imageURLStr fromURL:imageURL];
      }
    }
    return nil;
  }
@end
