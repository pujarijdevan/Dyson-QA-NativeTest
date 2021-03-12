# Dyson Take Home Test - QA

Thanks for your interest in joining Dyson and congratulations for reaching the next stage! 

This is the first part of your technical assessment. We want to get to know you better as a Test Engineer and gain an insight into how you think, as well as your craftmanship on writing automation tests.

You'll be given an iOS application which fetches weather data, and displays it on the screen. We'd like you to work your magic on it, and, like a true test wizard - tell us if this Weather feature can be merged to our main codebase.

Make sure you create your own branch from master and leave meaningful commit messages. 
Report any potential bugs found in a clear manner.

Once we're reviewed your solution, if we like what we see, we will invite you to a more detailed discussion where we can go through your approach in completing this challenge.

Please DO NOT make your solution or this test project publicly available, and do not share it on any source code hosting service (eg GitHub). 
You can send us your solution as a zipfile or alternatively add it on a filesharing service (eg. Dropbox).

Good luck!
 

## Prerequisites

* Xcode 12.2 or higher
* Cocoapods (you will need to run 'pod install' from the command line)
* Internet access (at runtime)

## Knowledge areas tested

* Knowledge in Source control 
* UI Automation Testing
* Functional testing 
* Test Reporting

## App Description

The app navigates through 3 screens (named Alpha, Bravo, Charlie) that do the following:
1. Checks for internet reachability before proceeding
2. Downloads a JSON payload
3. Displays some property from the JSON payload

Each screen features images, dynamic text labels and a "Next" button

## Feature Description

Feature: Weather
  In order to improve my hike today
  As a keen hiker
  I want to be able to view today's weather

Scenario: Get the high level weather forecast
Given I have an internet connection
When I have successfully downloaded the weather data
Then I can see the weather and temperature for today

## Challenge Steps

We expect you to test this feature, with both automation and manual techniques.

1. Run the app in the simulator and try to understand the desired functionality
2. Get in the testing mindset and run your inquisitive eyes over the screens, analysing the given feature thoroughly
3. Add automated tests to cover the functionality of the app

Note: You will be scored against your approach of testing, architecture of code, as well as bug analysis and reporting

Some possible talking points to consider for the next stage of the interview process:

*Code structure
*Areas you could improve if you had more time
*Working with app developers, how could you make this more reliable, stable and repeatable. 



