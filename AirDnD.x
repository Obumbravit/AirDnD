//AirDnD ~ Obumbravit

@import UIKit;
#import "AirDnD.h"
#import "Prefs.h"

%hook DNDState

- (BOOL)isActive
{
    if (airDnD) DnD = %orig;
	return %orig;
}

%end

%hook SBLockScreenManager

- (BOOL)isUILocked
{
    if (airDnD)
    {
        bool isLocked = %orig;
        if (isLocked && DnD) [[%c(SBAirplaneModeController) sharedInstance] setInAirplaneMode:YES];
        else if (!isLocked && DnD) [[%c(SBAirplaneModeController) sharedInstance] setInAirplaneMode:NO];
    }
    return %orig;
}

%end

%ctor
{
    notificationCallback(NULL, NULL, NULL, NULL, NULL);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, (CFStringRef)nsNotificationString, NULL, CFNotificationSuspensionBehaviorCoalesce);
}