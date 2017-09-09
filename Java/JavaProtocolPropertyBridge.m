#import "JavaProtocolPropertyBridge.h"
#import "jni.h"

@implementation JavaProtocolPropertyBridge {
    JNIEnv *env;
    jclass protocolPropertyClass;
    jobject instance;
}

- (instancetype)initWithJavaEnvironment:(JavaEnvironment *)environment
                                   name:(NSString *)name
                                   type:(NSString *)type
                             isWritable:(BOOL)isWritable
                              signature:(NSString *)signature {
    self = [super init];
    if (self != nil) {
        env = environment.env;
        protocolPropertyClass = (*env)->FindClass(env, "codes/seanhenry/mockgenerator/entities/ProtocolProperty");
        jmethodID constructor = (*env)->GetMethodID(env, protocolPropertyClass, "<init>", "(Ljava/lang/String;Ljava/lang/String;ZLjava/lang/String;)V");
        instance = (*env)->NewObject(env, protocolPropertyClass, constructor,
            (*env)->NewStringUTF(env, name.UTF8String), // name
            (*env)->NewStringUTF(env, type.UTF8String), // type
            isWritable, // isWritable
            (*env)->NewStringUTF(env, signature.UTF8String) // signature
        );
        _name = [name copy];
        _type = [type copy];
        _isWritable = isWritable;
        _signature = [signature copy];
    }
    return self;
}

- (jobject)javaInstance {
    return instance;
}

@end
