#import "SharedPrefPlugin.h"
#if __has_include(<shared_pref/shared_pref-Swift.h>)
#import <shared_pref/shared_pref-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "shared_pref-Swift.h"
#endif

@implementation SharedPrefPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSharedPrefPlugin registerWithRegistrar:registrar];
}
@end
