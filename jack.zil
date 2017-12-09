"Jack The Bean Stalker main file"

<VERSION ZIP>
<CONSTANT RELEASEID 1>

"Main loop"

<CONSTANT GAME-BANNER
"The Bean Stalker|
by Jack Welch"
>

<ROUTINE GO ()
    <CRLF> 
	<CRLF>
    <TELL "After the magical wall was erected around the kingdom, the cost of farm labor skyrocketed as workers from the enchanted forest and fairy prairie were no longer able to cross the border to find jobs. You and your mom were squeaking until she became sick. Unable to afford insurance, you have had to sell off your assets one by one to keep the farm going." CR CR "Now you are down to your final cow, good old Bessy." CR CR>
    <INIT-STATUS-LINE>
    <V-VERSION> <CRLF>
    <SETG HERE ,FARM>
    <MOVE ,PLAYER ,HERE>
    <V-LOOK>
    <MAIN-LOOP>
>

<INSERT-FILE "parser">

"Objects"

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
				)
				(<PRSO? ,TURD>
					<TELL "Yagmar squints at the ignoble lump of goose excrement on the counter and raises an eyebrow.||\"And what exactly and I supposed to do with *that*?\" he inquires, pointing towards it with an accusatory index finger.||\"It's a souvenir from the casino,\" you say, trying to sound upbeat. \"It's worth it's weight...\"||Before you can finish, Victor swipes the turd from his counter top and produces Bessy. \"Whatever it is, it's guaranteed to be worth more than this godforsaken miniature cow of yours, which eats like a horse. Here. Take it and get out of here.\"" CR >
					<REMOVE ,TURD>
					<MOVE ,COW ,PLAYER>
				)
			>
		)
	>
>
	
<ROOM CASINO
	(DESC "Cloud Nine Casino and Resort")
	(IN ROOMS)
	(LDESC "A glitzy casino entirely covered in gold leaf and flashing neon. The game floor is just to the west.")
	(EAST TO GOLF-COURSE)
	(FLAGS LIGHTBIT)>
	
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
>

<OBJECT FLOCK
	(DESC "flock of geese")
	(SYNONYM FLOCK GEESE BIRDS)
	(IN GOLF-COURSE)
	(DESCFCN FLOCK-DESC-F)
	(ACTION FLOCK-R)
>

<OBJECT TURD
	(DESC "goose turd")
	(SYNONYM TURD)
	(ADJECTIVE GOOSE)
	(IN GOLF-COURSE)
	(FLAGS TAKEBIT)
>

<ROUTINE FLOCK-DESC-F (RARG)
	<COND 
		(<EQUAL? .RARG ,M-OBJDESC?>
			<RTRUE>
		)
		(T
			<TELL "Some immigrant geese ">
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<TELL "cluck and bristle with indignity from atop the neighboring clouds, while they keep a suspicious eye on your cow." CR>
					<RTRUE>
				)
				(T
					<TELL "wander the carefully tended lawn brazenly." CR>
				)
			>	
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
			<TELL "Perched on an insubstantial cloud bank, the geese are safely beyond your grasp (and Bessy's slavering maw)." CR >
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
				)
			>
			<RTRUE>	
		)
		(<VERB? TAKE>
			<COND
				(<IN? ,COW ,GOLF-COURSE>
					<TELL "Now obsessed with her mortal enemies, the geese, Bessy snaps at you menacingly as you attempt to grab her. Since you value your hands, you let the murderous cow be. She growls at the birds, her rage barely contained." CR >
					<RTRUE>
				)
			>
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
					<TELL "When the bean hits the soil it burrows in furiously, ejecting dirt in all directions. After a moment, the ground shakes and a massive beanstalks shoots upward." CR>
					<REMOVE ,BEAN>
					<MOVE ,BEAN-STALK ,FARM>
					<RTRUE>
				)
				(T
					<TELL "The bean lands on the concrete floor and just sort of lays there unimpressively." CR>
					<MOVE ,BEAN ,HERE>
				)
			>	
		)
	>
>
	
<OBJECT BEAN-STALK
	(DESC "beanstalk")
	(SYNONYM BEANSTALK STALK)
	(ADJECTIVE HUMONGOUS GREEN)
	(FDESC "A humongous green beanstalk with broad, leathery leaves reaches up through the clouds.")
	(LDESC "The beanstalk towers over your farm and for that matter, the town as well.")
>

