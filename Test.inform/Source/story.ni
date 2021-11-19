"The Ghost Ship" by "INFORMational Wizards"
Release along with a website.
Release along with an interpreter.

adjacent-by-doors relates a room (called A) to a room (called B) when A encloses an open door (called D) and the other side of D from A is B. The verb to be adjacent-by-doors to implies the adjacent-by-doors relation.

Definition: a room is is-adjacent-using-doors:
	if it is adjacent-by-doors to the location, yes;
	if it is adjacent to the location, yes;
	no.

Underlying relates various things to one thing. The verb to underlie means the underlying relation. The verb to be under means the underlying relation. The verb to be beneath means the underlying relation.

Instead of looking under a thing which is underlaid by something (called the lost object):
	say "You find [the list of things which underlie the noun]!";
	now every thing which underlies the noun is carried by the player;
	now every thing which underlies the noun does not underlie the noun.
	
Hiding it under is an action applying to one carried thing and one thing. Understand "put [something preferably held] under [something]" as hiding it under. Understand "hide [something preferably held] under [something]" as hiding it under. Understand the commands "shove" and "conceal" and "stick" as "hide".
Check hiding it under:
	if the second noun is not fixed in place, say "[The second noun] wouldn't be a very effective place of concealment." instead.
Carry out hiding it under:
	now the noun is nowhere;
	now the noun underlies the second noun.
Report hiding it under:
	say "You shove [the noun] out of sight beneath [the second noun]."
	
Understand "flip [something switched off]" as switching on. Understand "flip [something switched on]" as switching off. Understand "flip [something]" as switching on.
Understand "search under [something]" as looking under.
Understand "check under [something]" as looking under.
[----------------------------------------Parser-----------------------------------------]
The last command is a text that varies.

The parser error flag is a truth state that varies. The parser error flag is false.

Rule for printing a parser error when the latest parser error is the only understood as far as error and the player's command matches the text "with":
	now the last command is the player's command;
	now the parser error flag is true;
	let n be "[the player's command]";
	replace the regular expression ".* with (.*)" in n with "with \1";
	say "(ignoring the unnecessary words '[n]')[line break]";
	replace the regular expression "with .*" in the last command with "".

Rule for printing a parser error when the latest parser error is the not a verb I recognise error and the player's command matches the text "try to":
	now the last command is the player's command;
	now the parser error flag is true;
	say "(ignoring the unnecessary words 'try to')[line break]";
	replace the regular expression "try to" in the last command with "".
	
Rule for printing a parser error when the latest parser error is the didn't understand error and the player's command matches the text "dial":
	say "You should specify what number you wish to dial to."
	
Rule for reading a command when the parser error flag is true:
	now the parser error flag is false;
	change the text of the player's command to the last command.
[--------------------------------------------------------------------------------------]
The game_state is a number which varies. The game_state is initially 0.
The game_counter is a number which varies. The game_counter is initially 0.
The game_clue is a number which varies. The game_clue is initially 0.
The know_switch is a number which varies. The know_switch is initially 0.
The know_key1 is a number which varies. The know_key1 is initially 0.
The desc_1 is a number which varies. The desc_1 is initially 0.
The desc_2 is a number which varies. The desc_2 is initially 0.
The desc_3 is a number which varies. The desc_3 is initially 0.
The desc_4 is a number which varies. The desc_4 is initially 0.

The carrying capacity of the player is 2.
Understand the command "access" as "open".
Understand "grope for [thing]" as touching.
Understand "feel for [thing]" as touching.
Understand "investigate [thing]" as examining.
Understand "inspect [thing]" as examining.
Understand "look around" as looking.
Understand "smell the air" as smelling.
Understand "look on [thing]" as examining.

Going by name is an action applying to one thing. 
Carry out going by name:
	if the noun is is-adjacent-using-doors:
		say "You walk to [the noun]."; 
		move the player to the noun;
	otherwise: 
		say "You can't go that way."
Understand "go to [any room]" as going by name. 
Understand "move to [any room]" as going by name. 

Does the player mean going by name the northern hallway: it is very likely.

Instead of inserting something into a container:
	if second noun is closed: 
		say "[The second noun] is closed.";
		stop the action;
	if ssize of noun <= ssize of second noun:
		if the player is wearing noun:	
			try taking off noun;
		if the player is wearing noun, stop the action;
		now the noun is inside the second noun;
		say "You put [noun] into [the second noun].".

[----------------------------------Welding Action----------------------------------------]
Welding is an action applying to one carried thing and one carried thing.
Before welding something:
	if the welding unit is not in the location:
		instead say "You don't have any tool to perform welding.";
	if the noun is not carried:
		instead say "You can't see any such thing.";
	if the second noun is not carried:
		instead say "You can't see any such thing."

Understand "weld [something] with [something]" as welding. 
Understand "weld [something] to [something]" as welding. 
[----------------------------------Reload Action----------------------------------------]
Reloading is an action applying to one carried thing and one carried thing.
Before reloading something:
	if the noun is not pistol:
		instead say "No, you cannot reload [the second noun]";
	if the noun is not carried:
		instead say "You can't see any such thing.";
	if the second noun is not carried:
		instead say "You can't see any such thing."

Check reloading:
	if the noun is not carried:
		instead say "You can't see such thing.";
	if the second noun is not carried:
		instead say "You can't see such thing.";
		
Carry out reloading:
	if the actor has the second noun and the actor has the noun:
		if bullet of the second noun >= 1:
			now bullet of the noun is bullet of the second noun + bullet of the noun;
			say "You've successfully reloaded [the noun], now it has [bullet of the noun] rounds.";
			now the second noun is nowhere.

Understand "reload [something] with [something]" as reloading. 
[----------------------------------Shoot Action----------------------------------------]
Shooting is an action applying to one thing.
Before shooting something:
	if the noun is pistol:
		instead say "Are you actually serious?";
	if the noun is not visible:
		instead say "You can't see any such thing."
Check shooting:
	if the noun is not visible:
		instead say "You can't see such thing.";
	if the noun is a room:
		instead say "You can't shoot a room";
		
Carry out shooting:
	if the actor has the revolver pistol:
		if bullet of the revolver pistol >= 1:
			say "You shoot [the noun].";
			now not_broken of the noun is 0;
			decrement bullet of the revolver pistol;
			if the noun is the steel door or the noun is the padlock:
				say "You raise the pistol and aim your shot, your hand steady and stable. The bullet blasts forth at sonic speed, hitting the padlock right in the center of mass. An ear-bleeding metallic impact sound and blinding sparks ensue. You see that the padlock is now completely destroyed.";
				now not_broken of padlock is 0;
			if the noun is the player:
				end the story saying "Several days later, a cargo ship found the MV Valiant adrifting with the gulf stream. After repeated hailing with no response, the crew decided to approach the ship and investigate. To the crew's horror, there's not a single soul on board the ship. There was no sign of violence or ruination, nor any blood splatter or scortch mark. In a panic, the crew fled the ship and drove away as fast as they can. That was the last time men have ever laid their eyes upon the MV Valiant, for every subsequent search and rescue attempts ended in utter failure.";
			if the noun is the porthole window:
				say "Even though designed to withstand the most violent storm, The window is no match for a bullet. It shatters into pieces behind the exiting bullet, and the bullet disappears into the perfect darkness outside. Cold wind pours in from the window, giving you a shivering chill. Suddenly, through the shatter window, you see the blackness jerks, as if it is alive. For a moment you're convinced that you're seeing things, but the blackness twirls faster and faster, then swarms into the cabin...";
				end the story saying "Several days later, a cargo ship found the MV Valiant adrifting with the gulf stream. After repeated hailing with no response, the crew decided to approach the ship and investigate. To the crew's horror, there's not a single soul on board the ship. There was no sign of violence or ruination, nor any shattered window or scortch mark. In a panic, the crew fled the ship and drove away as fast as they can. That was the last time men have ever laid their eyes upon the MV Valiant, for every subsequent search and rescue attempts ended in utter failure.";
		otherwise:
			say "You press the trigger but nothing happens, apparently you're out of ammunition.";
	otherwise:
		say "You don't have anything to shoot."
Understand "shoot [any object]" as shooting. 
Understand "fire at [any object]" as shooting. 
[----------------------------------Dial Action----------------------------------------]
Dialing it to is an action applying to one thing and one number. Understand "dial [something] to [a number]" as dialing it to. Understand "turn [something] to [a number]" as dialing it to.
Check dialing it to:
	if the noun is not a padlock:
		instead say "You don't know how to do that to [the noun].";
	if not_broken of the noun is 0:
		instead say "[The noun] is already being dealt with.";
	unless the player's command matches the regular expression "\d\d\d\d$":
		instead say "The lock takes four digits.".

Carry out dialing it to:
	if the number understood is the passcode of the noun:
		now not_broken of the noun is 0;

Report dialing it to:
	if not_broken of the noun is 0:
		say "The padlock clicks unlocked.";
	otherwise:
		say "You turn the dial, but nothing happens."

Instead of opening the steel door:
	if not_broken of padlock is 1:
		say "You cannot force open the door while there's a sturdy padlock holding it in place.";
	otherwise:
		now the steel door is open;
		say "Congratulations! You've cleared the demo.".

[----------------------------------Read Action----------------------------------------]
Understand the command "read" as something new. 
Reading is an action applying to one touchable thing and requiring light.
Understand "read [something]" as reading.
Check reading:
	if the noun is books:
		say "You really don't want to waste time reading them right now. Better just investigate them.";
	if the noun is not the Captain's Log, say the description instead.
Report reading:
	if the noun is the Captain's Log, say "You skim through the logs as if time is against you, but found nothing worth noting, eveything recorded on the log seems to be normal. According to the last page, the MV Valiant was sailing alone the planned route across the Atlantic Ocean, 'If nothing goes wrong from now on, we would be in America within a week',  Captain Miller wrote." instead.
Instead of reading the Captain's Log for the second time, say "Maybe it's a good idea to exmaine the log more closely."
Instead of reading the Captain's Log for at least three times, say "You have all the information you need from the log."

[----------------------------Out of world Action--------------------------------------]
Requesting the room tally is an action out of world.
Report requesting the room tally: say "Number: [game_counter], passcode [passcode of the padlock]   [passcode of the pistol] [passcode of the wedding picture] [passcode of the books] [passcode of the paper] Game_Clue [game_clue]".
Understand "cheat" as requesting the room tally.

[------------------------------------Kind of Value--------------------------------------]
Every object has a number called not_broken. The not_broken is usually 1.
A ssize is a kind of value. S1 specifies a ssize. Everything has a ssize. The ssize is usually S3.
[ ----------------------------------Every Turn-------------------------------------------]
Every turn: 
	increment game_counter;
	if game_counter is 4 and know_switch is 0, say "[bold type]If this is a room, surely there must be a light switch somewhere[roman type].";
	if game_counter > 12 and know_key1 is 0 and the bed is underlaid by the brass key and the Cabin is lighted and desc_4 is 0:
		now desc_4 is 1;
		say "[bold type]As you look around the small cabin, A small glint coming from under your bed catches your attention.[roman type]".
[ ---------------------------------   Backdrop  -----------------------------------------]
The wall is a backdrop. It is everywhere.
Instead of touching the wall:
	if the player is in the Cabin:
		say "Your hand touches the cold steel wall. you can feel the very slight vibration repeating sporadically, some kind of machine is running not very faraway.";
	otherwise if the player is in the hallway:
		say "Your hand touches the cold steel wall. you can feel the slight vibration repeating sporadically, some kind of giant machine is running somewhere near.";
	otherwise if the player is on the bed:
		say "Your hand touches the cold steel wall near the bed, your finger tip sweeps across the wall surface, it is coarse and unfriendly, yet you feel a strange sense of affinity that you cannot quite explain."
		
[ ---------------------------------Room Setup -----------------------------------------]
[ -----------------------------------------------------------------------------------------]
The player is on the bed.
Before printing the name of a dark room while the player is on the bed, say "Total ".
Rule for printing the name of a dark room while the player is not on the bed: say "".
Rule for printing the description of a dark room while the player is on the bed:
	if desc_1 is 0:
		say "You wake up, from an unbearable headache, it is as if you've been through a terrible nightmare. But what is worse is that you seem to have lost a large portion of your memory. It is a strange feeling - names, languages and general knowledge, of these you know still, but you can't remember the most important things at this moment - where the hell are you. [paragraph break]You open your eyes as the acute headache subsides but you can't see anything. It is the most overwhelming darkness ever - it was not merely the darkness that came out of absence of light, it was much more sinister, almost as if something behind the darkness is watching your every move. You stretch your eyes as wide as possible trying to capture the even dimmest glimmer of light but still nothing but blackness.[paragraph break]You are certain that you're in some kind of a room, the quiet and stale air gives away. Even though you cannot see anything, your other four senses are alright - you can feel the pillow beneath your head and the soft, warm quilt over your body.";
		now desc_1 is 1;
	otherwise:
		say "You can't even see your hands!".
Rule for printing the description of a dark room while the player is in the Cabin:
	if desc_3 is 0, say "It's pitch black, and you can't see a thing.".
		
Rule for printing the locale description of the Cabin: 
	say "[bold type]You can see a steel door[if not_broken of padlock is 1] that is locked under a combination padlock[end if], a table on which is a few paper, a bed, a bookshelf in which are some books, a wardrobe[if the leather coat is in the wardrobe] in which is a leather coat[end if], a closet in which is a few cups, a desk with a built-in drawer. On the desk is a picture decorated inside a frame.[roman type]";
	if desc_2 is 0:
		say "[paragraph break]You are still quite confused about the situation, but you somehow feel a sense of urgency, as if something bad is about to happen. Anyway, you need to get out of the room and find out what this is all about.";
		now desc_2 is 1.

The Cabin is a dark room.  "Spacious ship cabin for a single sailor. The only thing that deviates from the overall pragmatic design is the refined wooden plate floor. There's a single porthole window on the plain steel wall, its rim is a little bit rusty. Despite scattered scratches, bulges, wear and tear on the wall, the cabin withstood the vicissitudes of time.".
The Cabin contains a table. On the table is a few paper. the paper has a number called passcode. The ssize of the paper is S1. The table is fixed in place. The description of the table is "[if not_broken of the item described is 1] A simple wooden table fixed in place. [otherwise]Shit."
A bed is in the Cabin. It is fixed in place. It is a supporter. The description of the bed is "[if not_broken of the item described is 1 and the bed is underlaid by the brass key] A large sized iron-framed crew bed that is soldered to the floor, apparently too luxurious for average crew member. As you exmaine the bed, your eye caught a glimpse of an object. It seems that something is under the bed.[otherwise if not_broken of the item described is 1]A standard sized iron-framed bed that is soldered to the floor. [otherwise if not_broken of the item described is 0] Shit."
A pillow is on the bed. The description of the pillow is "[if not_broken of the item described is 1]Bouncy feather pillow.[otherwise]Shit." The ssize of the pillow is S3.
A quilt is on the bed. The description of the quilt is "[if not_broken of the item described is 1]Soft, handcrafted cotton quilt with monochromatic blue cover.[otherwise]Shit." The ssize of the quilt is S3.
A bookshelf is in the Cabin. It is fixed in place. The bookshelf is an open container. Some books are inside the bookshelf. The ssize of the books are S1. The bookshelf is fixed in place. The description of the bookshelf is "[if not_broken of the item described is 1]A fairly large metallic bookshelf fixed to the wall and ceiling. It is filled with all kinds of books - '[italic type]How to Avoid Huge Ships', 'Beyond Good & Evil', 'Strange Creatures at Sea'[roman type] etc. [otherwise]Shit.". The books have a number called passcode.
Understand "shelf" as bookshelf.
Understand "book" as books.
A wardrobe is in the Cabin. It is fixed in place. It is an open container. A leather coat is inside it. The ssize of the coat is S3. The description of the wardrobe is "[if not_broken of the item described is 1]TODO - Wardrobe [otherwise]Shit.". The leather coat is wearable.
A closet is in the Cabin. It is fixed in place. It is a closed container. It is not openable. It is transparent. A few cups are inside it. The ssize of the cups are S1. The description of the closet is "[if not_broken of the item described is 1]TODO - Closet [otherwise]Shit.".
A porthole window is in the Cabin. It is fixed in place. The description of the window is "[if not_broken of the item described is 1] A single porthole window full of small scratches, the rim is a bit rusty. You cannot see anything through it, it's pitch black outside - you can't even see the moon let alone a single star. Even though the diameter could technically allow a person to crawl through, the window itself is not designed to be opened. [otherwise]Real shit.".
A brass key is under the bed. The description of the brass key is "An old key made of brass."
A desk is in the Cabin. It is fixed in place. It is a supporter. A wedding picture is on the desk. the wedding picture is fixed in place. The wedding picture has a number called passcode. The description of the desk is "A nice sturdy wooden desk modified to be fixed in place to prevent it from moving during stormy weather. A built-in drawer with a keyhole is below its working surface."
The drawer is part of the desk. It is a closed, lockable and locked container. It is fixed in place. The description of the drawer is "[if not_broken of the item described is 1]A sturdy drawer with a built-in keyhole in the front. [otherwise]Shit.". A revolver pistol is inside the drawer. The revolver pistol has a number called passcode. The ssize of the pistol is S1. The brass key unlocks the drawer. The revolver pistol has a number called bullet. The bullet of revolver pistol is 1. The ssize of the drawer is S2.
A light switch is inside the cabin. It is scenery. It is a switched off device. The description of the light switch is "[if not_broken of the item described is 1]A small metal lever switch screwed to the wall. [otherwise]Shit."
Understand "metal lever" as light switch.
Carry out switching off the light switch: 
	if the steel door is closed:
		now the Cabin is dark.

Carry out switching on the light switch: 
	if know_switch is 0:
		if the player is on the bed:
			now the player is in the Cabin;
	now the Cabin is lighted.

Report switching on the light switch:
	if know_switch is 0:
		say "[paragraph break]As soon as you hit the switch, glorious radiance pours down from the ceiling light, filling the room and forcing the darkness to recede. For a moment you are almost blinded by it.";
		now know_switch is 1;
		stop the action.

Carry out opening the steel door: now the Cabin is lighted.
Carry out closing the steel door:
	if the light switch is switched off:
		now the Cabin is dark.

After deciding the scope of the player when the location is the Cabin:
	place the light switch in scope;
	place the bed in scope;
	place the steel door in scope;
	place the wall in scope;
	
Before touching the bed:
	instead say "You can feel the smooth linen bedsheet, a soft pillow. Nothing special about it, but lying in the bed makes you feel at ease."
Before touching the pillow:
	instead say "Bouncy feather pillow, soft and warm to the touch."
Before touching the quilt:
	instead say "Soft, handcrafted cotton quilt."
Before touching the light switch:
	if know_switch is 0:
		say "[if the player is on the bed]You get off the bed, [otherwise]You [end if]grope for any protrusion along the wall. Your finger touches a small metal lever, this must be it!";
		if the player is on the bed:
			now desc_3 is 1;
			now the player is in the Cabin;
			now desc_3 is 0;
		stop the action;
	otherwise:
		instead say "A common metal light switch."
Before touching the player:
	instead say "Limbs? Check. Legs? Check. Head? Check. Eyes? Check. Apparently your eyes are fine, it's just that the room is too dark."
	
Before listening:
	if the player is on the bed, instead say "All you can hear is the sound of silence.";
	if the player is in the Cabin:
		if the Cabin is lighted:
			instead say "You can hear faint hummings of electricity.";
		otherwise:
			instead say "All you can hear is the sound of silence.".
			
Before smelling:
	if the player is on the bed, instead say "You get a sniff of a greasy smell, you must be lying on this pillow for quite some time.";
	if the player is in the Cabin:
		instead say "You can smell thin salt air, indicating sea nearby.";
	otherwise if the player is in the Hallway:
		instead say "You can smell the grease and oil coming from the engine room. The machines seems to be working alright."

Instead of taking the revolver pistol for the first time:
	say "An antique revolver pistol lies silently in the drawer. The model is Webley Mk. IV, a memorial medal for a war veteran of a not so distant war.[paragraph break]";
	say "The moment you see it, you feel something is awakening deep inside your memory, you see the bloody battles unfolding before your eyes. For a moment you're lost in the reminiscence, all things seem so surreal. When you finally find your way back to the reality, you seem to recall something - Lieutenant Commander in navy before leaving, and that shiny Meritorious Service Medal. The next thing comes to your mind is a certain passcode of some importance - [if game_clue is 0][passcode of the padlock][otherwise][passcode of the pistol][end if].[paragraph break]";
	say "You hold the pistol and instinctly hit the break lever, flip the fore-piece forward and look into the cylinder to check how many bullets are left. To your disappointment, it seems there is only one .455 bullet left in the cylinder.";
	increment game_state;
	now the player has the pistol.

Instead of examining the revolver pistol:
	if the player has the revolver pistol:
		say "A Webley Mk. IV .455 revolver pistol. Although it seems pretty shiny and new, upon closer inspection you can see that, despite good maintenance efforts, there are small scratches all over. How many battles it must have been through?";
		stop the action;
	try taking the revolver pistol.

Instead of taking the books:
	say "Why would you take these books with you?"
Instead of taking the wedding picture:
	say "Why would you take the photo with you?"
Instead of taking the paper:
	say "Why would you take these paper with you?"
	
Instead of examining the books for the first time:
	say "You quickly [bold type]skim through[roman type] the book names, some of them sound quite familiar to you. You're quite convinced that you've read them somewhere sometime, but you can't remember any detail regarding any of the books, at all."
Instead of examining the books for the second time:
	say "You [bold type]pick up a few and flick through them[roman type] as you check if there's anything worth noting, but you found nothing particualrly interesting to you. Maybe take another closer look?"
Instead of examining the books for the third time:
	if game_clue is 2:
		say "One particular book piques your interest - [italic type]'Folktales of the Great Old Ones'[roman type]. As you read through it, you see your fragmented memories of yore flying by before your eyes - your childhood fantasies about big bad monsters roaming the ancient Earth, fighting each other for their own agenda. A four-digit code emerges from deep within your memory. - [passcode of padlock]";
	otherwise:
		say "One particular book piques your interest - [italic type]'Death of a Space Man'[roman type]. As you read through it, you see your fragmented memories of yore flying by before your eyes - your childhood fantasies of dreaming of becoming an astronaut and leave the Earth to explore the galaxy, but something interrupts your journey, something gargantuan, ancient and of unspeakable evil. you seem to recall a certain passcode of some importance - [passcode of the books].".

Instead of examining the wedding picture for the first time:
	say "A wedding picture of a happy couple in a decorated wooden frame. The man in the picture looks handsome and confident in his military uniform. You recognize the man in the picture is actually you.";
	if game_clue is 1:
		say "You see a hand-written 4-digit number written in the back of the picture - [passcode of padlock]";
	otherwise:
		say "You see a hand-written 4-digit number written in the back of the picture - [passcode of the wedding picture].".

Instead of examining the paper for the first time:
	say "A few paper files concerning details of the ship - MV Valiant, its crew member, cargo and the current course. You see your name under the title First Mate.";
	if game_clue is 3:
		say "You seem to recall a certain passcode - [passcode of padlock]";
	otherwise:
		say "You seem to recall a certain passcode - [passcode of the paper].".

Instead of examining the Captain's Log for the first time:
	increment game_state;
	now the not_broken of the welding unit is 0;
	now the not_broken of table is 0;
	say "ouch!".

After wearing the leather coat:
	if the player is wearing the leather coat:
		increase carrying capacity of player by 2;
		say "You now have more pockets to store items."

Before taking off the leather coat:
	say "You feel safe and comfy in it, it is not much but it's thick enough to protect you against the cold." instead.

The steel door is a door. The northern hallway is a room. The northern hallway is east of the steel door. The steel door is east of the Cabin and west of the northern hallway. The description of the steel door is "[if not_broken of the item described is 1]This is just a typical steel door on a military vessel - heavy and sturdy. You notice there is an old padlock on the hasp. If you want to go out, you'll definitely need to get rid of this padlock.[otherwise]Shit.".
understand "turn padlock to [any number]" as a mistake ("To open the padlock, try DIAL PADLOCK TO 4 digit number.").
The padlock is part of the steel door. The padlock is scenery. The padlock has a number called passcode. The description of the padlock is "[if not_broken of the item described is 1]Bulky combination padlock with 4 digits, you can dial it to any 4 digit number. Apparently someone put it on there, but who?[otherwise]This padlock cannot stop you now.".

The southern hallway is a room. North of southern hallway is northern hallway. South of northern hallway is southern hallway.
The southern hallway contains a welding unit. The description of the welding unit is "[if not_broken of the item described is 1]An old oxyacetylene welding unit, although it's been sitting there for years, judging by the pressure indicator, it is still usable.[otherwise]Shit.[end if][If the welding unit is in the Hallway] This unit is equipped with wheels, so you can push it to other rooms using direction.[end if]". The welding unit is pushable between rooms.
A bunker door is a door. The southern hallway is north of the bunker door. The bunker door is south of the southern hallway. 
The Engine room is a room. North of the engine room is the bunker door. South of the bunker door is the engine room.

When play begins:
	say "[bold type]Trigger warning: This game deals with violence and suicidal contents.[paragraph break][paragraph break]";
	now the game_clue is a random number from 0 to 3;
	now the passcode of the padlock is a random number from 1001 to 9999;
	now the passcode of the pistol is a random number from 1001 to 9999;
	if the passcode of the padlock is the passcode of the pistol, decrement the passcode of the pistol;
	now the passcode of the wedding picture is a random number from 1001 to 9999;
	if the passcode of the padlock is the passcode of the pistol, decrement the passcode of the wedding picture;
	now the passcode of the paper is a random number from 1001 to 9999;
	if the passcode of the padlock is the passcode of the pistol, decrement the passcode of the paper;
	now the passcode of the books is a random number from 1001 to 9999;
	if the passcode of the padlock is the passcode of the pistol, decrement the passcode of the books.

The Captain's Chamber is a room. South of the Captain's Chamber is the hallway. North of the hallway is the Captain's Chamber.
The Chamber contains a wooden desk. On the wooden desk is the Captain's Log. The ssize of the Log is S1. The table is fixed in place. The description of the wooden desk is "[if not_broken of the item described is 1]TODO - Wooden Desk [otherwise]Shit."

Test a with "switch on light switch / examine steel door / open steel door / look under bed / unlock drawer / open drawer/ take pistol".
