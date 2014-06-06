# Using ShinobiCharts with Swift on iOS8

### Introduction

Probably the most unexpected announcement from a WWDC of recent years was the
introduction of a new programming language on Monday at WWDC2014. At first
glance Swift appears to be a well-thought-out, modern language, and I think that
as developers we're going to have a lot of fun getting to know Swift and using
it over the coming years.

Obviously my first question was "how can I use ShinobiControls from Swift?", and
I'm sure it was yours too. We'll be reviewing how we adopt the new features made
available to us in Xcode 6 over the coming weeks and months, but I want to know
how to make it work now.

In this post I'll review the steps you need to go through to integrate an 
old-style framework on iOS with Swift (not to be confused by the new dynamic
frameworks introduced in iOS8). This is how all the different ShinobiControls
products are distributed, and so this represents the approach to getting them
to work in Xcode 6 beta.

It's worth noting that this process is not necessarily going to be considered
best practice in future. As I mentioned, we're reviewing the new features made
available in Xcode 6, and this includes the dynamic frameworks.

The code for this project is available on Github at ..., but it's pretty simple -
it's probably just as simple to follow along.


### Bridging ShinobiControls into Swift

There is a lot of information in the excellent documentation for Swift about
the interoperability between swift and objective-C - so I won't go into too much
detail here. We're going to use ShinobiCharts as as sample for this post - which
is distributed as a pseudo-framework for iOS. This represents objective-C code,
and therefore we need to bridge it into Swift.

Create a new single-view project, selecting Swift as the language of choice. To
import the framework, you'll have to drag it in. For some reason, the project
template created by this Xcode 6 beta doesn't have a "Frameworks" group, so create
one of those and drag __ShinobiCharts.framework__ from the finder into this group,
selecting that it should copy it into place. This will make sure that the project
links against the framework, and is the same approach you could have used in the
past.

IMAGE HERE

In order for swift to be aware of the classes and methods available in any
objective-C, you have to provide a so-called bridging header. This is a simple
header file which contains all the relevant headers for the objective-C classes
you wish to be able to reference. Now, if you create an objective-C class in a
swift project, or vice-versa, then Xcode will create a bridging header for you.
However, this isn't the case for frameworks, therefore we will create one
ourselves.

Create a new header file as part of the project and call it 
__SwiftCharts-Bridging-Header.h__ - the conventional name for bridging headers.
Add the following line to the newly created file:

  #import <ShinobiCharts/ShinobiChart.h>

Here we're just importing the standard header used for ShinobiCharts - you can
add any other objective-C headers that you wish to call from swift.

The other thing we need to do is to make sure that Xcode knows that it should
treat this file as a bridging header. Again, this would have been set up for you
had you created an objective-C file in the swift project, but since we're importing
a framework, we have to do it ourselves.

Open the build settings for the __SwiftCharts__ target and search for the 
__Objective-C Bridging Header__ setting - set it to the following string:

  $(SRCROOT)/SwiftCharts/SwiftCharts-Bridging-Header.h

IMAGE HERE

This tells the compiler which file it should be using to bridge between swift
and objective-C.


### Creating your first Swift chart


### Conclusion

