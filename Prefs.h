@interface NSUserDefaults (airdndprefs)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end

static NSString * nsDomainString = @"com.obumbravit.airdnd";
static NSString * nsNotificationString = @"com.obumbravit.airdnd/preferences.changed";

static BOOL airDnD;

static void notificationCallback(CFNotificationCenterRef center, void * observer, CFStringRef name, const void * object, CFDictionaryRef userInfo)
{
    NSNumber * airDnDD = (NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:@"airDnD" inDomain:nsDomainString];
    airDnD = (airDnDD) ? [airDnDD boolValue] : YES;
}