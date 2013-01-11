# UIView-Debug

UIView category that swizzles initWithFrame and initWithCoder to add bounding boxes to all views.

## In Action

<a href="https://raw.github.com/xrolfex/UIView-Debug/master/_image0.png" alt="Screenshot of uiview debug view with bounding boxes.">
<br />
<a href="https://raw.github.com/xrolfex/UIView-Debug/master/_image1.png" alt="Screenshot of uiview debug view with alert details about a view triple clicked on.">

## Implementation Details

You can override the class method of load to use the objc runtime to exchange the methods with your new methods.
There is a gesture recognizer added to all view that allows you to triple tap to get detailed information about the view.

```objective-c
+ (void)load
{
    // The "+ load" method is called once, very early in the application life-cycle.
    // It's called even before the "main" function is called. Beware: there's no
    // autorelease pool at this point, so avoid Objective-C calls.
    Method original, swizzle;
    
    // Get the "- (id)initWithFrame:" method.
    original = class_getInstanceMethod(self, @selector(initWithFrame:));
    // Get the "- (id)swizzled_initWithFrame:" method.
    swizzle = class_getInstanceMethod(self, @selector(swizzled_initWithFrame:));
    // Swap their implementations.
    method_exchangeImplementations(original, swizzle);
    
    // Get the "- (id)initWithCoder:" method.
    original = class_getInstanceMethod(self, @selector(initWithCoder:));
    // Get the "- (id)swizzled_initWithCoder:" method.
    swizzle = class_getInstanceMethod(self, @selector(swizzled_initWithCoder:));
    // Swap their implementations.
    method_exchangeImplementations(original, swizzle);
}
```

## Usage

There is nothing else required but to import UIView+Debug.h into your precompiled header (.pch).

``` objective-c
#import "UIView+Debug.h"
```

## Sample Project

The sample project included is for iOS6 and arc.

## Requirements

iOS6 and ARC, the project can be ported back by removing the autolayout constraints code.

## //TODO:

- Clean up code.

## Credits

UIView-Debug Created By [Eric Rolf](https://github.com/xrolfex/).

## Contact

[Eric Rolf](https://github.com/xrolfex/)

[@Eric_Rolf](https://twitter.com/eric_rolf)

## License

UIView-Debug is available under the MIT license.
