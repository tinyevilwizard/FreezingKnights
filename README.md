# Freezing Knights
Source code for Freezing Knights, a light co-op turn-based RPG made in [Pico-8](https://www.lexaloffle.com/pico-8.php).

Playable on [itch.io](https://tinyevilwizard.itch.io/freezing-knights), [Lexaloffle BBS](https://www.lexaloffle.com/bbs/?tid=50683) and [Newgrounds](https://www.newgrounds.com/portal/view/867560). You can also run `load #freezing_knights` on Pico-8 to load the game.

Soundtrack by OhCurtains available on [Bandcamp](https://ohhcurtains.bandcamp.com/album/freezing-knights).

![freezing_knight_store_battle3](https://user-images.githubusercontent.com/31799336/210188996-3cae9ec1-2b07-4171-ab0c-e9fca4b98720.gif)

### Authors
- Game by [tinyevilwizard](https://twitter.com/tinyevilwizard)
- Music and OhCurtains intro by [OhCurtains](https://twitter.com/ohhcurtains)

### Running the carts
Run the carts from the `src` folder instead of root. That way, the carts can find each others.

Load `start.p8` to start from the main menu. Starting from other carts will prevent the game from working properly.

### Loading modes
The `src/helpers.lua` file has a global variable named `load_mode`, which changes the way the different carts will be loaded based on its value.
- `load_mode=1`: The game will use the name of the cart files. Use this if playing via the `.p8` files or for exporting to web or executable.
- `load_mode=2`: The game will use the Lexaloffle BBS IDs of the carts. Use this for exporting game to Lexaloffle BBS via PNG cart format.

### Modifying shared assets (sprites, maps and sounds)
All game cards share assets such as sprites, maps and the SFXs 53 to 63, so any changes to these assets must be applied to all game carts.
To modify that data without having to update each carts individually:
1. Load `asset_manager.p8`
2. Apply and save changes to sprites, sounds, and map
3. Open `asset_manager.lua` in an external code editor and verify parameters for each carts are set correctly
4. Reload / start `asset_manager.p8` cart
5. Follow instructions to automatically copy data to all carts

Music and SFXs 0 to 52 are not shared between carts, as they each contain a different music track.

### Adding new battle cart
1. Create new empty cart
2. Add cart header content from `BATTLE_CART_HEADER.md`, change cart name at top of file and edit loaded enemies
3. Add new cart to `asset_manager.lua`
4. Follow instructions in `Modifying shared assets (sprites, maps and sounds)`

### Exporting
#### Binary application
1. Go to the `src` folder
2. Load `start.p8`
3. Run `export freezing_knights.bin start.p8 map.p8 rest.p8 ending.p8 battle1.p8 battle2.p8 battle3.p8 boss1.p8 boss2.p8 boss3.p8 boss4.p8 boss5.p8 boss6.p8 boss7.p8`

#### Web application
1. Go to the `src` folder
2. Load `start.p8`
3. Run `export -f freezing_knights.html start.p8 map.p8 rest.p8 ending.p8 battle1.p8 battle2.p8 battle3.p8 boss1.p8 boss2.p8 boss3.p8 boss4.p8 boss5.p8 boss6.p8 boss7.p8`

#### BBS .png
1. Go to the `src` folder
2. Load each cart and type `save freezing_knights_[cart name].png`

### License
[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)
