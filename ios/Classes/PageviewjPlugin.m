#import "PageviewjPlugin.h"
#if __has_include(<pageviewj/pageviewj-Swift.h>)
#import <pageviewj/pageviewj-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "pageviewj-Swift.h"
#endif

@implementation PageviewjPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPageviewjPlugin registerWithRegistrar:registrar];
}
@end
