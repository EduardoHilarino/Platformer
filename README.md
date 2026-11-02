# README — 2D Platformer

A 2D platformer developed in **GameMaker Studio 2**, focused on fluid movement, responsive controls, advanced platforming mechanics, and pixel-art visuals.

This project is being developed as part of **Hack Club's Terra**, with regular updates, gameplay improvements, and development logs.

## 1. Project Overview

The main goal of this project is to create a platformer with enjoyable and challenging movement mechanics.

The game focuses on combining running, jumping, dashing, wall interactions, and special movement techniques to navigate increasingly complex levels.

The project takes inspiration from precision platformers such as Celeste, while developing its own gameplay, visual identity, and level design.

**Engine:** GameMaker Studio 2  
**Language:** GameMaker Language (GML)  
**Genre:** 2D Platformer  
**Development Status:** In Development

## 2. Player Movement System

The player controller has undergone a major refactoring to make movement more consistent, organized, and easier to maintain.

### Movement Core Refactoring

The previous movement system was replaced with a centralized controller implemented in `Scr_Player_Core.gml`.

The new controller manages:

- Horizontal movement with acceleration and deceleration.
- Jumping and variable jump height.
- Gravity and falling speed.
- Coyote Time.
- Jump Buffering.
- Wall Jumping.
- Wall Sliding.
- Wall Climbing and grabbing.
- Ground and aerial Dashes.
- Special movement techniques.
- Collision detection and correction.

The physics system uses horizontal and vertical velocity values (`vx` and `vy`) and processes movement using fixed time steps.

This refactoring helps keep physics separate from animations, sound effects, and other gameplay systems.

### Player Controls

| Key | Action |
|---|---|
| A / D | Move left and right |
| Space | Jump |
| Shift | Dash |
| W / S | Vertical directional input |
| C | Grab and climb walls |
| Direction + Shift | Directional Dash |

The controls are designed to support combinations of movements without unnecessary interruptions.

## 3. Dash System

The Dash mechanic received several important improvements.

### Ground and Air Dash

Originally, the player could Dash only while airborne.

The restriction was removed to allow Dashing while grounded, making advanced movement techniques more accessible.

### Eight-Directional Dash

The player can perform a Dash in eight directions:

- Left and right.
- Up and down.
- Four diagonal directions.

The Dash system manages its direction, velocity, duration, and availability through the central movement controller.

### Super Jump and Special Movement

Ground Dashing enables special techniques such as the Super Jump.

By combining a horizontal Dash with a correctly timed jump, the player can perform longer movements.

The movement core also contains additional mechanics for special jumps and wall interactions.

## 4. Dash Visual Effects

The Dash now includes improved visual feedback.

### Dash Particles

The particle system was updated so particles follow the same general direction as the Dash.

Improvements include:

- Correct particle movement in all eight directions.
- Randomized perpendicular spread.
- Random spawn offsets.
- Variable particle velocity.
- Particle lifetime and alpha effects.
- Friction for gradual deceleration.

Previously, some diagonal directions produced incorrect particle movement. This issue was corrected.

### Dash Afterimages

The Dash trail system was adjusted to produce approximately three afterimages per Dash.

Each afterimage preserves the player's current sprite, animation frame, and facing direction.

These effects improve the sensation of speed and make the Dash more visually satisfying.

### Camera Feedback

A camera shake effect is triggered during the Dash to reinforce the movement's impact.

## 5. Player Animations

The player uses a state-based animation system.

The visual states include:

| State | Description |
|---|---|
| IDLE | Standing still |
| RUN | Moving horizontally |
| TURN | Changing direction |
| JUMP | Moving upward |
| FALL | Falling |
| DASH | Performing a Dash |
| DEATH | Death animation |
| WIN | Victory animation |

Animation changes are synchronized with the movement controller.

Additional work was done to improve turning animations and avoid unnecessary sprite resets.

## 6. Collision System

The collision system uses `Obj_Solid` for solid terrain and obstacles.

The movement core handles collision checks during horizontal and vertical movement, including corner corrections.

### One-Way Platforms

A new type of platform was introduced using `Obj_OneWay`.

These platforms allow the player to:

- Jump upward through the platform.
- Pass through its underside.
- Land on the upper surface.
- Stand and move across the platform.

The implementation initially had issues with collision detection, causing the player to fall through platforms.

The detection logic was updated to check the platform's collision bounds and whether the player's feet cross its upper surface while descending.

The landing functionality has been tested successfully, although minor positioning adjustments may still be necessary.

### Collision Improvements

Several tests and debugging sessions were performed to investigate:

- Incorrect platform detection.
- Landing height.
- Player foot positioning.
- Vertical collision behavior.
- Interactions between one-way platforms and the existing controller.

The goal is to keep these improvements compatible with the Dash, Super Jump, and wall mechanics.

## 7. Level Design Updates

The project has received improvements to both its map layout and level-building workflow.

### New Map Layout

A new level layout was introduced, with updated terrain placement and platform positioning.

The revised map is intended to provide more opportunities to explore the movement system and create engaging platforming challenges.

### New Background

A new background image was added to improve the game's appearance and give the environment more visual personality.

Together with the updated map layout, the background helps establish a more complete visual identity for the game.

### Auto Tiling

Auto Tiling was introduced to simplify terrain creation in the GameMaker Room Editor.

It allows terrain blocks to connect automatically based on their neighboring tiles.

Benefits include:

- Faster terrain painting.
- Automatic corner and edge selection.
- More consistent terrain appearance.
- Less repetitive manual placement.
- Easier level editing.

Different tile variations and automatic variation placement have also been explored as possible future improvements.

### Terrain and Collision Separation

The project currently uses solid objects for collision handling.

A possible future optimization is to use Tilemaps for terrain and dedicated collision data for solid regions.

This could simplify map construction and reduce the need for manually resizing or placing large numbers of collision objects.

## 8. Audio and Sound Effects

Sound effects are an important part of gameplay feedback.

The project includes audio events associated with actions such as:

- Jumping.
- Dashing.
- Death and respawning.
- Victory.

The recent controller refactoring revealed issues where the jump and victory sounds were no longer being triggered correctly.

Audio restoration has been addressed through proposed changes to the relevant gameplay events, but the final behavior still needs to be verified in-game.

The goal is for sounds to trigger when gameplay actions actually occur, avoiding repeated playback caused by continuous input checks.

## 9. Death, Respawn, and Checkpoints

The game includes systems for player death, respawning, and checkpoint progression.

These systems are designed to remain independent of the main movement controller.

They manage:

- Death triggers.
- Death animations.
- Player respawning.
- Checkpoint positions.
- Restoring the player to a playable state.

The separation helps prevent the movement refactoring from interfering with other gameplay mechanics.

## 10. Development and Debugging

A significant part of development has involved identifying problems and improving existing systems.

Some of the most important fixes include:

- Improving Dash particle directions.
- Correcting diagonal particle behavior.
- Adjusting Dash afterimage timing.
- Refactoring movement and animation logic.
- Implementing one-way platform collisions.
- Investigating landing position offsets.
- Improving the level-building workflow.

A movement stuttering issue was also traced to an intermittent keyboard cable connection rather than a problem with the physics code.

This debugging process helped separate hardware input issues from actual gameplay bugs.

## 11. Current Features

The project currently includes:

- [x] Horizontal movement with acceleration.
- [x] Variable-height jumping.
- [x] Coyote Time and Jump Buffering.
- [x] Wall Jump and Wall Slide.
- [x] Wall Grab and Climb.
- [x] Eight-directional Dash.
- [x] Ground Dash support.
- [x] Super Jump mechanics in the controller.
- [x] Dash particles with directional spread.
- [x] Dash afterimages.
- [x] Camera shake effects.
- [x] State-based player animations.
- [x] Death and respawn systems.
- [x] Checkpoint system.
- [x] One-way platforms.
- [x] Auto Tiling for terrain creation.
- [x] Updated map layout.
- [x] New background image.

## 12. Known Issues and Planned Improvements

The following areas still require testing or further development:

- [ ] Verify jump and victory audio playback.
- [ ] Polish one-way platform landing alignment.
- [ ] Add automatic random tile variations.
- [ ] Optimize terrain collision creation.
- [ ] Continue improving map design.
- [ ] Create more challenging platforming sections.
- [ ] Further polish visual effects and animations.
- [ ] Test interactions between special jumps, Dash, and different platform types.

## 13. Project Structure

The main gameplay architecture uses the following resources:

```text
GameMaker Project
│
├── Scripts
│   ├── Scr_Player_Core.gml
│   ├── Scr_Player_Animation.gml
│   └── Scr_Player_respawn.gml
│
├── Objects
│   ├── Obj_Player
│   ├── Obj_Solid
│   ├── Obj_OneWay
│   ├── Obj_Particle
│   ├── Obj_rastro
│   └── Obj_shake
│
├── Sprites
│   ├── Player animations
│   ├── Terrain tiles
│   └── Background artwork
│
├── Sounds
│   ├── Jump
│   ├── Dash
│   └── Victory
│
└── Rooms
    └── Platforming levels
```

*This is a simplified overview of the project's main resources, not an exhaustive list of the GameMaker project files.*

## 14. Next Steps

The next development phase will focus on improving level design and making better use of the movement system.

The main priorities are polishing the remaining collision issues, verifying gameplay audio, optimizing the map creation process, and introducing challenges that encourage players to combine different movement techniques.

The overall objective is to turn the current movement-focused prototype into a more complete and polished platforming experience.

---

**Developed using GameMaker Studio 2 and GML.**

**Project status:** Active Development.
