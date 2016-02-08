# Project 1 - Flicks

Flicks is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 24 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [x] Implement segmented control to switch between list view and grid view.
- [x] Add a search bar.
- [x] All images fade in.
- [x] For the large poster, load the low-res image first, switch to high-res when complete.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Use a tab bar icon to switch between list and grid instead of segmented control
- [x] Created podspecs for [ELCodable](https://github.com/Electrode-iOS/ELCodable), an open-source encoding/decoding JSON library at https://github.com/aoriani/ELCodable, so it could be used with Cocoapods

## Video Walkthrough

Here's a walkthrough of implemented user stories:

![Video Walkthrough](walktrough.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Parsing JSON with NSDictionary is painful. My iOS engineers colleagues at WalmartLabs suggested me to use ELCodable, an open-source library developed by them. As one of the requirements was to use Cocoapods to manage dependencies, I had to turn the library in a Cocoapod, which took some time.

I spent some a good deal on architecturing the app. In understand that in class due the time constraints and to keep things simple, most of the logics go in the view controller. However I preffer to modularize my code, creating components with very specific and defined responsabilities. Maybe I over-engineered for this project, but I hope that the extra time will pay off in the next assignents, as I tried to create reusable components.

Layouting in iOS is troublesome. So far we are dealing with absolute positions. Coming from Android, is very strange to me to have to manually calculate and set the content size of a scrollview. I could not just tell a view that it should be bellow another view. I had to manually placed it there. 

Styling the app also took some reasearch time. A good deal had to be done by code instead of setting properties in the storyboard. 


## License

    Copyright 2016 André Oriani

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
