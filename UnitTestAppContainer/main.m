#import <Cocoa/Cocoa.h>
#import "JavaEnvironment.h"

int main(int argc, const char *argv[]) {
    [JavaEnvironment shared];
    return NSApplicationMain(argc, argv);
}
