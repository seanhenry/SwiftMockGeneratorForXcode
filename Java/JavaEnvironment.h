#import <Foundation/Foundation.h>
struct JNINativeInterface_;
typedef const struct JNINativeInterface_ *JNIEnv;

@interface JavaEnvironment : NSObject

NS_ASSUME_NONNULL_BEGIN

- (instancetype)init NS_UNAVAILABLE;
@property (nonatomic, readonly, class) JavaEnvironment *shared;

@property (nonatomic, readonly) JNIEnv _Nonnull * _Nonnull env;

NS_ASSUME_NONNULL_END

@end
