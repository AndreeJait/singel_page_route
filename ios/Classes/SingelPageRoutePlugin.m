#import "SingelPageRoutePlugin.h"
#if __has_include(<singel_page_route/singel_page_route-Swift.h>)
#import <singel_page_route/singel_page_route-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "singel_page_route-Swift.h"
#endif

@implementation SingelPageRoutePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSingelPageRoutePlugin registerWithRegistrar:registrar];
}
@end
