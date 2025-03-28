pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--default functions
function _init()
		//info for the player
		player = {}
				--default is 2
			 player.room  = 5
		bugtest = false	 
		
		--[[
		a list of event triggers
		for important variables.
		i'm aware that putting it as
		trigger.key for example may
		be better to ensure that
		everything is properly placed,
		but for now i'm prefering this
		to limit the amount of tokens
		i'm using, and to make the
		program more readable in
		pico8 specifically.
		]]--
		direction = "left"
		--located in room2
		key1=0
		--located in room 4
		key2=0
		--located in room 5
		journal1=0
		
		--[[
		it's important to know which 
		rooms we have entered already
		so we use these tables to
		learn which rooms we've already
		been in.
		]]--
		visitedroom={0,1,0,0,0,0,0,0,0}
		visitedsub ={
				{},
				{0,0,0,0,0,0},
				{},
				{0,0,0,0,0,0},
				{0,0,0,0,0,0},
				{0,0,0,0,0,0},
				{0,0,0,0,0,0},
				{0,0,0,0,0,0},
				{0,0,0,0,0,0},
		}
		--[[
		variables for making various
		objects "blink", i.e flicker
		between two sprites
		]]--
		
		swapblinkstate = 1
		blinktimer = 15
		blinkmap={001,002}
		blinksel={003,004}
		blinkchc={005,006}		
		blinkchc2={007,008}
		
		//variables for dialogue
		dialogueselection = 1
		selectedchoice = 0
		lockchoice = false
		disable = false
		initialmainval = 1
		//variable to scroll text
		textscroll=1
		//array that holds room info
		story = {
					//room 1 information
					{
							dialogue = {"nothing"},
							choice = {"nothing"}
					},
					//room 2 information
				 {
							dialogue = {
									"you've heard plenty of rumors about the abandoned apartment complex on the edge of town. there was an explosion a year ago that killed a number of people, and ever since then the complex was abandoned. there were countless rumors about what had happened.",
									"one rumor had it that it was a drug operation that went south.another rumor had it that it was a terrorist group that was trying to make a bomb but ended up blowing themselves up on accident. there was even a rumor that it was a spy base that was discovered, and it blew up as a safety precaution.",
							  "whatever the case, the owners abandoned it. it was put under investigation for a time by the police, but nothing turned up. still, it always felt odd to you and before you realized it, you had found yourself outside of the broken doors of the infamous facility. you walk inside carefully, feeling your curiousity grow.",
							  "you venture inside the facility. it's difficult getting past the door, as something inside had blocked the door, and it wouldn't budge. thankfully, upon looking around, you spotted an open window and managed to climb in.",
							  "as you look around the entrance room, it's clear that the decrepit building isn't exactly safe. water drips from the ceiling, and there's rubble along the floor.",
							},
							choice = {
									"check front desk",
									"look around room.",
									"go to next room"
							},
							followupchoice = {
									{
									"you look around the rugged front desk, seeing if there was anything worth salvaging inside of it. despite not expecting much, as you open it up, you notice that the back of the drawer seems broken, revealing that there's a hidden compartment.",
									"it's difficult feeling around for whats inside of it, and ultimately your efforts break the already decaying entrance of the compartment open. within is a keycard stained green. seeing nothing else within, you take the keycard in case it may be helpful later.",
									"there is nothing left inside of the front desk."
									},
									{
									"you look throughout the broken room. there's a lot to take in, such as the plant life that has won its battle against the odds and found life inside this broken room.",
									"after spending a few minutes scavenging the place, its clear that anything of value or importance is likely already gone, taken by any who had already come before you.",
									"if nothing else, you had some fun while you were doing it, so it's not like this was a complete waste.",
									"you check around again, but there's still not much of note."
									},
									{
									"try as you might, the door to the next room is locked, and it'll need a keycard to get through.",
									"you spend a few minutes trying to get through without one, but it's not budging. it seems you'll need to find a keycard somewhere...",
									"",
									}
							}
					},
					//room 3 information
					{
							dialogue = {"nothing"},
							choice = {"nothing"}
					},
					//room 4 information
					{
							dialogue = {
							"it seemed that this room had quite a few rather odd looking plants inside, they almost seemed to glow with vibrancy. furthermore, there were certainly a few computers in here and storage cabinets. though, with the computers, they seemed to be non operational. the odd looking plants were locked away in glass containers, almost like it was meant for observation.",
							"as you walk in, a small alarm goes off. it was barely audible, and after a few moments the sprinklers in the room go off, letting a very gentle mist of water into the room. it certainly wouldn't put out any fires, but it'd at least water the plants that had taken root in here.",
							"if nothing else, it wouldn't hurt to take a look around this room. with some luck, perhaps something valuable could be found, or at least some sort of clue to help you understand what happened. you can't exactly go back empty handed now... you're doing this for your sister after all. if you can't find anything here...",
							"these thoughts won't help you now. gently slapping your own cheeks, you regain the confidence to continue searching."
							},
							choice = {
									"check cabinets",
									"check doors",
									"leave the room."
							},
							followupchoice = {
									{
									"the cabinets are in a rather sorry state, banged up from having fallen over. thankfully, they seem to be unlocked, so opening it isn't an issue. there's plenty in here, though you're not exactly sure what much of it is. ultimately, the only thing you take from the cabinet is a keycard marked with the number marked 6 on it.",
									"you take a second look to be extra safe. while you do find some scientific instruments that could sell for a pretty penny, there's nothing useful for you at the moment here. you make a mental note to return before you leave."
									},
									{
									"you look throughout the broken room. there's a lot to take in, such as the plant life that has won its battle against the odds and found life inside this broken room.",
									"after spending a few minutes scavenging the place, its clear that anything of value or importance is likely already gone, taken by any who had already come before you.",
									"if nothing else, you had some fun while you were doing it, so it's not like this was a complete waste.",
									"you check around again, but there's still not much of note."
									},
									{
									"you walk out of the room, careful not to bump into anything on the way out. as you step through the door, you're careful to leave it open slightly, on the off chance that closing it could get the door stuck.",
									"",
									}
							}
					},
					//room 5 information
					{
							dialogue = {
									"ultimately, you make your way to the base of the stairs without issue. the sound of water dripping echoes around you, coming from a few pipes leaking fluids around you. it'll be impossible to keep your shoes dry, as there's a few puddles on the floor. it's odd, the plant life around you shouldn't have grown so quickly.",
									"if it were a few decades, it'd be expected but it was only a year since that explosion. some growth could have occurred, but with only a few flickering lightbulbs as a source of light, it doesn't make sense for the plants around you to have gotten so lively. looking at them closer won't answer any of your lingering questions.",
									"the door ahead of you is closed, but it doesn't match the decor of the apartment above. it's a painfully white door, the type that you'd expect in a hospital or laboratory, though there's faint stains of red on the door and floor near it. it's not too late to go back up the stairs and leave... but you won't get the answer to what happened here.",
									"it's an automatic door, but unsurprisingly it's broken after all this time. it takes a few minutes, but you force it open. it seemed that this place appears to be a laboratory. if the stairs looked overgrown, then this was a proper jungle! the plants had completely taken over, it was impossible to find a single surface that didn't have some sort of flora growing on it.",
									"you carefully make your way into the room, trying not to step on any of the plants while carefully looking around. there was a clear glass window in front of you, showing the room on the otherside... or at least it would. it was completely obscured by the plants on the otherside, with a few cracks at certain points.",
									"from an initial glance, there's a lot to look at on both sides of this room. you decide to start by looking at the left. towards the left side, on a desk, there seems to be a book covered in vines, and there's a door on the left wall with a dull light shining from it. it also seems to be cracked open."
							},
							choice = {
									"check journal",
								 "check computers",
								 "check glass",
									"enter left door.",
									"enter right door.",
									"go back upstairs.",
							},
							followupchoice = {
									{
									"it takes a few moments to pry the journal from the vines, as they were hugging it rather tightly. ultimately, you prevail against mother nature, giving the vine a rather triumphant look as you hold your spoils in your hand... though you realize that you're looking rather silly for boasting against a plant. you decide to open the book, and see if anything is even in it.",
									"you flip through the pages to see if there's anything you may have missed in the book, but the rest of the pages are illegible.",
									},
									{
										"you check the computers, but it seems that they're broken. they won't turn on, no matter what you press. considering that the room has a number of puddles, this doesn't come as a huge surprise.",
										"you check again to see if the computers might have somehow started working, but they're still unresponsive.",
								 },
								 {
										"considering that there's a giant pane of glass in front of you, it wouldn't hurt to try and look through it. you spend a few moments trying to look through, the glass has gotten foggy and the lights don't seem to be on considering it's pitch black in there. all you can manage to see is that there's vines near the glass.",
										"you take a second look to see if anything you've done made it more visible. unfortunately, it didn't and you still can't see anything within."
								 },
									{
									 "you open the left door slowly. it doesn't open easily, you can feel some resistance but it doesn't take much effort to open it. it's a pleasant surprise, considering the state of the facility, it's a miracle that something hadn't fallen over and blocked the door after all. you look inside the room.",
									 ""
									},
									{
										"the door on the right side seems to be fully intact. a red light is present above the door. furthermore, there seems to be a card scanner to the right. you try using the card that you found upstairs, swiping it through. the scanner flashes red and lets out a negative beep. it seems this won't work, you'll have to find a new card.",
										"you swipe through the card again, to see if maybe you had done it incorrectly. the scanner rejects this attempt as well. you try once more for good measure, but the scanner flashes red once again. this isn't going to work, in all likelyhood."
									},
									{
										"you just came down here. leaving now would be a waste, as you haven't found anything valuable. it may be safer to leave, but what would be the point?"
									}
							}
					},
					//room 6 information
					//do later
					{
							dialogue = {
									"you step into the room carefully. "
							},
							choice = {
									"check journal",
									"check other side",
									"enter left room.",
							},
							followupchoice = {
									{
									"it takes a few moments to pry the journal from the vines, as they were hugging it rather tightly. ultimately, you prevail against mother nature, giving the vine a rather triumphant look as you hold your spoils in your hand... though you realize that you're looking rather silly for boasting against a plant. you decide to open the book, and see if anything is even in it.",
									"you flip through the pages to see if there's anything you may have missed in the book, but the rest of the pages are illegible.",
									},
									{
									"you decide to start looking around on the other side of the room, to see if there's anything special there. it won't hurt to take a proper look.",
									"you look back to the otherside, to see if you missed anything. it's not like taking a closer look will hurt."
									},
									{
									"you open the door slowly. it resists slightly, though it comes as little surprise considering the state of the room. it's a miracle that something hadn't fallen over and blocked the door after all. you look inside the room.",
									""
									},
							}
					},
					//room 7 information
					{
							dialogue = {"nothing"},
							choice = {"nothing"}
					},
					//room 8 information
					{
							dialogue = {"nothing"},
							choice = {"nothing"}
					},
					//room 9 information
					{
							dialogue = {"nothing"},
							choice = {"nothing"}
					},
		}
	 --[[
	 the initial dialogue that should be displayed
	 we're putting it here due to necessity
		]]--
		currentdialogue = story[player.room].dialogue[1]
end

function _update()
		//scrolling, we use #string to see length
		if textscroll < #splitdialogue(currentdialogue)
		then
				textscroll+=0.5
				//skip dialogue button
				if btnp(5)
				then
						textscroll = #splitdialogue(currentdialogue)
				end
		end
		//blinking ui code
		if blinktimer > 0
		then
				blinktimer-=1
		end
		if blinktimer == 0
		then
				if swapblinkstate == 2
				then 
						swapblinkstate = 1
						blinktimer = 15
				else 
						swapblinkstate = 2
						blinktimer = 15
				end
		end
end

function _draw() 
		//important to clear screen after we do something to show changes
		cls()
		//to help see screen, deleteme
		rectfill(0,0,128,128,1)
		ui()
		bugs()
		//handle the dialogue
		dialogue(story[player.room])
end
-->8
--ui page

function ui() 
		--[[our room layout: we're
		using a table to handle room
		data. 
		
		0 represents a room that
		the player has not entered yet.
		
		1 represents a room that
		the player has entered
		
		9 represents an empty room:
		one that shouldn't be reached.
		]]--
		room = {
				9,1,9,
				1,1,1,
				1,1,1,
				1,1,1
		}
		//holder for room ui
		rect(96,88,123,123,2)

		//room ui
		rect(5,88,91,123,2)
		//using this to place a grid from the info in room
		for i = 0, 3 do
				for j = 1, 3 do
						temp = (i*3)+j
--[[first, we check to see if 
we're in the room that the 
player is in. the player has an inbuilt room variable for this reason
room variable that changes with
each room they go to. thus:
we can compare that with the
i+j calculation to see if the
player is in "that" room, and
if they are, we do an alternative
sprite to show it.]]--
						if temp==player.room
						then
							spr(blinkmap[swapblinkstate],90+(8*j),114-(8*i))
--[[alternatively, if the player
isn't in the room, we show off
if the room is discovered by seeing
if it equals 1 or not. if it's 1
then the player has stepped into
it before. otherwise, we display
nothing, as they don't know it 
exists yet.]]--
						elseif room[(temp)]==1 and visitedroom[temp]==1
						then
								spr(001,90+(8*j),114-(8*i))
						end
				end
		end
end


function selection(blinker,cond1,cond2,x,y)
		if cond1 and cond2
		then
				spr(blinker[swapblinkstate],x,y)
		else
				spr(blinker[1],x,y)
		end
end

function choices(item)
		//
		if not lockchoice
		then
		//
				if #item.choice > 3
				then
						selection(blinkchc,
						dialogueselection!=1,
						textscroll == #splitdialogue(currentdialogue),
						78,116)
						selection(blinkchc2,
						dialogueselection!=#item.choice,
						textscroll == #splitdialogue(currentdialogue),
						84,116)
				//
				end
				
				if dialogueselection >= 3
				then
						over3 = dialogueselection-3
				else
						over3 = 0
				end
				
		 	for i = 1, 3 do	 	
				  		print(item.choice[i+over3],8,81+(i*10))
				  		selection(blinksel,
				  		i+over3==dialogueselection,
				  		textscroll == #splitdialogue(currentdialogue),
				  		80,79+(i*10))
				end
				
				if not disable and textscroll == #splitdialogue(currentdialogue)
						then
						if btnp(3) and dialogueselection < #item.choice
						then
								dialogueselection += 1
						elseif btnp(2) and dialogueselection > 1
						then
								dialogueselection -= 1
						end
				end
		else
				print("continue",8,91)
				selection(blinksel,
				true,
				textscroll == #splitdialogue(currentdialogue),
				80,89)
		end
end

//function to make sound happen as dialogue plays
function sound(string)
		--[[
		we use ord to check the value of the current character being written.
		- if it's " ", "," or ".", we don't play sound. furthermore,
		- if the previous character were one of those,
		we won't play any sound.
		- if we're at the end of the string, we won't
		make any sound since it's over.
		- finally, we use text scroll's delay to make the sounds 
		happen only when it's just written.
		]]--
  if ord(string[textscroll])!=(32 or 44 or 46)
  and ord(string[textscroll-1])!=(32 or 44 or 46)
  and textscroll != #string
  and textscroll % 1 == 0
		then
				sfx(00)
		end
end

function bugs()		
		if bugtest
		then
				print("computer1: "..computer1,8,70)
				print("selectedchoice: "..selectedchoice,8,76)
				--print("initmain: "..initialmainval,8,82)
				--print("key "..triggers.key,8,82)
				print("room 5 choices: "..visitedsub[5][1].." "..visitedsub[5][2].." "..visitedsub[5][3],8,82)
		end
end
-->8
--dialogue page

--[[
show the main dialogue for the room.
if we make a selection on side dialogue, then we show the side dialogue
otherwise, we show the dialogue for the room.
]]--

function dialogue(item) 

		--[[
		if we have a choice we can make,
		then we're in the branching dialogue
		thus, we can continue the story
		by using our followup dialogue.
		]]--
		if selectedchoice != 0 
		then
				displaydialogue(item.followupchoice[selectedchoice],visitedsub[player.room][dialogueselection]==0,1)
		--[[
		this area is for the main
		dialogue, i.e the dialogue
		that by default in a room, 
		such as when you enter or
		re-enter it.
		]]--
		else
				if visitedroom[player.room] == 0
				then
						lockchoice = true
						disable = true
				end
				displaydialogue(item.dialogue,lockchoice)
		end

		--in ui page
		choices(item)

		--give better notes
		if btnp(4) and textscroll == #splitdialogue(currentdialogue) and not disable
		then
				textscroll = 0			 
				if selectedchoice == 0
				then 
						lockchoice = true
						selectedchoice = dialogueselection
				elseif selectedchoice == dialogueselection
				then
						lockchoice = false
						selectedchoice = 0
				end
		end
end

function displaydialogue(item,binary,branch)
		--[[
		we use this to determine if we should
		go through the entire dialogue,
		or if the player has already read it.
		
		if binary is true, then we haven't
		seen the dialogue yet and should
		display it all. otherwise, just
		skip to the last part.
		]]--			
		if binary
	 then
		--[[
		for our various dialogue options,
		it's important to ensure that the
		system knows what our current
		dialogue is. thus, we have it
		set so it'll always initialize
		to the 'start', and we can simply 
		update it as we go along.
		]]--
	 		currentdialogue = item[initialmainval]
				print(sub(splitdialogue(currentdialogue),1,textscroll),3,3)
				sound(splitdialogue(currentdialogue))		
		--[[
		we have it set so the dialogue can
		only be advanced once we have reached
		the end of the paragraph, and that
		the button is pressed.
		]]--
				if btnp(4)	and textscroll==#splitdialogue(item[initialmainval])
				then 
		--[[
		once we move to the next 
		paragraph, we should start from
		the beginning of the next
		sentence, hence we reset the
		textscroll, which dictates
		where we are in the sentence.
		]]--
						textscroll = 0
		--[[
		next, we check if we're about
		to reach the end of the current
		dialogue.	if we're not, then
		we'll continue moving through
		the paragraphs.
		
		otherwise, if we're about to
		finish, then we'll tell the
		program that it's time to 
		adjust	our variables to get
		ready for allowing the player
		to make choices again.
		
		notably: with how the program
		works, in one iteration of the
		loops, it will never display
		the final part of our dialogue.
		
		this is intentional, as for the
		main dialogue, once the program
		completes, it will then update
		our numbers and the program will
		run again, this time seeing 
		that it should only run the last
		line of dialogue and nothing else.
		
		this creates a seemless line
		that ensures we go straight from
		second to last to last without
		any issues for the main dialogue.
		
		it also ensures that we will 
		display the last main dialogue
		after we finish making a choice,
		giving us something to always
		go back to.
		
		for the branching dialogue, it
		also works just fine as we can
		use that last line of dialogue
		to simply be used as a
		'reinvestigation' note, i.e
		after a player checks the same
		point again, it'll display
		a short message for the player
		to understand that they have
		everything.
		
		we're also able to run
		our events here to ensure that
		our various checks are being
		updated.
		]]--
						if #item-1 > initialmainval
						then
								initialmainval += 1
				 	else
				 			if branch
				 			then
				 					events()
				 					selectedchoice = 0
				 			else
				 					visitedroom[player.room] = 1
								end
								initialmainval = 1
								disable = false
								lockchoice = false
						end
				end
		else
		--[[
		if the binary is false, it
		means that we've seen this 
		dialogue before and we can
		skip straight to the end
		without fear.
		
		the only thing we should do
		is display the dialogue, and
		if we're in a branch, then
		we should run the event just
		in case.
		]]--
				currentdialogue = item[#item]
				print(sub(splitdialogue(currentdialogue),1,textscroll),3,3)
				sound(splitdialogue(currentdialogue))				
		end
end
-->8
--event tracker

--[[
we're using this program to
update our events as certain
things happen due to the player's
choices.

with my current design philosophy,
i want to ensure that the various
checks can only update should
the player achieve the necessary
condition. i don't wish to create
a game that plays itself after all
with minimal input.
]]--
function events()
		
		visitedsub[player.room][selectedchoice] = 1
		
		if player.room == 2
		then
				if selectedchoice == 1
				then
				--[[
				checking this area gives the
				player a key. as the player
				never revisits this area
				after "using" the key, there
				is no need to reset the key,
				especially as logically they
				wouldn't just go and throw
				it away after using it.
				
				we also want to ensure that
				the player sees the correct
				message. if the player has
				picked up the key, then
				the door dialogue will update
				accordingly.
				
				while it is not 100% necessary
				at this time to create new
				dialogue, at a later stage
				in the program, i will want
				to completely overwrite a
				room's information when the
				player backtracks through it,
				to more accurately display
				the information.
				
				as such, this is being used
				as a proof of concept to ensure
				we can update the information
				as necessary.
				]]--
						key1 = 1
						story[2].followupchoice[3] = {
						"after using the keycard, the door opens with a small cloud of mist dispersing into the room. you can smell fresh plant life up ahead. a faint light illuminates the room, showing that a spiral staircase is what awaits you with vines growing throughout the room. with no other option, you descend the stairs",
						"you slowly make your way down the stairs, being as careful as you can. each step causes the stairs to let out an awful creak, and whether it'll be from the stair underneath you breaking or tripping on an errant vine, a fall from here wouldn't be pretty.",
						""
						}
				--[[
				due to the second option
				not accomplishing anything,
				only used for story telling,
				there is no need to give it
				any special events.
				
				for the third option,
				if we have the key, then 
				it'll transport us to the
				next room. otherwise,
				nothing happens.
				
				in the event of the latter,
				we have it reset the choice
				so the player can reread it
				if they get confused on what
				they need.
				
				granted, this isn't that 
				complex of a puzzle, but
				being able to reset room
				states will be important later.
				]]--
				elseif selectedchoice == 3
				then
				--[[
				we see if we have the key
				if we do, we go through
				to room "5", otherwise
				we do nothing.
				]]--
						if key1 == 1 
						and visitedsub[2][3] == 1
						then
								player.room = 5
						else
								visitedsub[2][3] = 0
						end					
				end
		--[[
		room 3
		intentionally omitted, due
		to the facility's layout
		not showing one.

 	elseif player.room == 3
		then
				if selectedchoice == 1
				then
				
				if selectedchoice == 2
				then
				
				if selectedchoice == 3
				then
				
				
		]]--		
		--[[
		room 4
		]]--
		elseif player.room == 4
		then
				//
				if selectedchoice == 1
				then
						key2 = 1
						visitedsub[5][5] = 0
						story[5].followupchoice[5] = 
							{
									"you take the new keycard from your pocket and swipe it through the scanner. after a few moments, it lets out a positive sounding beep as the light above the door as well as the scanner flashes green, and the sound of a mechanism unlocking can be heard. it's unlocked now, and all that's left to do now is enter the door.",
							}
				end
				//
				if selectedchoice == 3
				then
						visitedsub[4][3] = 0						
						visitedsub[5][4] = 0
						story[5].dialogue[6] = "this observation room seems to be no different than when you had left it a few minutes ago. you carefully walk through the room, avoiding stepping on any vines while you consider your options."
				  story[5].followupchoice[4] = 
							{
					    "thinking that you may have missed something, you decide to check out the room on the left one more time, walking in slowly and carefully.",
					    "",
					  }	
						player.room = 5
				end
	
		--[[
	 room 5
		]]--
		elseif player.room == 5
		then
				if selectedchoice == 1
				then
						journal1 = 1
				end
			 if selectedchoice == 4
		  then
						player.room = 4
				end
				if selectedchoice == 5 
				and key2 == 1
				then
						player.room = 6
				end
		end
		dialogueselection = 1
end
-->8
-- dialogue splitter

function splitdialogue(input)
		--[[
		this function exists to 
		automatically add the breakline
		to a given string, so we won't
		need to do it manually, as it's
		tedious. we take a given string
		and we can make it add a new
		line with any posotive number
		for the sentence length

		our length must be 1 higher than
		what we want. this is because
		we're adding the newline
		character "\n" at the end of
		every sentence, and thus
		must accomodate for it.
		
		the second value will update
		dynamically once the loop starts
		but we wish to keep the first
		number the same incase we wish
		to change how long it is.
		]]--
		setlength=31
		length=setlength
		--[[
		we dynamically calculate the 
		length of the string and divide
		it by our length to know how
		many rows we want, and thus
		how many newlines we'll add
		]]--
		
		for i=0,ceil(#input/setlength) do
		--[[
		we must also check before we
		insert the newline if we'll
		cut off a word by doing this.
		if the given character isn't
		an empty space, we'll run a
		check and simply adjust where
		we put the new line. i.e:
		if it's cutting off the word
		like so
		
		..... hel
		lo world
		
		then we will see how many
		characters it must take to
		move it to the next sentence.
		in this case, we must move
		'hel' and we'll adjust our
		number appropriately so it
		will display
		
		.....
		hello world
		
		assuming that it can all be
		displayed on one line, of
		course.
		]]--
		
				if sub(input,length-1,length-1)!=" "
				then
						for j=1,ceil(setlength/3) do
								if sub(input,length-j,length-j)==" "
								then
										length-=j-1
										break
								end
						end
				end

		--[[
		once we are sure that adding
		a new line is safe, we will
		do so by creating a temporary
		placeholder, and it's value will
		be what we have already done,
		the newline, and then what we
		haven't done yet.
		
		thus, each time we go through
		this loop again, it'll only
		affect the next line, without
		compromising any previous lines.
		
		we also increase our length
		appropriately each line.
		]]--
				temporary = sub(input,1,length-1).."\n"..sub(input,length)
 			input = temporary		
 			length+=setlength
		end
		--[[
		once we're finished
		]]--
		return input
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033333300333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700030000300300003003333300033333000003300000033000003333000033330000000000000000000000000000000000000000000000000000000000
0007700003000030030bb030030000300300003000300300003bb30000300300003bb30000000000000000000000000000000000000000000000000000000000
0007700003000030030bb03003000003030bb00300300300003bb30000300300003bb30000000000000000000000000000000000000000000000000000000000
00700700030000300300003003000030030000300033330000333300000330000003300000000000000000000000000000000000000000000000000000000000
00000000033333300333333003333300033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000032750327001470014700147001470014700147001470014700147001470029700277002370021700027001d7001a7001870013700107000b700077000370000700007000070000700007000070000700
