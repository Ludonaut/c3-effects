# Effects for Construct 3

These are a bunch WebGL shader effects for use with [Construct 3](https://www.construct.net/). Most of them are conversions of old Construct 2 effects I was using. If you spot an error, want to add another effect to this collection or know of a better solution, please [submit a pull request](../../pulls).

## Install

There are two ways to install these effects:

You can either download these effects off [Construct 3's official addon exchange](https://www.construct.net/make-games/addons).

Or you can clone this repository, zip the contents of a folder of an effect you want to install, change the .zip file extension to .c3addon and install it via the Construct 3's Addon manager (go to *Menu -> View -> Install new addon...*).

## How to contribute :sparkles:
0. [Enable Construct 3's Developer Mode](https://www.construct.net/make-games/manuals/addon-sdk/guide/enabling-developer-mode).
1. Clone this repository.
2. Generate a local SSL cert with the following command: `openssl req -new -x509 -keyout server.pem -out server.pem -days 365 -nodes`
3. Add both the *pyserver* script and the cert to your $PATH. (e.g. ~/bin)
4. Run *pyserver* from your addon's working directory.
5. Go to *View -> Addon manager -> Add dev addon...* and put in *https://localhost:8080/addon.json*
6. Restart Construct via Shift+F5 and check if the addon was installed.
7. Make changes to the addon, restart Construct, and repeat until it stops exploding :boom:
8. [Submit a pull request](../../pulls)

## Known Issues:

* dropshadow and separatechannel won't scale correctly.

## Todo:

* add a blur option to drop shadow
* basically any effect made by scirra forum user *Somebody*
* lottes crt
* crt by anata
* vhs
* alphadither
* mode7
* any halfway decent ascii shader
* R0j0hound's outline
