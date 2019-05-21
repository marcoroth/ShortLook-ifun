#import "ShortLook-API.h"

@interface ifunPhotoProvider : NSObject <DDNotificationContactPhotoProviding>
- (DDNotificationContactPhotoPromiseOffer *)contactPhotoPromiseOfferForNotification:(DDUserNotification *)notification;
@end
