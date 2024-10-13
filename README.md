# Epoch-OriginsMod-Server-Package - Version 2.0

## Epoch 1.0.7.1 & Origins Mod 1.8.3 (Taviana 3.0)

- Tested with infiStar Admin Panel.
- Without BattlEye filter. Edit BattlEye? No way!
- My Server are only with Whitelist or Password. :-)

Have FUN!

## Used mods:

DZAI 2.2.5 - AI Addon for Epoch 1.0.7+ | [GitHub repo](https://github.com/oiad/DZAI)

WICKED AI 2.2.7 | [GitHub repo](https://github.com/f3cuk/WICKED-AI)

ESSV3 | [GitHub repo](https://github.com/AirwavesMan/ESSV3)

epoch-right-click-actions for Epoch 1.0.7+ | [GitHub repo](https://github.com/AirwavesMan/epoch-right-click-actions)

deployAnything for Epoch 1.0.7.1+ | [GitHub repo](https://github.com/oiad/deployAnything)

OriginsBandage | [GitHub repo](https://github.com/Schalldampfer/OriginsBandage)

Service Points for Epoch 1.0.7.1 | [GitHub repo](https://github.com/oiad/service_points)

safe_zones | [GitHub repo](https://github.com/BigEgg17) | Used edited Version from https://pastebin.com/aSsP1vjZ

## Custom Tradercities

I added custom traders! Taviana-Zoo, Antonovka, Ilya, Shtangrad, Aliencamp, Sevastopol (Thx to Gorgy for Map Addons)

## (WAI) Custom static events with rewards ;-)
(dayz_server\WAI\static\default.sqf)

1. Bandit Camp
2. SectorB

## Known problem: 

### Origins-Status-Menu must be hidden.

Users, who join the server, gets a "blood.paa-error". The error must be confirmed. Then the user can toggle with the key "F3" the Origins-Status-Menu for hiding.
This setting will be saved in the client "ArmA 2 Profile".

## Install:

1. Copy the DayZ_Epoch_13.Taviana folder (or *.pbo / use "PBO tool" for packing) to your Arma2 OA\MPMissions folder

	1.1 Enabling or disableing your own settings: dayz_code\configVariables.sqf

2. Copy the dayz_server.pbo folder to your Arma 2 OA@dayz_epoch_server\addons folder

3. Copy the following files into your "@OriginsMod/Addon" folder and replac the pbo-files:

dayz_code.pbo
dayz_code.pbo.DayZEpoch1071.bisign
dayz_anim.pbo
dayz_anim.pbo.DayZEpoch1071.bisign

4. Copy the Bikey-Key "OriginsMod.info_by_Hades_1.8.3.bikey" into your server key folder.

5. Mod serversettings for start order: ca, @originsmod, @dayz_epoch, @dayz_epoch_server

## infiStar

If you use infiStar then deactivate the following setting in your dayz_code\configVariables.sqf

Set it from "1" to "0"

like this:

```
dayz_antihack = 0;
```

## You use ESSV3 & InfiStar?

You have a Problem at spawning with HALO? Clients spawn left down the map into water?

Then use the following fix. Credits to Cherdenko for fixing that bug | [klick me!](https://epochmod.com/forum/topic/43012-release-essv3-enhanced-spawn-selection-updated-for-107/?do=findComment&comment=288727)

Look at your AH.sqf in your dayz_server.pbo (infiSTAR folder). Open that file and search for:

```
					_driver = driver _curVeh;
						_aidriver = false;
						if(!isNull _driver)then
						{
							if(!isPlayer _driver)then
							{
								_aidriver = true;
								
								player setVectorUp [0,0,1];
								player setVelocity [0,0,0];
								player setPosATL _lastPos;
							};
						};
						if(_aidriver)exitWith{hint 'Bad boys, bad boys whatcha gonna do? Whatcha gonna do when they come for you?';systemchat 'AI Drivers not allowed!';}; 
```

Delete it!

## Extra/optional: 

Serverstart with "Steamlink":

```
steam://run/33930//-connect=99.999.999.99%20-port=2302%20-mod=EXPANSION;@OriginsMod;@DayZ_Epoch;%20-nosplash%20-world=empty%20-nopause
```

with password usage:

```
steam://run/33930//-connect=99.999.999.99%20-port=2302%20-PASSWORD=password%20-mod=EXPANSION;@OriginsMod;@DayZ_Epoch;%20-nosplash%20-world=empty%20-nopause
```

## Contact

seppo{at}posteo.de | No support for used mods! Send your Server-IP. I will visit you! ;-)

## Licences

Note the respective licenses of the files from the other GitHub Repositories. Thx to at all publishers and [EpochModTeam](https://github.com/EpochModTeam/DayZ-Epoch)

## _old_

[Epoch 1.0.7](https://github.com/h1gg1baby/Epoch-OriginsMod-Server-Package)