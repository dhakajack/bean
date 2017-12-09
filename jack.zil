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
	(FLAGS LIGHTBIT)>
	
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
	(FLAGS LIGHTBIT)
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
	(LDESC "Accustomed to starvation, the cow stares unblinkingly at the barren ground.")
    (FDESC "Bessy the cow chews her last wad of cud.")
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
		)
	>
>
		
<OBJECT BEAN
	(IN PAWNSHOP)
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
			<TELL "When the bean hits the soil it burrows in furiously, ejecting dirt in all directions. After a moment, the ground shakes and a massive beanstalks shoots upward." CR>
			<REMOVE ,BEAN>
			<MOVE ,BEAN-STALK ,FARM>
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
	

	

