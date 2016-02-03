## README

This is the source code of [TimeTrial.cc](http://timetrial.cc).

## How does it work?

* Login with your Strava account.
* Start a new challenge.
* Select a segment you love.
* Set a challenge end time.
* Share your challenge and wait for people to join.
* The system records the first attempt of each user who joined.
* When the challenge is over you can see who has won.

## Thechnologies and patterns used

* Rails 5
* Coffeescript
* Event sourcing to tracks user actions
* A kind of **CQRS** adapted to ActiveRecord to genererate timelines for users using the **Fan-out** pattern.

## Author

[Andrea Franz](http://gravityblast.com)
