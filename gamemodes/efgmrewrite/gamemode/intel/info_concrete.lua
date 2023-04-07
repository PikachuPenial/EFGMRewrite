Intel.Concrete = {}

Intel.Concrete.IntMapName = "efgm_concrete"
Intel.Concrete.FancyMapName = "Concrete"
Intel.Concrete.IntelColor = Color(130, 180, 130)
Intel.Concrete.RaidTime = 15 -- in mins
Intel.Concrete.Size = "Medium"

Intel.Concrete.Description = "A large and once thriving city, now abandoned by both the military and civilians. " ..
"While this location has many long sight lines, close quarter engagements are not uncommon due to the handful of " ..
"buildings and warehouses dotted around the area. As such, your choice of weapon here should be dependent " ..
"on what you plan to do, and where you plan to go."

-- asking chatgpt to tell me how to phrase "scaffolding that isnt osha compliant" may be a new low
-- and it didnt even give me good suggestions ffs
Intel.Concrete.Features = "Although Concrete seems generic, there is more to it than a bunch of abandoned buildings. " ..
"The hotel looming over the location makes the roof a great spot for snipers, though its claustrophobic floors " ..
"and OSHA non-compliant scaffolding allows for people to contest the roof with little difficulty. The web of underground tunnels " ..
"and the extract they lead to may sound like a good deal for rats and other would-be loot goblins, but good luck finding your " ..
"way without a flashlight. And the mildly vandalized garage door at the edge of the location appears to never have been opened, " ..
"although it could be extremely lucrative to try."

Intel.Concrete.ExfilsDescription = "Concrete has no shortage of extraction points, though many of them are unreliable, " ..
"hard to reach, or have prerequisites that need to be completed before they can be used. "


Intel.Concrete.Extractions = {}

Intel.Concrete.Extractions[1] = {}
Intel.Concrete.Extractions[1].Name = "Sewer Manhole"
Intel.Concrete.Extractions[1].Time = 30
Intel.Concrete.Extractions[1].IsGuranteed = false
Intel.Concrete.Extractions[1].Description = "A heavy metal manhole, located in a grassy field, just south of the two white warehouses. " ..
"As it takes a long time to extract with no surrounding cover, the sewer manhole can be a life saver if the raid is almost over, " ..
"but is dangerous and risky to use nonetheless."
Intel.Concrete.Extractions[1].Conditions = ""

Intel.Concrete.Extractions[2] = {}
Intel.Concrete.Extractions[2].Name = "Railway to Belmont"
Intel.Concrete.Extractions[2].Time = 10
Intel.Concrete.Extractions[2].IsGuranteed = false
Intel.Concrete.Extractions[2].Description = "A metal gate, located at the eastern end of the southern railroad tracks. " ..
"The extract is shielded from most sides, thanks to the large building blocking visibility from both the north and from the hotel. " ..
"Furthermore, the gate has a relatively quick extraction time, with no prerequisites to boot, making it one of the safest extracts in Concrete."
Intel.Concrete.Extractions[2].Conditions = ""

Intel.Concrete.Extractions[3] = {}
Intel.Concrete.Extractions[3].Name = "ZB-1337"
Intel.Concrete.Extractions[3].Time = 20
Intel.Concrete.Extractions[3].IsGuranteed = true
Intel.Concrete.Extractions[3].Description = "An expertly camouflaged door situated in an underground tunnel. This extract is unique, as it is " ..
"the only extract available to everybody, all the time, with no prerequisites. While the extraction point is lit up, the rest of the tunnel system is extremely dark, " ..
"making it easy for people to sneak up and ambush you while you wait for the extract's 20 seconds to be over."
Intel.Concrete.Extractions[3].Conditions = ""

Intel.Concrete.Extractions[4] = {}
Intel.Concrete.Extractions[4].Name = "Getaway Driver"
Intel.Concrete.Extractions[4].Time = 10
Intel.Concrete.Extractions[4].IsGuranteed = true 
Intel.Concrete.Extractions[4].Description = "A white, somehow windowless truck behind a gate in the northwestern corner of the location. " ..
"The extraction point is very safe, as crouching in the rear of the truck shields your entire body from virtually every angle. The only downside " ..
"to using this extract (apart from its prerequisites) is that the extract is very claustrophobic, and anybody with a grenade can easily flush you out."
Intel.Concrete.Extractions[4].Conditions = "The gate leading to the truck can be temporarily opened by pressing the button on the top floor of the red, " ..
"windowed building in the western part of the map. While the truck can be easily reached without opening the gate, the driver " ..
"(probably a client of the guy who built the ZB-1337 door) will enigmatically refuse to let you extract unless the gate has been opened."

Intel.Concrete.Extractions[5] = {}
Intel.Concrete.Extractions[5].Name = "USEC Helicopter"
Intel.Concrete.Extractions[5].Time = 20
Intel.Concrete.Extractions[5].IsGuranteed = true
Intel.Concrete.Extractions[5].Description = "A combine helicopter atop a red building, next to the railroad tracks. While the USEC helicopter " ..
"may have more easily accessable alternatives, the helicopter itself provides excellent cover, if only from one angle at a time, " ..
"and is a guranteed extract to everyone once the button has been pressed, making it a worthy rival to the getaway driver's truck."
Intel.Concrete.Extractions[5].Conditions = "While the extract is easily reachable just by climbing up the ladders and scaffolding surrounding the building, " ..
"the helicopter pilot (who may or may not be the getaway driver) will deny you an extraction unless you've pressed the button in the entrance to the bunker. " ..
"Godspeed."