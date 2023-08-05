# Flip Dots iOS

This is an experimental hack I used to push pixels (or dots, rather) to a 14x28 Flip Dot board over UDP. See the [original post here](https://www.tannr.com/2021/03/31/flip-dots/). With a few tweaks this project could send any number of pixels with colors included.

I have no immediate plans to continue work on this project or make it "production ready", this repo is just to share some hacks in case it helps curious minds.

![flip_dots_looping](https://github.com/twstokes/flipdots-ios/assets/2092798/ce338e92-f968-4ad5-8094-9924930afcae)

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
- Enabling and disabling the network connection

It's best to run on an iPad or Mac, but can also run on iPhone.

**Note:** Because the app is responsible for pushing the framebuffers, it must remain active to update routines with the latest frames. Routines that don't need updating, such as freehand, don't have this limitation.

## Installation
In the project's directory, run: `carthage update --use-xcframeworks` to install [swift-gfx-wrapper](https://github.com/twstokes/swift-gfx-wrapper).

### Config

Create a file called "Config.xcconfig" that contains the following keys:
- OPENAI_TOKEN = [insert token string here]

If not playing with the OpenAI API / GPT, you can leave the token blank.
