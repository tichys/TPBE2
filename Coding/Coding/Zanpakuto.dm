datum/ZanOvers
	var/name;var/R=0;var/G=0;var/B=0
	BackSpikes
		name="BackSpikes"
	FrontSpikes
		name="FrontSpikes"
	Enlarge
		name="Enlarge"
	Overall
		name="Overall"

obj
	HUD
		ZanDisp
			icon_state="Stance"
			screen_loc="6:16,5:16"
			New(var/n)
				src.name=n
	Zanpakuto
		name=""
		var/Element=""
		var/Command=""
		var/SpiritType=""

mob/proc/ZanCreation()
	if(src.InventoryOpen)	src.ClearInventory()
	src.ClearHUD()
	src.Zanpakuto=new/obj/Zanpakuto
	src.client.eye=locate(67,10,2)

	src.ZanpakutoOverlays=list()
	var/obj/CP=new/obj/HUD/CharPreview
	CP.screen_loc="6:16,5:16";src.client.screen+=CP
	if(src.Squadrank=="Captain")
		CP.icon="captain.dmi";CP.icon_state="Stance"
	else
		CP.icon='SoulReaper.dmi';CP.icon_state="Stance"
	CP.HairR=src.HairR;CP.HairG=src.HairG;CP.HairB=src.HairB
	CP.layer=4;CP.AddHair(src.HairStyle)

turf
	ZanpakutoCreation
		Name
			Click()
				usr.Zanpakuto.name=copytext(TextInput(usr,"Input the Name of your Zanpakuto \nExamples: Senbonzakura or Zabimaru","Zanpakuto Name",usr.Zanpakuto.name),1,500)
		Spirit_Type
			Click()
				usr.Zanpakuto.SpiritType=input("Select the Spirit Type of your Zanpakuto","Zanpakuto Spirit Type")in list("Petals","Dragon","Beast","Ghost","Fire Dragon","Healing Canon","Fire Beast","God Spear","Reiki Control","Hornet","Paitence")
		Command
			Click()
				usr.Zanpakuto.Command=copytext(TextInput(usr,"Input the Command for your Zanpakuto \nExamples: Scatter or Roar","Zanpakuto Command",usr.Zanpakuto.Command),1,500)
		Element
			Click()
				src.name=src.icon_state
				if(ShowAlert(usr,"[src.name] > > [src.desc]",list("Select","Cancel"))=="Select")
					usr.Zanpakuto.Element=src.name
		Appearance
			Click()
				usr.ZanOvers()
		Done
			Click()
				if(length(usr.Zanpakuto.name)<1)	{ShowAlert(usr,"You must Give your Zanpakuto a Name!");return}
				if(length(usr.Zanpakuto.Command)<1)	{ShowAlert(usr,"You must Give your Zanpakuto a Summoning Command!");return}
				if(length(usr.Zanpakuto.Element)<1)	{ShowAlert(usr,"You must Select an Element for your Zanpakuto!");return}
				if(length(usr.Zanpakuto.SpiritType)<1)	{ShowAlert(usr,"You must Select a Spirit Type for your Zanpakuto!");return}
				var/MSG="Zanpakuto: > > "
				MSG+="Command to Summon: > "
				MSG+="[usr.Zanpakuto.Command], [usr.Zanpakuto.name]! > > "
				MSG+="Combined Spirit Type: > "
				MSG+="[usr.Zanpakuto.Element] [usr.Zanpakuto.SpiritType] > > "
				MSG+="Combined Effect: > "

				if(usr.Zanpakuto.SpiritType=="Beast")
					MSG+="Shikai: Zanpakuto becomes an Expandable Blade > > "
					MSG+="Bankai: Zanpakuto Transforms into an Expandable Beast-like Blade"

				if(usr.Zanpakuto.SpiritType=="Ghost")
					MSG+="Shikai: [usr.Zanpakuto.Element] Attribute Added to Zanpakuto, Granted Ability: Getsuga Tenshou > > "
					MSG+="Bankai: Costume Changes, Speed Greatly Increases, Unlimited Combo Chain"

				if(usr.Zanpakuto.SpiritType=="Dragon")
					MSG+="Shikai: [usr.Zanpakuto.Element] Attribute Slash Extends off Regular Attacks > > "
					MSG+="Bankai: Granted Powerfull Area Effect [usr.Zanpakuto.SpiritType] Attacks"

				if(usr.Zanpakuto.SpiritType=="Petals")
					MSG+="Shikai: Zanpakuto Scatters into One Thousand Blades > > "
					MSG+="Bankai: 1000 Blades rise from the ground, with their scattering infinitely more blades then rise."

				if(usr.Zanpakuto.SpiritType=="Fire Dragon")
					MSG+="Shikai: [usr.Zanpakuto.Element] Attribute Slash Extends off regular Attacks, Granted Ability: Fire Ring > > "
					MSG+="Bankai: Granted Powerfull Effect [usr.Zanpakuto.SpiritType] Attacks"

				if(usr.Zanpakuto.SpiritType=="Healing Canon")
					MSG+="Shikai: Slash Heals your Target!> > "
					MSG+="Bankai: Granted A Powerfull [usr.Zanpakuto.Element] Blast!"

				if(usr.Zanpakuto.SpiritType=="Fire Beast")
					MSG+="Shikai: [usr.Zanpakuto.Element] Attribute Slash Extends off regular Attacks, Granted Ability: Fire Slash > > "
					MSG+="Bankai: Granted A Powerfull Fire Blast Attack"

				if(usr.Zanpakuto.SpiritType=="God Spear")
					MSG+="Shikai: The ability to extend and retract your sword at light speed, Granted Ability: Sword Beam > > "
					MSG+="Bankai: Granted A Move which attacks the heart."

				if(usr.Zanpakuto.SpiritType=="Reiki Control")
					MSG+="Shikai: The ability to create reiki blasts off your sword, Granted Ability: Blood Mist Shield > > "
					MSG+="Bankai: Granted the ability to master reiki control from your sword."

				if(usr.Zanpakuto.SpiritType=="Hornet")
					MSG+="Shikai: The ability to create a demonic hell butterfly on the user causing high critical damage > > "
					MSG+="Bankai: Granted the ability to fire a giant missle like rocket doing high damage."

				if(usr.Zanpakuto.SpiritType=="Paitence")
					MSG+="Shikai: The ability slash an object doubling its weight! > > "
					MSG+="Bankai: Granted the ability to sned of a series of slashes before the target can react."

				if(ShowAlert(usr,"[MSG]",list("Finish","Cancel"))=="Finish")
					usr.client.eye=usr
					usr.HUD()
					winset(usr,"ZanWindow","is-visible=false")