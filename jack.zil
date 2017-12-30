"Jack's The Bean Stalker main file"

<VERSION XZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"The Bean Stalker|
by Jack Welch"
>

<ROUTINE GO ()
    <CRLF> 
	<CRLF>
    <TELL "After the magical wall was erected around the kingdom, the cost of farm labor skyrocketed as workers from the enchanted forest and fairy prairie were no longer able to cross the border to find jobs. You and your mom were squeaking by until she became sick. Unable to afford insurance, you have had to sell off your assets one by one to keep the farm going." CR CR "Now you are down to your final cow, good old Bessy." CR CR>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <SETG HERE ,FARM>
	<PUTP ,PLAYER ,P?ACTION ,BEAN-PLAYER-R>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>
>

<INSERT-FILE "parser">

"Objects"

<ROUTINE BEAN-PLAYER-R ()
	<COND
		(<N==? ,PLAYER ,PRSO>
           <RFALSE>
		)
		(<AND <PRSO? PLAYER> <VERB? EXAMINE> >
			<TELL "Downtrodden and grubby, but you've got moxie." CR>
			<RTRUE>
		)
	>
	<PLAYER-F>
>

<SYNTAX TALK TO OBJECT = V-TALK>
<SYNTAX TALK OBJECT (FIND PERSONBIT) = V-TALK>

<ROUTINE V-TALK ()
	<COND
		(<FSET? ,PRSO ,PERSONBIT>
			<TELL "You have a nice chat with " T ,PRSO ", who seems be happy to talk to you." CR>
			<RTRUE>
		)
		(T
			<TELL "You didn't really expect to have a conversation with " A ,PRSO "." CR>
		)
	>
>

<SYNTAX DIG = V-DIG>

<ROUTINE V-DIG ()
	<TELL "Digging is for ditches. You're a farmer, so you PLANT stuff." CR>
>	

<SYNTAX PLANT OBJECT = V-PLANT>
<VERB-SYNONYM PLANT BURY SOW>

<ROUTINE V-PLANT ()
	<COND
		(<EQUAL? ,PRSO ,BEAN>
			<PERFORM ,V?DROP ,BEAN>
			<RTRUE>
		)
		(T
			<TELL "You're trying to plant " A ,PRSO "? Are you like *the* worst farmer ever?" CR>
		)
	>
>

<SYNTAX SIT ON OBJECT = V-PERCH>
<SYNTAX GET ON OBJECT = V-PERCH>
<SYNTAX STAND ON OBJECT = V-PERCH>
<SYNTAX CLIMB ONTO OBJECT = V-PERCH>
<SYNTAX CLIMB ON OBJECT = V-PERCH>

<ROUTINE V-PERCH ()
	<COND
		(<AND <FSET? ,PRSO ,SURFACEBIT> <FSET? ,PRSO ,CONTBIT>>
			<TELL "You are now on " T ,PRSO "." CR>
		)
		(T
			<TELL "You can't get on " T ,PRSO ". " CR>
		)
	>
>

<SYNTAX LICK OBJECT = V-LICK>
<VERB-SYNONYM LICK KISS>

<ROUTINE V-LICK ()
	<TELL "How is that in the least bit a desirable thing to do?" CR>
>

<SYNTAX HELP = V-HELP>
<VERB-SYNONYM HELP HINT HINTS ABOUT CREDITS INFO>

<ROUTINE V-HELP ()
	<TELL "This is a text adventure that I wrote while trying to get my head around ZIL one weekend in 2017.||Thanks to the folks at INFOCOM for ZIL and for that matter the Z-machine, and to Jesse McGrew for bringing ZIL back to life by creating the ZILF authoring tool." CR>
>

<VERB-SYNONYM GIVE SELL TRADE>

<ROOM FARM
    (DESC "The Family Farm")
    (IN ROOMS)
    (LDESC "Not much is left of the farm, just the tumble down shack you call home and an old stable. The town is off to the west.")
    (WEST TO PAWNSHOP)
 	(FLAGS LIGHTBIT)
	(UP PER BEANPOLE)
>
  
<ROUTINE BEANPOLE ()
	<COND 
		(<IN? ,BEAN-STALK ,FARM>
			<TELL "You climb up the bean stalk, which goes on and on. Eventually, you push through the clouds and find yourself poking through a lawn." CR CR>
			,GOLF-COURSE 
		)
		(T 
			<TELL "You would like to think that you have nowhere to go but up, but the sad fact is that farmers lack economic mobility." CR>
			<RFALSE>
		)
	>
>

<ROOM PAWNSHOP
    (DESC "Yagmar's Olde Pawn Shoppe")
    (IN ROOMS)
    (LDESC "On the seedier side of town, the windows of the pawn shop are plastered with signs: Paychecks Cashed, BUY AND SELL GOLD, Top Price for Cows! Your farm is back to the east.")
    (EAST TO FARM)
	(UP PER BEANPOLE)
	(FLAGS LIGHTBIT)>
	
<OBJECT YAGMAR
	(DESC "Yagmar")
	(SYNONYM YAGMAR BARBARIAN)
	(IN PAWNSHOP)
	(LDESC "Greasy and perpetually hung over, the proprietor of the pawnshop, Yagmar the Barbarian, stands behind a counter and brims with avarice.")
	(FLAGS PERSONBIT NARTICLEBIT)
	(ACTION YAGMAR-R)
>

<ROUTINE YAGMAR-R ()
	<COND
		(<VERB? GIVE>
			<COND
				(<PRSO? ,COW>
					<TELL "Yagmar looks sideways at the pint-sized cow.||\"Kind of scrawny, but I'll take it. Let's see. Here, take one of these. Now scram.\"||He hands you a somewhat shriveled but vaguely magical legume." CR>
					<REMOVE ,COW>
					<MOVE ,BEAN ,PLAYER>
					<INCREMENT-SCORE 10>
				)
				(<PRSO? ,TURD>
					<TELL "Yagmar squints at the ignoble lump of goose excrement on the counter and raises an eyebrow.||\"And what exactly and I supposed to do with *that*?\" he inquires, pointing towards it with an accusatory index finger.||\"It's a souvenir from the casino,\" you say, trying to sound upbeat. \"It's worth it's weight...\"||Before you can finish, the barbarian swipes the turd from his counter top and produces Bessy. \"Whatever it is, it's guaranteed to be worth more than this viscious miniature cow of yours, which eats like a horse. Here. Take it and get out of here.\"" CR >
					<REMOVE ,TURD>
					<MOVE ,COW ,PLAYER>
					<INCREMENT-SCORE 10>
				)
				(<PRSO? ,MOM>
					<TELL "Yagmar looks her over appraisingly, pokes at her a bit with a soup spoon, and shoves her in a sack.||\"Done and done,\" he says, rubbing his hands together. \"Haven't had one of these in a while, so tell you what I'm going to do.\"||He reaches around the back of the counter and pulls out a fine Italian three-piece suit with fine pinstripes. Very chic. Stunned, you try it on immediately. It fits to a tee. No one will ever mistake you for a lowly farm hand again, by God." CR>
					<REMOVE ,MOM>
					<MOVE ,SUIT ,PLAYER>
					<FSET ,SUIT ,WORNBIT>
					<INCREMENT-SCORE 20>
				)
			>
		)
		(
		<VERB? TALK>
			<TELL "\"" <PICK-ONE ,YAGMAR-BLAH> ".\"" CR>
		)
		(<VERB? EXAMINE>
			<TELL "Seven foot four and 520 pounds. Obey." CR>
		)
		(<VERB? ATTACK>
			<TELL "Yagmar plants a broad palm on your forehead and pushes you backwards from the counter, laughing." CR>
		)	
	>
>

<CONSTANT YAGMAR-BLAH
	<LTABLE
		2
		"You got stuff to trade? Give it to me. Then I give you stuff. Then you leave. That's how it works"
		"Are you just here to gab or do you have something to trade? I'm not getting any younger"
		"I'm not here to jaw-wag, I'm here to trade. Got something? Give it. Don't got something? Go away"
	>
>
	
<OBJECT COUNTER
	(DESC "counter")
	(SYNONYM COUNTER)
	(IN PAWNSHOP)
	(FLAGS SURFACEBIT CONTBIT OPENBIT NDESCBIT)
	(ACTION COUNTER-R)
>

<ROUTINE COUNTER-R ()
	<COND
		(<AND <VERB? PUT-ON> <EQUAL? ,PRSI ,COUNTER>>
			<PERFORM ,V?GIVE ,PRSO ,YAGMAR>
		)
		(<VERB? PERCH>
			<TELL "Yagmar backhands you and you go flying across the pawn shop.||\"Didn't your mother ever teach you any manners?\" asks the barbarian with contempt." CR>
		)
	>
>
	
<ROOM CASINO
	(DESC "Cloud Nine Casino and Resort")
	(IN ROOMS)
	(LDESC "A glitzy casino entirely covered in gold leaf and flashing neon. The game floor is just to the west.")
	(EAST TO GOLF-COURSE)
	(WEST PER ENTER-CASINO)
	(FLAGS LIGHTBIT)
>
	
<ROUTINE ENTER-CASINO ()
	<COND
		(<IN? ,SUIT ,PLAYER>
			<INCREMENT-SCORE 50>
			<JIGS-UP "Having impressed the ogre by literally selling your own mother, you walk triumphantly towards the casino. A smartly dressed steward comes out to greet you and leads you towards the building.||But he keeps walking: around the entrance to the game floor, back behind the parking ramp, down past the laundry area, and finally into the hotel through a rusty door at the rear of the building.||\"Congratulations,\" he says gleefully, handing you a dish towel, \"and welcome to senior management.\"||A tower of dirty dishes looms next to you, tilting precariously alongside an industrial-sized sink fully of opaque, gray water in the steamy hotel kitchen.">
		)
		(T
			<TELL "The ogre refuses to let you enter, but gives you some advice." CR CR>
			<PERFORM ,V?TALK ,OGRE>
			<RFALSE>
		)
	>
>	

<ROOM GOLF-COURSE
	(DESC "Golf Course")
	(IN ROOMS)
	(LDESC "A lush and rambling golf course with a red-carpeted cloud-top path leading west to the casino. Off to the east, the golf course is surrounded by luscious cumulus clouds.")
	(WEST TO CASINO)
	(EAST PER PLUMMET)
	(DOWN SORRY "You can't find the spot where you had climbed up from the beanstalk. The incredibly vigorous lawn must have grown back over the hole.")
	(FLAGS LIGHTBIT)
>

<OBJECT OGRE
	(DESC "orange ogre")
	(SYNONYM OGRE)
	(IN CASINO)
	(ADJECTIVE ORANGE)
	(LDESC "A doddering ogre, covered in cheddar powder and sporting a bad comb over, stands just outside the gilded doors of the casino.")
	(FLAGS PERSONBIT)
	(ACTION OGRE-R)
>

<ROUTINE OGRE-R ()
	<COND 
		(<VERB? GIVE>
			<TELL "\"Keep your stinky old " D ,PRSO ", I don't want it. Germs. So sad.\"" CR>
		)
		(<VERB? TALK>
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<COND
						(<FSET? ,SUIT ,WORNBIT>
							<TELL "\"Hang on a minute,\" the ogre says, holding up a tiny finger as he talks into his cell phone. \"His own mother? Fantastic. Absolutely fantastic. He's here now. Talk later, Yagmar.\"||The ogre pats you on the head, leaving a orange powdery outline of his palm on your forehead. \"Just want to say, what you did, I am so, so impressed. Hugely. Impressed. You're one of us now, come right on in, just over there, to the west. See the door? To the casino? That way.\"" CR
							>
							<RTRUE>
						)
						(T
							<TELL "\"You did well on the goose job, very, very well,\" the ogre confides with a wink. \" This might work out for you. It could be great. Tell you what, if you can show me that you can pull off the kind of deal that I would make myself, I'll not only let you into the casino, I'll hire you on the spot.\"" CR>
							<RTRUE>
						)
					>
				)
				(T
					<TELL "\"" <PICK-ONE ,GOOSE-BLAH> ".\""  CR>
				)
			>
		)
		(<VERB? LICK>
			<TELL "Unable to resist the allure of his cheesy, powdery coating, you lick the ogre.||A putrid flavor fills you mouth. While you spit repeated to try to get the taste out of your mouth, the ogre's tiny hands rub more of the orange powder over the patch of decaying flesh that you had licked clean." CR>
		)
		(<VERB? EXAMINE>
			<TELL "The ogre stands awkwardly just outside the casino, trying to look important." CR>
		)
		(<VERB? ATTACK>
			<TELL "A horde of dark-jacketed thugs with sunglasses descend on you and toss you towards the clouds before you can get near the ogre." CR CR>
		 	<GOTO ,FARM>
		)
	>
>

<CONSTANT GOOSE-BLAH
	<LTABLE
		2
		"You want to do something useful? See those birds over there, pooping up my lawn? My very very wonderful, amazing -- I guarantee you, this is the best lawn. I was just saying the other day, this lawn is really something else. And what happens? Geese. Geese from over the border are all over my lawn. They're not our geese, they are taking lawn away from our geese. These are terrorist, radical terrorist geese, and I won't put up with it. These geese, did you know that's one than more goose, right? Anyhow, these geese have got to go. You get rid of them, and I promise you, I promise you that I will make things make things right. Now, go do something about them"
		"Let me give you some advice, do you want some advice? Of course you do, you're saying, I wonder what advice he has to give me, and now I'm giving it to you, so you should listen because they say my advice is the best advice. I give the best advice, because when I am telling people things ,about advice, they all say, he has the best advice. So, my advice is that you get those birds, those horrible, they're not ducks, you know. Ducks are patriotic. There are television shows about ducks, and I saw one last week, so this is not at all about ducks. Those birds are geese, and I have had it up to here, right here, with them. So, if you get rid of them, then maybe we can talk"
		"You want to come it? It's great isn't it. The big, most expensive casino ever. Great for families. I say bring the kids on in, never too early. Because we're all about family values. But not geese. Geese don't think like you are I do, and not because they're birds. I like birds, I love birds. Just the other day, I was talking to a flock of birds down by the pool, and they were all fine and one of them was like, you really like birds, don't you, and I do, but just not geese. Say, if you want to do something useful for your old orange ogre buddy, maybe I can do a little deal-making for you, try to get you in the door. So, why not just head over there and see if you can't get rid of those geese"
	>
>


<OBJECT FLOCK
	(DESC "flock of geese")
	(SYNONYM FLOCK GEESE BIRDS)
	(IN GOLF-COURSE)
	(LDESC "Some immigrant geese wander the carefully tended lawn brazenly.")
	(ACTION FLOCK-R)
>

<OBJECT TURD
	(DESC "goose turd")
	(SYNONYM TURD DROPPING)
	(ADJECTIVE GOOSE)
	(IN GOLF-COURSE)
	(FLAGS TAKEBIT)
	(ACTION TURD-R)
>	


<ROUTINE TURD-R ()
	<COND 
		(<VERB? EXAMINE>
			<TELL "As goose droppings go, this is a fine one." CR>
		)
		(<VERB? EAT>
			<TELL "The first few nibbles put you off." CR>
		)
	>
>
		
<ROUTINE FLOCK-R ()
	<COND 
		(<VERB? EXAMINE> 
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<TELL "From their position of safety on the cloud bank to the east">
				)
				(<NOT<IN? ,COW ,GOLF-COURSE>>
					<TELL "Lounging about on the lush, well-manicured lawn">
				)
			>
			<TELL ", the geese go about their business (in every sense), ignoring you." CR>
			<RTRUE>
		)
		(T
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<TELL "Perched on an insubstantial cloud bank, the geese are safely beyond your grasp (and Bessy's slavering maw)." CR >
				)
				(T
					<TELL "The geese flutter about clearly avoiding you." CR>
				)
			>
		)
	>
>

	
<ROUTINE PLUMMET ()
	<TELL "As there are no safety nets in the kingdom, you fall through the fluffy clouds and land right where you started: in the dirt." CR CR >
	,FARM
>
	
<OBJECT COW
    (DESC "cow")
    (SYNONYM HEIFER BESSY COW)
    (ADJECTIVE TINY SMALL DIMINUTIVE MINUSCULE)
    (IN FARM)
	(FLAGS TAKEBIT)
	(LDESC "Accustomed to starvation, the jittery cow stares unblinkingly into space.")
    (FDESC "Bessy the cow anxiously chews her last wad of cud.")
	(ACTION COW-R)
>
	
<ROUTINE COW-R ()
	<COND 
		(<VERB? EXAMINE> 
			<TELL "Thanks to years of malnutrition, the stunted cow is the size of a chihuahua." CR>
		)
		(<VERB? DROP>
			<TELL "As the diminutive cow lands on her spindly legs, she emits a yappy \"moo\"." CR>
			<MOVE ,COW ,HERE>
			<COND
				(<IN? ,COW ,GOLF-COURSE>
				 	<TELL CR "Driven by the sort of blood lust that one rarely sees in cows, Bessy rips across the lawn after the geese. The geese erupt into flight and settle a short distance away on a cloud bank. From that safe harbor, they honk mockingly at Bessy, who stands at the very edge of the lawn vibrating with anger and yapping madly at them." CR>	
					<PUTP ,FLOCK ,P?LDESC "The non-indigenous fowl cluck and bristle with indignity from atop the neighboring clouds, while they keep a suspicious eye on your cow.">
					<MOVE ,MOM ,FARM>
					<INCREMENT-SCORE 10>
				)
			>
			<RTRUE>	
		)
		(<VERB? TAKE PUSH ATTACK>
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<TELL "Now obsessed with her mortal enemies, the geese, Bessy snaps at you menacingly as you get near her. Since you value your hands, you let the murderous cow be. She growls at the birds, her rage barely contained." CR >
					<RTRUE>
				)
			>
		)
	>
>

<OBJECT MOM
	(DESC "your mom")
	(SYNONYM MOM MOTHER)
	(ADJECTIVE MY YOUR)
	(FLAGS NARTICLEBIT FEMALEBIT)
	(FDESC "You haven't seen your mom out of her sick bed in years, but there she is carving furrows in the soil with the stub of a twisted stick, literally scratching out a meager existence.")
	(LDESC "Your mom is hunched over, knees deep in the loam, massaging the goose droppings into the soil with her raw hands.")
	(ACTION MOM-R)
>

<ROUTINE MOM-R ()
	<COND
		(<VERB? TAKE>
			<TELL "You pick her up like a bundle of kindling." CR>
			<MOVE ,MOM ,PLAYER>
			<FSET ,MOM ,TOUCHBIT>
			<RTRUE>
		)
		(<VERB? DROP>
			<TELL "Your mom complains under her breath as you set her down a bit too abruptly.||She murmurs something to the effect that the farm work won't do itself and ">
			<COND 
				(<IN? ,MOM ,FARM>
					<TELL "goes back churning the soil." CR>
				)
				(
					<TELL "perhaps something about how little help you are what with your beanstalk growing, and she marches herself back to the farm." CR>
					<MOVE ,MOM ,FARM>
				)
			>
			<RTRUE>
		)
		(<VERB? TALK>
			<TELL "She can't stop talking about how miraculous it is that just as she was praying for better crop yields, it began to rain fertilizer." CR>
		)
		(<VERB? EXAMINE>
			<COND
				(<IN? ,MOM ,FARM>
					<TELL "She seems to be doing a good job, although she isn't moving as quickly as she used to." CR>
				)
				(T
					<TELL "She hangs loosely under your arm as you carry her around like a sack of potatoes."CR >
				)
			>
		)
		(<VERB? ATTACK>
			<TELL "You are no match for your mother's ninja skills." CR>
		)
	>
>	
			
<OBJECT BEAN
	(DESC "magic bean")
	(SYNONYM BEAN)
	(ADJECTIVE MAGIC)
	(FLAGS TAKEBIT)
    (FDESC "The bean's magical aura glows dimly.")
	(ACTION BEAN-R)
>
	
<ROUTINE BEAN-R ()
	<COND 
		(<VERB? EAT> 
			<TELL "You shortsightedness would be applauded by those in charge of the kingdom, but you realize that if you ate the bean, you and your mom would have no crop come harvest time and that would be the end of your farm." CR>
		)
		(<VERB? DROP> 
			<COND
				(<EQUAL? ,FARM ,HERE>
					<TELL "When the bean touches the soil, it burrows in furiously, ejecting dirt in all directions. After a moment, the ground shakes and a massive beanstalk shoots upward." CR>
					<REMOVE ,BEAN>
					<MOVE ,BEAN-STALK ,FARM>
					<RTRUE>
				)
				(T
					<TELL "The bean lays unimpressively on the concrete floor." CR>
					<MOVE ,BEAN ,HERE>
				)
			>	
		)
		(<VERB? EXAMINE>
			<TELL "The bean glows faintly. It is either magical or radioactive." CR>
		)
	>
>
	
<OBJECT BEAN-STALK
	(DESC "beanstalk")
	(SYNONYM BEANSTALK STALK)
	(ADJECTIVE HUMONGOUS GREEN)
	(FDESC "A humongous green beanstalk with broad, leathery leaves reaches up through the clouds.")
	(LDESC "The beanstalk towers over your farm and for that matter, the town as well.||Down the road, you expect you'll be getting some angry letters from the home owner's association.")
	(ACTION BEAN-STALK-R)
>

<ROUTINE BEAN-STALK-R ()
	<COND 
		(<VERB? CLIMB> 
			<DO-WALK P?UP>
		)
	>
>

<OBJECT SUIT
	(DESC "suit")
	(SYNONYM SUIT)
	(ADJECTIVE FANCY BUSINESS)
	(LDESC "A fancy business suit, sharply tailored and top quality.")
	(FLAGS WEARBIT TAKEBIT)
>
	
<ROUTINE INCREMENT-SCORE (NUM)
	<SETG SCORE <+ ,SCORE .NUM>>
>