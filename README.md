# Flip Dots iOS

This is an experimental hack I used to push pixels (or dots, rather) to a 14x28 Flip Dot board over UDP. See the [original post](https://www.tannr.com/2021/03/31/flip-dots/) and the [MCU code](https://github.com/twstokes/flipdots) here. With a few tweaks this project could send any number of pixels with colors included.

I have no immediate plans to continue work on this project or make it "production ready", this repo is just to share some hacks in case it helps curious minds.

![dots-ios](https://github.com/twstokes/flipdots-ios/assets/2092798/e0794297-5664-41f7-9e82-078cc0b065da)

**Some routines it can run:**
- Freehand drawing
- A text clock that _kinda_ works
- A rotating 3D cube
- Endless, perfect pong
- A text scroller
- A _very experimental_ GPT drawer (which really doesn't work yet)
- A mocked stock sticker
- Flipping all the dots from off to on to help with cleaning / calibration

**Other features:**
- Dot inversion mode
- Changing framerate of routines
- Play / pause routines
- Enabling and disabling the network connection

It's best to run on an iPad or Mac, but can also run on iPhone.

**Note:** Because the app is responsible for pushing the framebuffers, it must remain active to update routines with the latest frames. Routines that don't need updating, such as freehand, don't have this limitation.

## Installation
In the project's directory, run: `carthage update --use-xcframeworks` to install [swift-gfx-wrapper](https://github.com/twstokes/swift-gfx-wrapper).

### Config

Create a file called "Config.xcconfig" that contains the following keys:
- OPENAI_TOKEN = [insert token string here]

If not playing with the OpenAI API / GPT, you can leave the token blank.
