#import <Foundation/Foundation.h>

@protocol MockGeneratorXPCProtocol

- (void)generateMockFromFileContents:(nonnull NSString *)contents line:(NSInteger)line column:(NSInteger)column withReply:(nonnull void(^)(NSArray<NSString *> * _Nullable, NSError * _Nullable))reply;

@end
