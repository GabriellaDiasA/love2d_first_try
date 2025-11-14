## TO DO
- Animations
  - Not going to worry about this one for now...
- More UI components
  - I think a table component with navigation is unavoidable
  - slider (controller deadzone setting, brightness? setting, etc)
  - text input (player display name setting during character selection screen)
  - focus arrow (cute)
  - joystick icons?! <= rabbithole I bet
  - eventually lots of ingame UI like health bars, inventory, whatever else comes up
    - perhaps the modular system will make this not that bad to generate
    - don't mix contexts: there shouldn't be a UI element called "health bar", that's very game specific
    - therefore make a new context for this. maybe something like "game_ui" straight up
- Player / Agent / Controls abstractions
  - Menu-interaction control schema, Gameplay-interaction control schema, Gameplay-Menu-interaction control schema?
    - All control schemas need action-to-input translation (scroll_up, scroll_down etc need to become a joystick button (...or combination?))
    - All joystick buttons need to have kbmouse equivalence
    - All actions need to be remappable -> this would change the specific action-to-input translation for the current schema and NOTHING ELSE, the rest would be handled
    - Try standardizing action names somewhat. "scroll_up" and "upscroll" should not coexist in the same codebase at all, for instance

## NEXT UP
- Character Select
  - 3 characters, mid-screen
    - names, mock "stat" display, load into selected player character model
    - different config for each one (acceleration, turning acceleration etc)


## ONGOING
- All of the controls stuff

## DONE
- Don't activate dash if transitioning form idle to walking with dash button held
- Build menu routing
- Color handling (multiple inheritance)
- Player / Agent / Controls abstractions
  - Control abstraction is mostly done. Input vs Bindings vs Bind