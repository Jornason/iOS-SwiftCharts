Using ShinobiCharts with Swift and iOS8 (Swift)
=====================

This project is a demonstration on how to use ShinobiCharts in a new iOS8 project, using the new Swift language.

> Note, that you'll need an Xcode6 beta, which is available from the Apple developer site at [developer.apple.com](https://developer.apple.com/). This is pre-release software - you can't submit apps built using iOS8 until it is released, and this project won't necessarily represent best practice as we move forward. Consider yourself warned!

![Screenshot](assets/adopting-protocol.png?raw=true)

Building the project
------------------

In order to build this project you'll need a copy of ShinobiCharts. If you don't have it yet, you can download a free trial from the [ShinobiCharts website](http://www.shinobicontrols.com/ios/shinobicharts/price-plans/shinobicharts-premium/shinobicharts-free-trial-form).

If you're using the trial version you'll need to add your license key. To do so, open up __ViewController.swift__ and add the following line after the chart is initialised:

    chart.licenseKey = "your license key"

Contributing
------------

We'd love to see your contributions to this project - please go ahead and fork it and send us a pull request when you're done! Or if you have a new project you think we should include here, email info@shinobicontrols.com to tell us about it.

License
-------

The [Apache License, Version 2.0](license.txt) applies to everything in this repository, and will apply to any user contributions.
