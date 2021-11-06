# DotChase

This is a [Lua](https://www.lua.org/) and [Love2D](https://love2d.org/) remake of both my first iOS app in Swift, _and_ my first ever game, [Dot Chase](https://apps.apple.com/us/app/dot-chase/id1162110253).

It's a super simple game where you tap a dot that appears on screen. Once tapped it moves and you have to chase it and tap again until timer runs out and you get a score. Mind-blowingly complicated, I know.

## Todo

- [ ] Game needs a timer countdown
- [x] Display a red dot on the screen
- [x] Red dot needs to have a dynamically defined size (for each difficulty level)
- [x] Red dot needs to animate (fast) from it's current position to a new, random, position when player clicks it once
- [ ] On a successful click, increment the player's score
- [ ] Make 2 backgrounds. Bottom is nice gradient, above that is something...else. Both move in parallax when the dot moves -> in the same direction

## Get it running

You need to have [Lua](https://www.lua.org/) and [Love2D](https://love2d.org/) installed. Drop the project directory into the Love2D app and you're good to go.

If you have this open in VSCode and you have the Love2D Support extension installed, just hit `Cmd + L` for mac or `Alt + L` for Windows & Linux.

### Notes
