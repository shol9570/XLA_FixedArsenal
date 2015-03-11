@XLA_FixedArsenal
================

This is a mod for Arma3. 
This mod improves the way the virtual arsenal works when using 'whitelisting' mode. 
The 'white listing' feature of the (vanilla) arsenal allows scripters to determine what items are or are not available. 
However, the vanilla white-listing has a few issues. E.g. by default, saved outfits that contain non-whitelisted equipment cannot be loaded. 
This mod introduces partial loading, i.e. loading all whitelisted parts of a saved outfit. It also includes fixes and improvements related to the white-listing feature.


Partial Loading
================
Partial Loading means that outfits that contain non-whitelisted or non-existing (classname not found) items can still be loaded, but any item that is non-whitelisted/not found will be skipped. 
If the non-whitelisted item is a uniform, backpack or vest, the currently equipped uniform,backpack or vest (respectively) will be kept.
Outfits that contain non-available (either due to classname-not-found or non-whitelisted) will be highlighted in the virtual arsenal's "load" view.

white = outfit is loadable in its entirety.  
yellow = at least one non whitelisted item   
orange = at least one non existing class (i.e. wrong classname or mod not loaded)  
N.B: orange will take precedence over yellow if both apply  


Better Performance
==================
When opening the "load" menu in a whitelisted arsenal each item in each outfit has to be checked against the whitelist.
This was done in a way where the whitelist was always traversed in its entirety. In this mod, the search stops once the item has been found.


Semantics Change
================
Apart from the indirect changes induced by partial loading, a deliberate change was made to the semantics of white listing. In the vanilla arsenal (and previous versions), any item currently equipped by the soldier was automatically available in the arsenal. (Effectively, the white-list was computed as the white list + any current equipment the soldier had). This has two effects: Firstly, it allows players to duplicate items like grenades even if they are not part of the white-list. Secondly, it makes it hard for players and mission designers to predict what items will be available when a certain player visits the arsenal.

Composite Weapons
==================
This mod introduces proper support for composite weapons, i.e. weapons that have things pre-attached.
(effectively a one-line change, fixing [#20978](http://feedback.arma3.com/view.php?id=20978)

Showcase
===========
This mod is designed to work together in conjunction with my [XLA_RestrictedArsenal.sqf](http://hastebin.com/tixatuvodu.md) script.  
To test that script, try my sample mission [CO8_WhitelistedArsenalShowcase](http://steamcommunity.com/sharedfiles/filedetails/?id=331806334) on steam.

Feedback
==========
Feel free to use this mod's [issue tracker](https://github.com/ImperialAlex/XLA_FixedArsenal/issues) or head over to the [BI forums thread](http://forums.bistudio.com/showthread.php?184838-quot-Fixed-quot-Arsenal-an-Arsenal-improving-workaround/) to discuss this mod.