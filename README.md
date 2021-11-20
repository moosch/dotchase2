# DotChase

This is a [Lua](https://www.lua.org/) and [Love2D](https://love2d.org/) remake of both my first iOS app in Swift, _and_ my first ever game, [Dot Chase](https://apps.apple.com/us/app/dot-chase/id1162110253).

It's a super simple game where you tap a dot that appears on screen. Once tapped it moves and you have to chase it and tap again until timer runs out and you get a score. Mind-blowingly complicated, I know.

## Todo

- [x] Display a red dot on the screen
- [x] Red dot needs to have a dynamically defined size (for each difficulty level)
- [x] Add scene change to game
- [x] Titles scene
- [ ] High Scores scene
- [ ] Gameplay scene
- [x] Set Difficulty scene
- [ ] Countdown timer
- [x] Animate target between sizes (difficulties)
- [x] Animate target position when successfully tapped/clicked
- [x] Increment score on a successful tap/click
- [x] Make 2 backgrounds. Bottom is nice gradient, above that is something...else. Both move in parallax when the dot moves -> in the same direction
- [x] On scene change, call `:destroy` on previous scene to cleanup listeners
- [ ] Store score in...local file?

## Get it running

You need to have [Lua](https://www.lua.org/) and [Love2D](https://love2d.org/) installed. Drop the project directory into the Love2D app and you're good to go.

If you have this open in VSCode and you have the Love2D Support extension installed, just hit `Cmd + L` for mac or `Alt + L` for Windows & Linux.

Debug & inspect while running by opening browser to [http://127.0.0.1:8000/](http://127.0.0.1:8000/)
