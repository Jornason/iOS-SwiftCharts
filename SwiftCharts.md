# Using Pseudo-Frameworks with Swift on iOS8

### Introduction

Probably the most unexpected announcement from a WWDC of recent years was the
introduction of a new programming language on Monday at WWDC2014. At first
glance Swift appears to be a well-thought-out, modern language, and I think that
as developers we're going to have a lot of fun getting to know Swift and using
it over the coming years.

In addition to swift, the announcement that finally iOS8 will have first-class
support for dynamic frameworks is great news, however, we've all been creating
pseudo-frameworks for years. These are nothing more than specific directory and
symlink structures which contain a static library and a collection of header files.
They've served us well, and until we all get on board with the new world of iOS8
dynamic frameworks, we want to be able to use our existing objective-C pseudo-
frameworks in our new swift apps.

All of the ShinobiControls products are distributed as these pseudo frameworks,
and we'll be reviewing how we adopt the new features made available to us in
Xcode 6 over the coming weeks and months. In this post I'll use the ShinobiCharts
pseudo-framework as an example of how to get started with importing them into a
swift project.

It's worth noting that this process is not necessarily going to be considered
best practice in future. As I mentioned, we're reviewing the new features made
available in Xcode 6, and this includes the dynamic frameworks.

The code for this project is available on Github at ..., but it's pretty simple -
it's probably just as simple to follow along. You can use any existing framework
as a sample, but if you want to grab the ShinobiCharts framework I'll be using here
then you can grab a free trial from our website.


### Bridging An Objective-C Pseudo-Framework into Swift

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

![Creating Single-View Project](assets/project-creation.png)

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

![Creating a bridging header](assets/setting-bridging-header.png)

This tells the compiler which file it should be using to bridge between swift
and objective-C.

You can now go ahead and use any of the classes in the pseudo framework from any
of your swift files. Since we've been using the ShinobiCharts framework, let's
take a look at creating our first chart using swift.


### Creating your first Swift chart

In the same way that you do with objective-C projects, you need to add some
additional frameworks to your project in order that it will build. Add the
following on the __General__ project settings page:

- CoreText.framework
- libc++.dylib
- OpenGLES.framework
- Security.framework

Now you're ready to go! Open up __ViewController.swift__ and update the 
`viewDidLoad` function to match the following:

    override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      let chart = ShinobiChart(frame: view.bounds)
      chart.licenseKey = "<YOUR LICENSE KEY HERE>"
      chart.datasource = self
      chart.autoresizingMask = .FlexibleHeight | .FlexibleWidth
      view.addSubview(chart)
    }

This is just the literal swift translation of the objective-C equivalent:

- `let` is used since we know we don't want to change the chart object once it
has been created.
- `ShinobiChart(frame: ...)` is the swift translation of the objective-C method
`- initWithFrame:`
- We set the `datasource` property to the current object - which means we need
to adopt the `SChartDatasource` protocol and implement the required functions.

To adopt a protocol, add it at the end of the comma-separated list after the
superclass in the class definition:

    class ViewController: UIViewController, SChartDatasource {

![Adopting the SChartDatasource protocol](assets/adopting-protocol.png)

And then implement the 4 required methods as you would in objective-C. Notice that
code completion has automatically created the swift function signatures from the
objective-C methods:

  /* SChartDatasource methods */
  func numberOfSeriesInSChart(chart: ShinobiChart!) -> Int {
    return 1
  }
    
  func sChart(chart: ShinobiChart!, seriesAtIndex index: Int) -> SChartSeries! {
    return SChartLineSeries()
  }
    
  func sChart(chart: ShinobiChart!, numberOfDataPointsForSeriesAtIndex seriesIndex: Int) -> Int {
    return 100
  }
    
  func sChart(chart: ShinobiChart!, dataPointAtIndex dataIndex: Int, forSeriesAtIndex seriesIndex: Int) -> SChartData! {
    let dp = SChartDataPoint()
    dp.xValue = dataIndex
    dp.yValue = dataIndex * dataIndex
    return dp
  }

Most of this is fairly self-explanatory, and follows the same pattern as in objective-C,
but there are a few things that are worth mentioning:

- The return-type in the method signature now appears at the end, after the `->`
symbol. Functions are just named closures in swift, so this follows the closure
syntax.
- All the `NSObject` subclass parameters have exclamation marks at the end of their
types (e.g. `chart: ShinobiChart!`). This is because of the type system in swift
doesn't allow nil-values for variables, unless they are made optional. This is
in direct contradiction to objective-C, where any object reference can be nil.
Therefore, the objective-C objects in the delegate signatures are optionals. The
exclamation mark (`!`) unwraps the optional value - which means that the value will be
set to the parameter, and a run-time error will occur if nil is passed in.

If you run the app up now, then you'll have created your first ShinobiCharts app
using swift!

![My First Swift Chart](assets/my-first-swift-chart.png)


### Conclusion

Swift offers great possibilities for the future of the iOS platform - with
extremely modern features, whilst adding safety around some of the common mistakes
in objective-C. The language is young, and promises to evolve over the coming years,
which is fantastic.

Obviously we've all got a lot of objective-C code still in perfect working order
and Apple has done a lot to ensure that it is fully interoperable with swift - and
in this post we've seen how to integrate existing pseudo-frameworks on iOS.

As I mentioned at the beginning of this post, we haven't yet fully considered the
effect of iOS8 on the ShinobiControls frameworks, but at least now with what you've
learnt in this post you can start playing with ShinobiControls in your new swift
projects.

The code for this is available on GitHub, so you can clone it and have a go on
your own machine. You'll need a copy of ShinobiCharts - you can download a trial
on our website.

We'll have a lot more info about swift on this blog in the coming months, along
with the new features of iOS8, so do keep checking back.

sam