Purpose
--------------

iOS handles full-screen rotation quite elegantly at the view controller level, but if you want to rotate only part opf the screen then things are a bit more awkward.

RotateView provides a simple UIView subclass that can be placed on any non-rotating screen, and will automatically rotate to match the device orientation. You can also specify an offset, size and scale to be applied in portrait/landscape orientation and the view will update to match these settings automatically when the device is rotated.


Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 6.1 / Mac OS 10.8 (Xcode 4.6, Apple LLVM compiler 4.2)
* Earliest supported deployment target - iOS 5.0 / Mac OS 10.7
* Earliest compatible deployment target - iOS 4.3 / Mac OS 10.6

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this OS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


ARC Compatibility
------------------

RotateView works either with or without ARC automatically.


Installation
--------------

To install RotateView into your app, drag the RotateView.h, .m files into your project. You can then create and place RotateView instances either programmatically or using Interface Builder just like any other view.


Properties
---------------------

Because RotateView is designed to function in apps that have rotation disabled, it cannot make use of the normal interface orientation methods (as these will always return portrait mode). Instead, RotateView uses its own logic to determine the interface orientation, based on the current device orientation. If you want to synchronize other views with a RotateView, use the following properties:

    @property (nonatomic, readonly) UIInterfaceOrientation currentOrientation;
    
This returns the current orientation of the RotateView (read only).

    @property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientations;

This returns the interface orientations supported by the RotateView instance as a bitmask. You can override this to prevent RotateView from supporting certain orientations. The default is UIInterfaceOrientationMaskAll on iPad, and UIInterfaceOrientationMaskAllButUpsideDown on iPhone/iPod Touch.

    @property (nonatomic, weak_delegate) IBOutlet id<RotateViewDelegate> delegate;

The optional delegate property can be used if you need finer control over RotateView's orientation support, or if you want to be notificed when it is about to rotate.

There are a number of properties of the RotateView class that can alter its appearance when it is rotated. These should be mostly self-explanatory, but they are documented below:

    @property (nonatomic, assign) CGFloat landscapeScale;
    @property (nonatomic, assign) CGFloat portraitScale;

These properties specify a scale factor to be applied to the RotateView when it rotates to landscape or portrait mode respectively. Defaults to 1.0.

    @property (nonatomic, assign) CGSize landscapeSize;
    @property (nonatomic, assign) CGSize portraitSize;

These properties specify a size to be applied to the RotateView's frame when when it rotates to landscape or portrait mode respectively. By default these match the frame specified when the RotateView is constructed. Note that you will need to update these values if you subsequently resize the frame manually or by using autoresizing or autolayout logic.

    @property (nonatomic, assign) CGPoint landscapeOffset;
    @property (nonatomic, assign) CGPoint portraitOffset;
    
These properties specify an offset to apply to the RotateView when when it rotates to landscape or portrait mode respectively. The offset is relative to the rotated screen, so to offset the view 100 points to the right in landscape mode you would use CGPointMake(100, 0) as the landscapeOffset value. Default to CGPointZero.