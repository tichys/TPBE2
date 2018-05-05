obj/Items
	Equipment
		HasUse=0
		var/Slot
		MaxStack=1
		var/list/StatBoosts=list()
		var/list/SalvageItems=list()
		var/LvlReq=1
		var/IsEquipped=0
		var/list/Effects=list()
		proc/OnEquip(var/mob/M)	return
		proc/OnUnEquip(var/mob/M)	return
		proc/OnAttack(var/mob/M)	return
		proc/OnDefend(var/mob/M)	return
		proc/Equip(var/mob/M)
			M.Inventory[src.InvSlot]=null
			M.vars[src.Slot]=src
			PlayMenuSound(M,'Bow2.wav')
			M.EquipmentList+=src
			for(var/Stat in src.StatBoosts)
				M.vars["[Stat]"]+=src.StatBoosts[Stat]
				M.vars["[Stat]"]+=(src.StatBoosts[Stat]*src.enc)/5
			src.OnEquip(M)
		proc/UnEquip(var/mob/M)
			src.OnUnEquip(M)
			M.EquipmentList-=src
			for(var/Stat in src.StatBoosts)
				M.vars["[Stat]"]-=src.StatBoosts[Stat]
				M.vars["[Stat]"]-=(src.StatBoosts[Stat]*src.enc)/5
			M.vars[src.Slot]=null
		Feet
			Slot="Feet"
			icon='Boots.dmi'
			Magisters_Boots
				noenchant=1
				oname="Magisters Boots"
				nosalvage=1
				StatBoosts=list("MGC"=30,"STR"=30,"AGI"=15,"VIT"=30,"MaxSTM"= 200,"MaxREI"=200)
				SalvageItems=list("Leather"=2,"Thread"=1,"Adhesive"=1)
				GoldValue=500;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="A regal pair of cloth boots, they look sturdy."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +30 <br> STR +30 <br> AGI +15  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200 <br><font color=yellow> Can not be Refined."
				icon_state="Feather Boots";mouse_drag_pointer="Feather Boots"
			Magicians_Gambit
				noenchant=1
				nosalvage=1
				oname="Magicians Gambit"
				StatBoosts=list("MGC"=60,"STR"=60,"AGI"=30,"VIT"=60,"MaxSTM"= 500,"MaxREI"=500)
				SalvageItems=list("Leather"=2,"Thread"=2,"Adhesive"=1,"Iron"=1)
				GoldValue=1000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="An upgraded version of the Magister's Boosts, sown with red magethread."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +60  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500<br><font color=yellow> Can not be Refined"
				icon_state="Red Shoes";mouse_drag_pointer="Red Shoes"
			Hollowskin_Sollerets
				oname="Hollowskin Sollerets"
				StatBoosts=list("STR"=30,"MGC"=30,"AGI"=15,"VIT"=30,"MaxSTM"= 220,"MaxREI"=220,"LCK"=30)
				SalvageItems=list("Leather"=1,"Thread"=1,"Adhesive"=1)
				GoldValue=5000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="Boots crafted from the skin of a hollow beast. Very resilient, if a bit uncomfortable."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +30 <br> STR +30 <br> AGI +15  <br> VIT +30 <br> LCK +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +220 <br> MaxREI +220"
				icon_state="Germinas Boots";mouse_drag_pointer="Germinas Boots"
			Boots_Of_Wealth
				LvlReq=50
				oname="Boots of Wealth"
				StatBoosts=list("STR"=50,"MGC"=50,"AGI"=50,"VIT"=30,"MaxSTM"= 1000,"MaxREI"=1000,"Hakuda"=15,"Income"=150)
				SalvageItems=list("Leather"=5,"Thread"=3,"Adhesive"=3,"Gems"=2)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=1
				desc="These boots are covered in jewels and gold, they are of superior quality."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +50 <br> STR +50 <br> AGI +50  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1000 <br> MaxREI +1000 <br> Hakuda +15 <br> Income +150 <br><br><font color=red>Requires level 50"
				icon_state="Spike Boots";mouse_drag_pointer="Spike Boots"
	/*		Omen_of_Alacrity
				LvlReq=150
				StatBoosts=list("STR"=90,"MGC"=90,"AGI"=50,"VIT"=90,"MaxSTM"= 800,"MaxREI"=800,"LCK"=90)
				GoldValue=5000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="A simple pair of boots. Simple but magical."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +90 <br> STR +90 <br> AGI +50  <br> VIT +90 <br> LCK +90 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800<br><br><font color=red>Requires level 50"
				icon_state="Sprint Shoes";mouse_drag_pointer="Sprint Shoes"*/



			Windwalkers //Ritsuka191
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=50,"MGC"=50,"AGI"=1000,"ShieldBonus"=30,"ImmunityBonus"=20,"Hakuda"=300,"Hohou"=200,"MaxSTM"= 2000,"MaxREI"=2000)
				GoldValue=100000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="These boots are too powerful to identify"
				desc2="Can not be identified"
				icon_state="Sprint Shoes";mouse_drag_pointer="Sprint Shoes"
			Festive_Moccasins
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=500,"MGC"=500,"AGI"=500,"VIT"=500,"MaxSTM"= 5000,"MaxREI"=5000,"Hohou"=80,"Hakuda"=80,"Zanjutsu"=80,"Kidou"=80,"Income"=2000,"HonorSet"=2,"CritBonus"=5)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=16
				desc="These are special boots, only obtainable during Holiday seasons and bestow great power."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +500 <br> STR +500 <br> AGI +500  <br> VIT +500 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +5000 <br> MaxREI +5000 <br> Hohou +80 <br> Zanjutsu +80 <br> Hakuda +80 <br> Kidou +80 <br> Income +2000 <br><font color=yellow>Honor Bonus +2<br> Critical Bonus +5%<br><font color=yellow> Can not be Refined"
				icon_state="Feather Boots";mouse_drag_pointer="Feather Boots"
			Sanguine_Walkers
				LvlReq=50
				oname="Sanguine Walkers"
				StatBoosts=list("STR"=200,"MGC"=200,"AGI"=200,"VIT"=200,"MaxSTM"= 2000,"MaxREI"=2000,"Hohou"=30,"Hakuda"=30,"Zanjutsu"=30,"Kidou"=30,"Income"=900,"HonorSet"=1,"CritBonus"=2)
				SalvageItems=list("Leather"=10,"Thread"=7,"Adhesive"=5,"EnchantedOre"=2)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=200
				desc="The Sanguine Walkers offer superior protection and boosts, it is said to have been crafted from the Master of Sanguine Village"
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +200 <br> STR +200 <br> AGI +200  <br> VIT +200 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +2000 <br> MaxREI +2000 <br> Hohou +30 <br> Zanjutsu +30 <br> Hakuda +30 <br> Kidou +30 <br> Income +900 <br><font color=yellow>Honor Bonus +1<br> Critical Bonus +2%<br><br><font color=red>Requires level 50"
				icon_state="Feather Boots";mouse_drag_pointer="Feather Boots"
			Midnight_Sollerets
				LvlReq=500
				Unique=1
				Epic=1
				oname="Midnight Sollerets"
				StatBoosts=list("STR"=450,"MGC"=450,"AGI"=200,"VIT"=200,"MaxSTM"= 5000,"MaxREI"=5000,"Hohou"=60,"Hakuda"=60,"Zanjutsu"=60,"Kidou"=60,"Income"=900,"HonorSet"=1,"CritBonus"=3)
				SalvageItems=list("Leather"=20,"Thread"=15,"Adhesive"=8,"MeteorFragment"=5,"Mithril"=2,"DivineOre"=1)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=400
				desc="The Midnight Sollerets offer great protection and power."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +450 <br> STR +450 <br> AGI +200  <br> VIT +200 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +5000 <br> MaxREI +5000 <br> Hohou +60 <br> Zanjutsu +60 <br> Hakuda +60 <br> Kidou +60 <br> Income +900 <br><font color=yellow>Honor Bonus +1<br> Critical Bonus +3%<br><br><font color=red>Requires level 500<br><br><font color=green>SET BONUS (feet)<br>Increases walking speed by 30% when worn, also removes all status effects(2 min cooldown)<br><br><i><font color=orange>Set bonus activated once all pieces of the set are equipped also + 100% exp boost and 20% honor boost gained.</font>"
				icon_state="Battle Boots";mouse_drag_pointer="Battle Boots"
			Beastskin_Boots
				LvlReq=100
				Unique=1
				Epic=1
				oname="Beastskin Boots"
				StatBoosts=list("STR"=60,"MGC"=60,"AGI"=60,"VIT"=70,"MaxSTM"= 1100,"MaxREI"=1100,"Hakuda"=5,"Kidou"=5,"Zanjutsu"=5,"Income"=350)
				SalvageItems=list("Leather"=5,"Thread"=3,"Adhesive"=3,"EnchantedOre"=1)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=1
				desc="Created from the bones and skin of a Flame Eater, these boots provide excellent protection."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +60  <br> VIT +70 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +2200 <br> MaxREI +1100 <br> Hakuda +5 <br> Kidou +5 <br> Zanjutsu +5 <br> <font color=yellow> Income +350</font><br><br><font color=red>Requires level 100"
				icon_state="Spike Boots";mouse_drag_pointer="Spike Boots"


		Back
			Slot="Back"
			icon='Capes.dmi'
			Crystal_Threaded_Cape
				LvlReq=50
				noenchant=1
				nosalvage=1
				StatBoosts=list("VIT"=25)
				GoldValue=5;SilvValue=0;CoprValue=0
				desc="A bright red cape.  Threaded with Flaming Crystal fibers."
				desc2="<center><font color=red><i>STATS</i></font></center><br>VIT +25<br><br><font color=red>Requires level 50<br><font color=yellow> Can not be Refined"
				icon_state="Crystal Threaded Cape";mouse_drag_pointer="Crystal Threaded Cape"
			Luminous_Cloak
				noenchant=1
				oname="Luminous Cloak"
				nosalvage=1
				StatBoosts=list("MGC"=30,"STR"=30,"AGI"=15,"VIT"=30,"MGCDEF"=15,"MaxSTM"= 200,"MaxREI"=200)
				SalvageItems=list("Leather"=1,)
				GoldValue=5500;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="A leather cloak which often glows as light touches it."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC 30 <br> STR 30 <br> AGI +15  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200 <br> MGCDEF +15<br><font color=yellow> Can not be Refined"
				icon_state="Leather Mantle";mouse_drag_pointer="Leather Mantle"
			Banshees_drape
				oname="Banshee's Drape"
				nosalvage=1
				StatBoosts=list("MGC"=15,"STR"=15,"AGI"=10,"VIT"=15,"MGCDEF"=2,"MaxSTM"= 100,"MaxREI"=100)
				GoldValue=1000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Leather"=2,"Thread"=2,"Iron"=2)
				desc="A mystic cape crafted from the hairs of a Banshee."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +15 <br> STR +15 <br> AGI +10  <br> VIT +15 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +100 <br> MaxREI +100 <br> MGCDEF +2"
				icon_state="Wizard Mantle";mouse_drag_pointer="Wizard Mantle"
			Hollowskin_Cloak
				oname="Hollowskin Cloak"
				StatBoosts=list("STR"=25,"MGC"=25,"AGI"=15,"VIT"=25,"MGCDEF"=5,"MaxSTM"= 250,"MaxREI"=250,"ShieldBonus"=1)
				GoldValue=55000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Leather"=1,"Thread"=1,"Bones"=1)
				desc="A horrid red cape made from the skin of a hollow beast."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +25 <br> STR +25 <br> AGI +15  <br> VIT +25  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +250 <br> MaxREI +250 <br> MGCDEF +5 <br> Damage Reduce +1%"
				icon_state="Dracula Mantle";mouse_drag_pointer="Dracula Mantle"
		/*	Omen_of_Immortality
				LvlReq=150
				StatBoosts=list("STR"=90,"MGC"=90,"AGI"=50,"VIT"=90,"MGCDEF"=50,"MaxSTM"= 800,"MaxREI"=800,"ShieldBonus"=10)
				GoldValue=5000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="An elven cape, it is comfortable and light. It hums with inner power."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +90 <br> STR +90 <br> AGI +50  <br> VIT +90 <br> LCK +90 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800 <br> MGCDEF +50 <br> Damage Reduce +10%"
				icon_state="Elf Mantle";mouse_drag_pointer="Elf Mantle"*/
			Cloak_of_Shadows
				LvlReq=1
				oname="Cloak of Shadows"
				StatBoosts=list("STR"=60,"MGC"=60,"AGI"=60,"VIT"=75,"MGCDEF"=10,"MaxSTM"= 800,"MaxREI"=800,"ShieldBonus"=1,"Hohou"=15,"Hakuda"=15,"Zanjutsu"=15,"Kidou"=15)
				GoldValue=520000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Leather"=5,"Thread"=5,"Mithril"=2,"MeteorFragment"=1)
				desc="An insanely powerful cloak, not to mention expensive.."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +60  <br> VIT +60  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800 <br> MGCDEF +10 <br> Hohou +15 <br> Zanjutsu +15 <br> Hakuda +15 <br> Kidou +15 <br><font color=yellow>Damage Reduce +1%"
				icon_state="Vanish Mantle";mouse_drag_pointer="Vanish Mantle"
			The_Cloak_Of_Zeus
				LvlReq=100
				oname="The Cloak of Zeus"
				StatBoosts=list("STR"=100,"MGC"=100,"AGI"=100,"VIT"=75,"MGCDEF"=150,"MaxSTM"= 1500,"MaxREI"=1500,"ShieldBonus"=2,"Hohou"=30,"Hakuda"=30,"Zanjutsu"=30,"Kidou"=30)
				GoldValue=200000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Leather"=30,"Thread"=30,"Iron"=3,"DivineOre"=1, "Mithril"=2)
				desc="The ultimate Cloak, crafted by Zeus himself. Rumor has it that it can be upgraded."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +100 <br> STR +100 <br> AGI +100  <br> VIT +75<br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1500 <br> MaxREI +1500  <br> Hohou +30 <br> Zanjutsu +30 <br> Hakuda +30 <br> Kidou +30 <br><font color=yellow>Damage Reduce +2% <br><font color=red>Requires level 100"
				icon_state="Elf Mantle";mouse_drag_pointer="Elf Mantle"

			Sakkaku //Agsilles
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=100,"MGC"=200,"AGI"=150,"VIT"=250,"MGCDEF"=300,"MaxSTM"= 7000,"Hakuda"=200,"Hohou"=250,"Kidou"=50,"DodgeBonus"=25)
				GoldValue=130000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="This cape is too powerful to identify its properties"
				desc2="Can not be identified"
				icon_state="Wizard Mantle";mouse_drag_pointer="Wizard Mantle"

			Festive_Cloak
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=300,"MGC"=300,"AGI"=300,"VIT"=300,"MaxSTM"= 4000,"MaxREI"=4000,"Hohou"=150,"Hakuda"=150,"Zanjutsu"=150,"Kidou"=150,"ShieldBonus"=10)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=5000
				desc="A festive cloak, only obtainable during Holiday seasons."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +300 <br> STR +300 <br> AGI +300  <br> VIT +300 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +4000 <br> MaxREI +4000  <br> Hohou +150 <br> Zanjutsu +150 <br> Hakuda +150 <br> Kidou +150 <br><font color=yellow>Damage Reduce +10% <br><font color=yellow> Can not be Refined"
				icon_state="Elf Mantle";mouse_drag_pointer="Elf Mantle"
			Sanguine_Cloak
				LvlReq=50
				oname="Sanguine Cloak"
				StatBoosts=list("STR"=150,"MGC"=150,"AGI"=150,"VIT"=150,"MaxSTM"= 1800,"MaxREI"=1800,"Hohou"=50,"Hakuda"=50,"Zanjutsu"=50,"Kidou"=50,"ShieldBonus"=1)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=100
				SalvageItems=list("Leather"=6,"Thread"=5,"Mithril"=3,"Iron"=2,"MeteorFragment"=1,"DivineOre"=1)
				desc="The Sanguine Cloak offers superior protection and boosts, it is said to have been crafted from the Master of Sanguine Village."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> STR +150 <br> AGI +150  <br> VIT +150 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1800 <br> MaxREI +1800  <br> Hohou +50 <br> Zanjutsu +50 <br> Hakuda +50 <br> Kidou +50 <br><font color=yellow>Damage Reduce +1%<br><font color=red>Requires level 50"
				icon_state="Elf Mantle";mouse_drag_pointer="Elf Mantle"
			Midnight_Cloak
				LvlReq=50
				Unique=1
				Epic=1
				oname="Midnight Cloak"
				StatBoosts=list("STR"=220,"MGC"=220,"AGI"=125,"VIT"=220,"MaxSTM"= 3000,"MaxREI"=3000,"Hohou"=100,"Hakuda"=100,"Zanjutsu"=100,"Kidou"=100,"ShieldBonus"=2)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=200
				SalvageItems=list("Leather"=20,"Thread"=20,"Mithril"=5,"Iron"=5,"MeteorFragment"=3,"DivineOre"=1)
				desc="The Midnight Cloak, plain looking yet it bestows immense power."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +220 <br> STR +220 <br> AGI +125  <br> VIT +220 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +3000 <br> MaxREI +3000  <br> Hohou +100 <br> Zanjutsu +100 <br> Hakuda +100 <br> Kidou +200 <br><font color=yellow>Damage Reduce +2% <br><font color=red>Requires level 500<br><br><font color=green>SET BONUS (cloak)<br>Bestows immunity to Aizen's mind control ability.<br><br><i><font color=orange>Set bonus activated once all pieces of the set are equipped also + 100% exp boost and 20% honor boost gained.</font>"
				icon_state="Dracula Mantle";mouse_drag_pointer="Dracula Mantle"

		Head
			Slot="Head"
			icon='Helmets.dmi'
			Toy_Vaizard_Mask
				noenchant=1
				nosalvage=1
				name="Toy Vaizard Mask"
				icon='BlankVaizardMask.dmi'
				GoldValue=1;SilvValue=0;CoprValue=0
				desc="A paper mache Vaizard Mask"
				mouse_drag_pointer=""
				OnEquip(var/mob/M)
					M.overlays+=new/obj/EquipmentOverlays/BlankVaizardMask
				OnUnEquip(var/mob/M)
					for(var/x in M.overlays)	if(x:name=="BlankVaizardMask")	M.overlays-=x
			Charred_Helmet
				LvlReq=50
				noenchant=1
				GoldValue=130;SilvValue=3;CoprValue=0
				StatBoosts=list("MGC"=15,"STR"=50,"AGI"=50,"VIT"=15,"MGCDEF"=100,"MaxSTM"= 500,"MaxREI"=500, "Income"=200)
				SalvageItems=list("Iron"=2,"Leather"=1)
				GoldValue=15;SilvValue=0;CoprValue=0
				desc="The remainder of a once powerful helm, now burned and rendered down to a mere circlet."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +15 <br> STR +50 <br> AGI +50  <br> VIT +15  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500 <br> MGCDEF +100  <br> Income +200 <br><font color=yellow> Can not be Refined."
				icon_state="Circlet";mouse_drag_pointer="Circlet"
			Silver_Helm
				noenchant=1
				nosalvage=1
				StatBoosts=list("MGC"=30,"STR"=30,"AGI"=15,"VIT"=30,"MGCDEF"=15,"MaxSTM"= 200,"MaxREI"=200)
				GoldValue=3500;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Iron"=1)
				desc="A helm of pure silver, beautifully crafted."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC 30 <br> STR 30 <br> AGI +15  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200 <br> MGCDEF +15 <br><font color=yellow> Can not be Refined."
				icon_state="Platinum Helmet";mouse_drag_pointer="Platinum Helmet"
			Crystal_Helm
				noenchant=1
				nosalvage=1
				StatBoosts=list("MGC"=60,"STR"=60,"AGI"=30,"VIT"=60,"MGCDEF"=30,"MaxSTM"= 500,"MaxREI"=500)
				GoldValue=5500;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Mithril"=1,"Leather"=1,"Iron"=1)
				desc="A helm made of crystal quartz, it provides high magical defense. At worst it can blind your enemies!"
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +30  <br> VIT +60 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500 <br> MGCDEF +30 <br><font color=yellow> Can not be Refined."
				icon_state="Crystal Helmet";mouse_drag_pointer="Crystal Helmet"
			Hollowbone_Helmet
				oname="Hollowbone Helmet"
				StatBoosts=list("STR"=40,"MGC"=40,"AGI"=10,"VIT"=15,"LCK"=20,"MaxSTM"= 200,"MaxREI"=200,"ImmunityBonus"=1)
				GoldValue=50000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Iron"=1,"Bones"=1)
				desc="The helmet is made from the bones of a beast Hollow, it is highly durable."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +40 <br> STR +40 <br> AGI +10  <br> VIT +15 <br> LCK +20 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200  <br><font color=yellow>Immunity from stuns/binds +1%"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			The_Deceiver
				oname="The Deceiver"
				StatBoosts=list("STR"=60,"MGC"=60,"AGI"=50,"VIT"=50,"LCK"=20,"MaxSTM"= 700,"MaxREI"=700,"Hakuda"=20)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=1
				SalvageItems=list("Iron"=4,"Mithril"=3)
				desc="Aptly named, this helm once provided the user with invisibility."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +50  <br> VIT +50<br> LCK +20 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +700 <br> MaxREI +700  <br> Hakuda +20"
				icon_state="Barbuta";mouse_drag_pointer="Barbuta"
			Cowl_of_Infinity
				oname="Cowl of Infinity"
				StatBoosts=list("STR"=100,"MGC"=100,"AGI"=75,"VIT"=100,"LCK"=15,"MaxSTM"= 1500,"MaxREI"=1500,"Hakuda"=15,"Hohou"=15,"Kidou"=15,"Zanjutsu"=15)
				GoldValue=2000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Iron"=15,"Leather"=30,"DivineOre"=1,"MeteorFragment"=5)
				desc="The Cowl of Infinity. It it said this item can be upgraded into a more powerful version."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +100 <br> STR +100 <br> AGI +75  <br> VIT +100<br> LCK +15 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1500 <br> MaxREI +1500  <br> Hohou +15 <br> Zanjutsu +15 <br> Hakuda +15 <br> Kidou +15 "
				icon_state="Barbuta";mouse_drag_pointer="Barbuta"
			Acaliptos
				oname="Acaliptos"
				StatBoosts=list("STR"=250,"MGC"=250,"AGI"=200,"VIT"=200,"LCK"=100,"MaxSTM"= 4000,"MaxREI"=4000,"Hakuda"=100,"Hohou"=100,"Kidou"=100,"Zanjutsu"=100)
				GoldValue=2000;SilvValue=0;CoprValue=0;BadgesValue=0
				SalvageItems=list("Iron"=30,"Leather"=30,"DivineOre"=5,"MeteorFragment"=5,"EnchantedOre"=10)
				desc="The Acaliptos helm. One of the most powerful helmets available."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +250 <br> STR +250 <br> AGI +200  <br> VIT +200<br> LCK +100 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +4000 <br> MaxREI +4000  <br> Hohou +100 <br> Zanjutsu +100 <br> Hakuda +100 <br> Kidou +100 "
				icon_state="Barbuta";mouse_drag_pointer="Barbuta"
		/*	Omen_Of_Aspiration
				LvlReq=150
				StatBoosts=list("STR"=90,"MGC"=90,"AGI"=50,"VIT"=90,"MGCDEF"=50,"MaxSTM"= 800,"MaxREI"=800,"Income"=100)
				GoldValue=13000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="A powerful helmet made from platinum.(LVL 150)"
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +90 <br> STR +90 <br> AGI +50  <br> VIT +90  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800 <br> MGCDEF +50 <br> Income 100<br><br><font color=red>Requires level 150"
				icon_state="Platinum Helmet";mouse_drag_pointer="Platinum Helmet"*/
			Too_Smexy_For_You //Anonymous
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=1000,"Income"=2500,"ShieldBonus"=20,"Zanjutsu"=500,"HonorSet"=2)
				GoldValue=100000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="These boots are too powerful to identify"
				desc2="Can not be identified"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"

			Dokuro //Agsilles
				LvlReq=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=100,"MGC"=200,"AGI"=150,"VIT"=250,"MGCDEF"=300,"MaxSTM"= 7000,"Hakuda"=200,"Hohou"=250,"Kidou"=50,"ShieldBonus"=35,"Immunity"=25)
				GoldValue=130000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="This helmet is too powerful to identify its properties"
				desc2="Can not be identified<br><font color=yellow> Can not be Refined"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			Tramps_Helm //Agsilles
				LvlReq=1
				Unique=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=600,"VIT"=400,"MaxSTM"= 1000,"Hakuda"=100,"Zanjutsu"=400,"ShieldBonus"=30,"Income"=1000)
				GoldValue=130000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="This helmet is too powerful to identify its properties"
				desc2="Can not be identified<br><font color=yellow> Can not be Refined"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			Crown_of_The_Immortals //Agsilles
				LvlReq=1
				Unique=1
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=1000,"MaxSTM"= 1000,"Hakuda"=100,"Hohou"=500,"MaxSTM"= 2000,"DodgeBonus"=10,"CritBonus"=15)
				GoldValue=130000;SilvValue=0;CoprValue=0;BadgesValue=0
				desc="This helmet is too powerful to identify its properties"
				desc2="Can not be identified<br><font color=yellow> Can not be Refined"
				icon_state="Platinum Helmet";mouse_drag_pointer="Platinum Helmet"
			Festive_Helmet
				noenchant=1
				nosalvage=1
				StatBoosts=list("STR"=500,"MGC"=500,"AGI"=500,"VIT"=500,"MaxSTM"= 5000,"MaxREI"=5000,"Hohou"=80,"Hakuda"=80,"Zanjutsu"=80,"Kidou"=80,"ShieldBonus"=15,"DodgeBonus"=25)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=7500
				desc="MGC/STR/AGI/Vit +500 > MaxSTM/Rei +5000 > Dmg Reduce +15 Dodge Bonus + 25 > Hohou/Zan/Haku/Kid +80  > "
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +500 <br> STR +400 <br> AGI +500  <br> VIT +500 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +5000 <br> MaxREI +5000  <br> Hohou +80 <br> Zanjutsu +80 <br> Hakuda +80 <br> Kidou +80 <br><font color=yellow>Damage Reduce +15% <br> Chance to Dodge +25%<br><font color=yellow> Can not be Refined"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			Moon_of_The_Reflecting_Water //Nikorayu
				noenchant=1
				nosalvage=1
				StatBoosts=list("Zanjutsu"=500,"STR"=1000,"CritBonus"=20,"DodgeBonus"=20)
				GoldValue=100000;SilvValue=3;CoprValue=0
				desc="A rare and unique helmet, customized by the Gods themselves.. > Immensely increases your power - Unique"
				desc2="Can not be identified<br><font color=yellow> Can not be Refined"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			Sanguine_Helm
				LvlReq=50
				oname="Sanguine Helm"
				StatBoosts=list("STR"=125,"MGC"=125,"AGI"=125,"VIT"=125,"MaxSTM"= 1500,"MaxREI"=1500,"Hohou"=20,"Hakuda"=20,"Zanjutsu"=20,"Kidou"=20,"ShieldBonus"=1,"DodgeBonus"=1)
				SalvageItems=list("Iron"=10,"Leather"=10,"MeteorFragment"=2,"EnchantedOre"=2)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=80
				desc="The Sanguine Helm offers superior protection and boosts, it is said to have been crafted from the Master of Sanguine Village."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +125 <br> STR +125 <br> AGI +125  <br> VIT +125 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1500 <br> MaxREI +1500  <br> Hohou +20 <br> Zanjutsu +20 <br> Hakuda +20 <br> Kidou +20 <br><font color=yellow>Damage Reduce +1% <br> Chance to Dodge +1%<br><br><font color=red>Requires level 50"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"
			Midnight_Helm
				LvlReq=500
				Unique=1
				Epic=1
				oname="Midnight Helm"
				StatBoosts=list("STR"=300,"MGC"=300,"AGI"=150,"VIT"=150,"MaxSTM"= 4000,"MaxREI"=4000,"Hohou"=130,"Hakuda"=130,"Zanjutsu"=130,"Kidou"=130,"ShieldBonus"=1,"DodgeBonus"=2)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=200
				SalvageItems=list("Iron"=20,"Leather"=20,"MeteorFragment"=2,"EnchantedOre"=2,"DivineOre"=5,"Mithril"=1)
				desc="The Midnight Helm appears no different than normal headgear, yet it emits a dark aura of power."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +300 <br> STR +300 <br> AGI +150  <br> VIT +150 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +4000 <br> MaxREI +4000  <br> Hohou +130 <br> Zanjutsu +130 <br> Hakuda +130 <br> Kidou +130 <br><font color=yellow>Damage Reduce +1% <br> Chance to Dodge +1%<br><br><font color=red>Requires level 500<br><br><font color=green>SET BONUS (head)<br>Has a chance to heal self and group to full STM/REI.<br><br><i><font color=orange>Set bonus activated once all pieces of the set are equipped also + 100% exp boost and 20% honor boost gained.</font>"
				icon_state="Bronze Helmet";mouse_drag_pointer="Bronze Helmet"
			Beastskin_helm
				LvlReq=60
				Unique=1
				Epic=1
				nosalvage=1
				oname="Beastskin helm"
				StatBoosts=list("STR"=50,"MGC"=50,"AGI"=30,"VIT"=30,"LCK"=20,"MaxSTM"= 800,"MaxREI"=800,"Hakuda"=5,"Kidou"=5,"Zanjutsu"=5)
				GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=5
				desc="Created from the bones and skin of a Wild Beast, this helm provides excellent protection and grants the user the ability to see invisible foes."
				desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +50 <br> STR +50 <br> AGI +30  <br> VIT +30<br> LCK +20 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800  <br> Hakuda +5 <br> Zanjutsu +5 <br> Kidou +5"
				icon_state="Genji Helmet";mouse_drag_pointer="Genji Helmet"


		Body
			Slot="Body"
			icon='Robes.dmi'
			Clothes
				LvlReq=1
				StatBoosts=list("VIT"=1)
				GoldValue=0;SilvValue=2;CoprValue=0
				desc="Some plain clothes. > Increases VIT by 1"
				icon_state="Clothes";mouse_drag_pointer="Clothes"
			Mystic
				Cloth_Tunic
					nosalvage=1
					noenchant=1
					icon_state="Cloth Tunic";mouse_drag_pointer="Cloth Tunic"
					LvlReq=5
				Linen_Robe
					nosalvage=1
					noenchant=1
					icon_state="Linen Robe";mouse_drag_pointer="Linen Robe"
					LvlReq=10
				Linen_Jacket
					nosalvage=1
					noenchant=1
					icon_state="Linen Jacket";mouse_drag_pointer="Linen Jacket"
					LvlReq=15
				Silk_Robe
					nosalvage=1
					noenchant=1
					icon_state="Silk Robe";mouse_drag_pointer="Silk Robe"
					LvlReq=20
				Fire_Tunic
					nosalvage=1
					noenchant=1
					icon_state="Fire Tunic";mouse_drag_pointer="Fire Tunic"
					LvlReq=25
				Wizard_Robe
					nosalvage=1
					noenchant=1
					icon_state="Wizard Robe";mouse_drag_pointer="Wizard Robe"
					LvlReq=30
				Holy_Cloak
					nosalvage=1
					noenchant=1
					icon_state="Holy Cloak";mouse_drag_pointer="Holy Cloak"
					LvlReq=35
				Chameleon_Robe
					nosalvage=1
					noenchant=1
					icon_state="Chameleon Robe";mouse_drag_pointer="Chameleon Robe"
					LvlReq=40
				Clerics_Robe
					nosalvage=1
					noenchant=1
					icon_state="Clerics Robe";mouse_drag_pointer="Clerics Robe"
					LvlReq=45
				White_Robe
					nosalvage=1
					noenchant=1
					icon_state="White Robe";mouse_drag_pointer="White Robe"
					LvlReq=50
				Ceremonial_Uniform
					nosalvage=1
					noenchant=1
					icon_state="Ceremonial Uniform";mouse_drag_pointer="Ceremonial Uniform"
					LvlReq=55
				Black_Robe
					nosalvage=1
					noenchant=1
					icon_state="Black Robe";mouse_drag_pointer="Black Robe"
					LvlReq=60
				Golden_Dressings
					nosalvage=1
					noenchant=1
					icon_state="Golden Dressings";mouse_drag_pointer="Golden Dressings"
					LvlReq=65
				Light_Robe
					nosalvage=1
					noenchant=1
					icon_state="Light Robe";mouse_drag_pointer="Light Robe"
					LvlReq=70
				Wizard_Outfit
					nosalvage=1
					noenchant=1
					icon_state="Wizard Outfit";mouse_drag_pointer="Wizard Outfit"
					LvlReq=70
				Brigandine
					nosalvage=1
					noenchant=1
					icon_state="Brigandine";mouse_drag_pointer="Brigandine"
					LvlReq=70
				Power_Sleeve
					nosalvage=1
					noenchant=1
					icon_state="Power Sleeve";mouse_drag_pointer="Power Sleeve"
					LvlReq=70
				Earth_Clothes
					nosalvage=1
					noenchant=1
					icon_state="Earth Clothes";mouse_drag_pointer="Earth Clothes"
					LvlReq=70
				Secret_Clothes
					nosalvage=1
					noenchant=1
					icon_state="Secret Clothes";mouse_drag_pointer="Secret Clothes"
					LvlReq=70
				Black_Costume
					nosalvage=1
					noenchant=1
					icon_state="Black Costume";mouse_drag_pointer="Black Costume"
					LvlReq=70
				Rubber_Costume
					nosalvage=1
					noenchant=1
					icon_state="Rubber Costume";mouse_drag_pointer="Rubber Costume"
					LvlReq=70
				Grand_Cloak
					nosalvage=1
					noenchant=1
					icon_state="Grand Cloak";mouse_drag_pointer="Grand Cloak"
					LvlReq=75
				Robe_of_Lords
					nosalvage=1
					noenchant=1
					icon_state="Robe of Lords";mouse_drag_pointer="Robe of Lords"
					LvlReq=80
				Mystic_Plate_Mail
					nosalvage=1
					noenchant=1
					icon_state="Mystic Plate Mail";mouse_drag_pointer="Mystic Plate Mail"
					LvlReq=85

				The_Robe_of_Power
					noenchant=1
					icon_state="Robe of Lords";mouse_drag_pointer="Robe of Lords"
					GoldValue=150;SilvValue=3;CoprValue=0
					SalvageItems=list("Leather"=3,"Thread"=2)
					StatBoosts=list("MGC"=100,"AGI"=50,"VIT"=50,"MGCDEF"=100,"MaxREI"=1000,"MaxSTM"=1000,"Kidou"=25)
					GoldValue=20;SilvValue=0;CoprValue=50
					desc="The Robe of Power, little is known of its origin. It offers great power and defence.(LVL 50)>"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +100 <br> AGI +50  <br> VIT +50  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1000 <br> MaxREI +1000 <br> MGCDEF +100  <br> Kidou +25<br><BR><font color=red>Requires level 50<br><font color=yellow>Can not be Refined."
					icon_state="Robe of Lords";mouse_drag_pointer="Robe of Lords"
					LvlReq=50
				Shadowsilk_Robe
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=30,"STR"=30,"AGI"=15,"VIT"=30,"MGCDEF"=15,"MaxSTM"= 200,"MaxREI"=200)
					GoldValue=500;SilvValue=0;CoprValue=0;BadgesValue=0
					SalvageItems=list("Leather"=1,"Thread"=2)
					desc="A dark robe made of silk."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC 30 <br> STR 30 <br> AGI +15  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200 <br> MGCDEF +15<br><font color=yellow>Can not be Refined."
					icon_state="Secret Clothes";mouse_drag_pointer="Secret Clothes"
				Frostfire_Robe
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=60,"STR"=60,"AGI"=30,"VIT"=60,"MGCDEF"=30,"MaxSTM"= 500,"MaxREI"=500)
					SalvageItems=list("Leather"=1,"Thread"=2)
					GoldValue=1500;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A robe woven with golden threads which blaze like fire when light strikes it."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +30  <br> VIT +60 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500 <br> MGCDEF +30<br><font color=yellow>Can not be Refined."
					icon_state="Golden Dressings";mouse_drag_pointer="Golden Dressings"
				Robe_of_Illusions
					noenchant=1
					StatBoosts=list("STR"=150,"MGC"=150,"AGI"=100,"MGCDEF"=100,"VIT"=90,"MaxSTM"= 800,"MaxREI"=1500,"ReiRegenBonus"=8)
					SalvageItems=list("Leather"=1,"Thread"=1,"EnchantedOre"=1)
					GoldValue=50000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A peculiar robe made from an unknown material."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> STR +150 <br> AGI +100  <br> VIT +90 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +1500 <br> <font color=yellow>Regenerates Rei faster.<br><font color=yellow>Can not be Refined."
					icon_state="Grand Cloak";mouse_drag_pointer="Grand Cloak"
			/*	Omen_Of_Arcana
					LvlReq=150
					StatBoosts=list("STR"=40,"MGC"=150,"AGI"=50,"VIT"=90,"MGCDEF"=50,"MaxSTM"= 800,"MaxREI"=1800,"Kidou"=40)
					GoldValue=14000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A well crafted robe with various patterns and symbols.(LVL 150)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> STR +40 <br> AGI +50  <br> VIT +90  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +1800 <br> MGCDEF +50 <br> Kidou + 40<br><br><font color=red>Requires level 150"
					icon_state="Wizard Outfit";mouse_drag_pointer="Wizard Outfit"*/
				Celestial_Cloth
					LvlReq=100
					oname="Celestial Cloth"
					StatBoosts=list("STR"=50,"MGC"=150,"AGI"=90,"VIT"=30,"MaxSTM"= 300,"MaxREI"=800,"Kidou"=15,"Hohou"=5)
					GoldValue=10000;SilvValue=0;CoprValue=0;BadgesValue=0
					SalvageItems=list("Leather"=5,"Thread"=3,"EnchantedOre"=1,"MeteorFragment"=2)
					desc="A robe made by the Gods, it it especially efficient for Rei types.(LVL 100)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> STR +50 <br> AGI +90  <br> VIT +30  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +300 <br> MaxREI +800 <br> Kidou +15 <br> Hohou +5<br><br><font color=red>Requires level 100"
					icon_state="Ceremonial Uniform";mouse_drag_pointer="Ceremonial Uniform"


			Armor
				icon='Armor.dmi'
				Copper_Breastplate
					nosalvage=1
					noenchant=1
					icon_state="Copper Breastplate";mouse_drag_pointer="Copper Breastplate"
					LvlReq=5
				Leather_Armor
					nosalvage=1
					noenchant=1
					icon_state="Leather Armor";mouse_drag_pointer="Leather Armor"
					LvlReq=10
				Onyx_Armor
					nosalvage=1
					noenchant=1
					icon_state="Onyx Armor";mouse_drag_pointer="Onyx Armor"
					LvlReq=15
				Linen_Cuirass
					nosalvage=1
					noenchant=1
					icon_state="Linen Cuirass";mouse_drag_pointer="Linen Cuirass"
					LvlReq=20
				Iron_Mail
					nosalvage=1
					noenchant=1
					icon_state="Iron Mail";mouse_drag_pointer="Iron Mail"
					LvlReq=25
				Bronze_Armor
					nosalvage=1
					noenchant=1
					icon_state="Bronze Armor";mouse_drag_pointer="Bronze Armor"
					LvlReq=30
				Breaker_Gear
					nosalvage=1
					noenchant=1
					icon_state="Breaker Gear";mouse_drag_pointer="Breaker Gear"
					LvlReq=35
				Chain_Mail
					nosalvage=1
					noenchant=1
					icon_state="Chain Mail";mouse_drag_pointer="Chain Mail"
					LvlReq=40
				Jade_Encrusted_Armor
					nosalvage=1
					noenchant=1
					icon_state="Jade Encrusted Armor";mouse_drag_pointer="Jade Encrusted Armor"
					LvlReq=45
				Mythril_Armor
					nosalvage=1
					noenchant=1
					icon_state="Mythril Armor";mouse_drag_pointer="Mythril Armor"
					LvlReq=50
				Royal_Plate_Mail
					nosalvage=1
					noenchant=1
					icon_state="Royal Plate Mail";mouse_drag_pointer="Royal Plate Mail"
					LvlReq=55
				Plate_Mail
					nosalvage=1
					noenchant=1
					icon_state="Plate Mail";mouse_drag_pointer="Plate Mail"
					LvlReq=60
				Guardians_Uniform
					nosalvage=1
					noenchant=1
					icon_state="Guardians Uniform";mouse_drag_pointer="Guardians Uniform"
					LvlReq=65
				Gold_Armor
					nosalvage=1
					noenchant=1
					icon_state="Gold Armor";mouse_drag_pointer="Gold Armor"
					LvlReq=70
				Blackened_Breastplate
					nosalvage=1
					noenchant=1
					icon_state="Blackened Breastplate";mouse_drag_pointer="Blackened Breastplate"
					LvlReq=75
				Diamond_Armor
					nosalvage=1
					noenchant=1
					icon_state="Diamond Armor";mouse_drag_pointer="Diamond Armor"
					LvlReq=80
				Oblivions_Darkest
					nosalvage=1
					noenchant=1
					icon_state="Oblivions Darkest";mouse_drag_pointer="Oblivions Darkest"
					LvlReq=85
				Platinum_Armor
					nosalvage=1
					noenchant=1
					icon_state="Platinum Armor";mouse_drag_pointer="Platinum Armor"
					LvlReq=90
				Leather_Outfit
					icon_state="Leather Outfit";mouse_drag_pointer="Leather Outfit"
					LvlReq=90
				Leather_Vest
					icon_state="Leather Vest";mouse_drag_pointer="Leather Vest"
					LvlReq=90
				Chain_Vest
					icon_state="Chain Vest";mouse_drag_pointer="Chain Vest"
					LvlReq=90
				Mythril_Vest
					icon_state="Mythril Vest";mouse_drag_pointer="Mythril Vest"
					LvlReq=90
				Adamant_Vest
					icon_state="Adamant Vest";mouse_drag_pointer="Adamant Vest"
					LvlReq=90
				Judo_Outfit
					icon_state="Judo Outfit";mouse_drag_pointer="Judo Outfit"
					LvlReq=90
				Carbani_Armor
					icon_state="Carbani Armor";mouse_drag_pointer="Carbani Armor"
					LvlReq=100

				Crystal_Mail
					icon_state="Crystal Mail";mouse_drag_pointer="Crystal Mail"
					LvlReq=110

				Genji_Armor
					icon_state="Genji Armor";mouse_drag_pointer="Genji Armor"
					LvlReq=120

				Reflect_Armor
					icon_state="Reflect Armor";mouse_drag_pointer="Reflect Armor"
					LvlReq=130

				Maximillian
					icon_state="Maximillian";mouse_drag_pointer="Maximillian"
					LvlReq=140

				The_Vermillion
					LvlReq=50
					noenchant=1
					GoldValue=150;SilvValue=3;CoprValue=0
					StatBoosts=list("VIT"=100,"MGCDEF"=100,"STR"=100,"Zanjutsu"=25, "MaxSTM"=1300)
					SalvageItems=list("Leather"=1,"Thread"=1,"Iron"=1)
					GoldValue=20;SilvValue=0;CoprValue=50
					desc="The Vermillion armor, made from the bones of dead Hollows. It offers great protection against Magical arts.>"
					desc2="<center><font color=red><i>STATS</i></font></center><br> STR +100 <br> VIT +100  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1300 <br> MGCDEF +100<br><br><font color=red>Requires level 50<br><font color=yellow>Can not be Refined."
					icon_state="Maximillian";mouse_drag_pointer="Maximillian"
				Enchanted_Breastplate
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=30,"STR"=30,"AGI"=15,"VIT"=30,"MGCDEF"=15,"MaxSTM"= 200,"MaxREI"=200)
					SalvageItems=list("Leather"=1,"Thread"=1,"Iron"=1)
					GoldValue=500;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="An iron breastplate engraved with various mystic runes."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC 30 <br> STR 30 <br> AGI +15  <br> VIT +30 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +200 <br> MaxREI +200 <br> MGCDEF +15<br><font color=yellow>Can not be Refined."
					icon_state="Breaker Gear";mouse_drag_pointer="Breaker Gear"
				Bloodstained_Battlearmor
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=60,"STR"=60,"AGI"=30,"VIT"=60,"MGCDEF"=30,"MaxSTM"= 500,"MaxREI"=500)
					SalvageItems=list("Leather"=1,"Thread"=1,"Iron"=1)
					GoldValue=1500;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="Battle armor of the highest quality."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +60 <br> STR +60 <br> AGI +30  <br> VIT +60 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500 <br> MGCDEF +30<br><font color=yellow>Can not be Refined."
					icon_state="Oblivions Darkest";mouse_drag_pointer="Oblivions Darkest"
				Immortality
					oname="Immortality"
					StatBoosts=list("STR"=50,"MGC"=50,"AGI"=35,"MGCDEF"=10,"VIT"=20,"MaxSTM"= 800,"MaxREI"=250,"StmRegenBonus"=1)
					SalvageItems=list("Leather"=1,"Thread"=1,"Iron"=2)
					GoldValue=250000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="Armor named for its durability and superior protection."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +50 <br> STR +50 <br> AGI +35  <br> VIT +20 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +250 <br> <font color=yellow>Regenerates STM faster."
					icon_state="Blackened Breastplate";mouse_drag_pointer="Blackened Breastplate"
			/*	Omen_Of_Resilience
					LvlReq=150
					StatBoosts=list("STR"=150,"MGC"=40,"AGI"=50,"VIT"=90,"MGCDEF"=50,"MaxSTM"= 1800,"MaxREI"=800,"Zanjutsu"=40)
					GoldValue=14000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="This armor shields its wearer from most damage and boosts combat capabilities.(LVL 150)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +40 <br> STR +150 <br> AGI +50  <br> VIT +90  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1800 <br> MaxREI +800 <br> MGCDEF +50 <br> Zanjutsu + 40<br><br><font color=red>Requires level 150"
					icon_state="Secret Clothes";mouse_drag_pointer="Secret Clothes"*/
				Celestial_Plate
					LvlReq=100
					oname="Celestial Plate"
					StatBoosts=list("STR"=150,"MGC"=50,"AGI"=90,"MaxSTM"= 800,"MaxREI"=300,"VIT"=25,"Hohou"=5, "Zanjutsu"=20)
					GoldValue=10000;SilvValue=0;CoprValue=0;BadgesValue=0
					SalvageItems=list("Iron"=4,"Thread"=3,"EnchantedOre"=1,"MeteorFragment"=2)
					desc="Armor made by the Gods, the wearer is greatly rewarded.(LVL 100)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +50 <br> STR +150 <br> AGI +25  <br> VIT +90  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +300 <br> Zanjutsu +20 <br> Hohou +5<br><br><font color=red>Requires level 100"
					icon_state="Guardians Uniform";mouse_drag_pointer="Guardians Uniform"
				Hymn_Of_Invulnerability
					LvlReq=150
					oname="Hymn of Invulnerability"
					StatBoosts=list("STR"=75,"MGC"=75,"AGI"=50,"VIT"=50,"LCK"=10,"MaxSTM"= 800,"MaxREI"=800,"Hohou"=5,"Zanjutsu"=5,"ImmunityBonus"=1)
					SalvageItems=list("Leather"=5,"Thread"=3,"EnchantedOre"=1)
					GoldValue=800000;;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A masterpiece and one of the most powerful pieces of armor. (LVL 150)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +75 <br> STR +75 <br> AGI +50  <br> VIT +50  <br> LCK +10 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +800 <br> MaxREI +800 <br> Zanjutsu +5 <br> Hohou +5<br> <font color=yellow>Immuny from binds/stun +1% <br><br><font color=red>Requires level 150"
					icon_state="Copper Breastplate";mouse_drag_pointer="Copper Breastplate"


				ExoSkeleton
					LvlReq=1
					oname="ExoSkeleton"
					StatBoosts=list("STR"=100,"MGC"=100,"AGI"=100,"VIT"=100,"LCK"=100,"MGCDEF"=20,"MaxSTM"= 1000,"MaxREI"=1000,"ShieldBonus"=1,"Hohou"=20,"Hakuda"=20,"Zanjutsu"=20,"Kidou"=20,"ImmunityBonus"=1,"Income"=350)
					SalvageItems=list("Bones"=15,"Thread"=10,"EnchantedOre"=2,"MeteorFragment"=4,"Gems"=5,"Mithril"=1)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=20
					desc="Supreme armor, excellent protection and boosts. Can be upgraded."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +100 <br> STR +100 <br> AGI +100  <br> VIT +100  <br> LCK 100 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1000 <br> MaxREI +1000 <br> Kidou +20 <br> Hohou +20 <br> Zanjutsu +20 <br> Hakuda +20 <br> Income +350 <br><font color=yellow>Immune from stun/bind +1% <br> Damage Reduction +1%"
					icon_state="Linen Cuirass";mouse_drag_pointer="Linen Cuirass"

				Dread_Lord_Mantle
					LvlReq=1
					Unique=1
					oname="Dread Lord Mantle"
					StatBoosts=list("STR"=150,"MGC"=150,"AGI"=150,"VIT"=150,"LCK"=150,"MGCDEF"=25,"MaxSTM"= 1500,"MaxREI"=1500,"ShieldBonus"=1,"Hohou"=50,"Hakuda"=50,"Zanjutsu"=50,"Kidou"=50,"ImmunityBonus"=1,"Income"=450,"HonorSet"=1)
					SalvageItems=list("Bones"=30,"Thread"=30,"EnchantedOre"=5,"MeteorFragment"=8,"Gems"=10,"Mithril"=3)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=5
					desc="The upgraded version of the ExoSkeleton. This can be upgraded again."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> STR +150 <br> AGI +150  <br> VIT +150  <br> LCK 150 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1500 <br> MaxREI +1500 <br> Kidou +50 <br> Hohou +50 <br> Zanjutsu +50 <br> Hakuda +50 <br> Income +450 <br> MGCDEF +25 <br><font color=yellow> Honor Bonus +1 <br> Immune from stun/bind +1% <br> Damage Reduction +1%"
					icon_state="Linen Cuirass";mouse_drag_pointer="Linen Cuirass"
				Athanatos
					LvlReq=1
					Unique=1
					oname="Athanatos"
					StatBoosts=list("STR"=250,"MGC"=250,"AGI"=250,"VIT"=250,"LCK"=150,"MGCDEF"=50,"MaxSTM"= 4000,"MaxREI"=4000,"ShieldBonus"=1,"Hohou"=100,"Hakuda"=100,"Zanjutsu"=100,"Kidou"=100,"ImmunityBonus"=1,"Income"=800,"HonorSet"=1)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=5
					SalvageItems=list("Bones"=50,"Thread"=30,"EnchantedOre"=10,"MeteorFragment"=12,"Gems"=20,"Mithril"=5,"DivineOre"=2)
					desc="Literally meaning The Immortal, this armor certainly lives up to its name."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +250 <br> STR +250 <br> AGI +250  <br> VIT +250  <br> LCK 150 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +4000 <br> MaxREI +4000 <br> Kidou +100 <br> Hohou +100 <br> Zanjutsu +100 <br> Hakuda +100 <br> Income +800 <br> MGCDEF +50 <br><font color=yellow> Honor Bonus +1 <br> Immune from stun/bind +1% <br> Damage Reduction +1%"
					icon_state="Linen Cuirass";mouse_drag_pointer="Linen Cuirass"
				Festive_Armor
					LvlReq=1
					noenchant=1
					nosalvage=1
					StatBoosts=list("STR"=1500,"MGC"=1500,"AGI"=1500,"VIT"=1500,"LCK"=1500,"MaxSTM"= 15000,"MaxREI"=15000,"ShieldBonus"=30,"Hohou"=250,"Hakuda"=250,"Zanjutsu"=250,"Kidou"=250,"ImmunityBonus"=30,"Income"=4000,"HonorSet"=11)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=15000
					desc="Armor onbtainable only during Holiday seasons."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +1500 <br> STR +1500 <br> AGI +1500  <br> VIT +1500 <br> LCK +1500 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +15000 <br> MaxREI +15000  <br> Hohou +250 <br> Zanjutsu +250 <br> Hakuda +250 <br> Kidou +250 <br><font color=yellow>Honor Bonus +11 <br> Immunity to dodge/stun +30% <br> Damage Reduction +30%"
					icon_state="Genji Armor";mouse_drag_pointer="Genji Armor"


				Sanguine_Armor
					LvlReq=50
					oname="Sanguine Armor"
					StatBoosts=list("STR"=350,"MGC"=350,"AGI"=350,"VIT"=350,"LCK"=350,"MaxSTM"= 5000,"MaxREI"=5000,"ShieldBonus"=1,"Hohou"=150,"Hakuda"=150,"Zanjutsu"=150,"Kidou"=150,"ImmunityBonus"=1,"Income"=1000,"HonorSet"=1)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=150
					SalvageItems=list("Bones"=20,"Mithril"=10,"EnchantedOre"=5,"MeteorFragment"=2,"Gems"=5,"Iron"=3)
					desc="The Sanguine Armor offers superior protection and boosts, it is said to have been crafted from the Master of Sanguine Village."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +350 <br> STR +350 <br> AGI +350  <br> VIT +350 <br> LCK +350 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +5000 <br> MaxREI +5000  <br> Hohou +150 <br> Zanjutsu +150 <br> Hakuda +150 <br> Kidou +150 <br><font color=yellow>Honor Bonus +1 <br> Immunity to dodge/stun +1% <br> Damage Reduction +1%"
					icon_state="Genji Armor";mouse_drag_pointer="Genji Armor"
				Midnight_Armor
					LvlReq=500
					Unique=1
					Epic=1
					oname="Midnight Armor"
					StatBoosts=list("STR"=700,"MGC"=700,"AGI"=700,"VIT"=700,"LCK"=700,"MaxSTM"= 12000,"MaxREI"=12000,"ShieldBonus"=1,"Hohou"=200,"Hakuda"=200,"Zanjutsu"=200,"Kidou"=200,"ImmunityBonus"=1,"Income"=2000,"HonorSet"=2)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=400
					SalvageItems=list("Leather"=20,"Bones"=5,"Thread"=15,"EnchantedOre"=5,"MeteorFragment"=5,"Gems"=10,"Iron"=4,"DivineOre"=1)
					desc="The Midnight Armor - it looks like any other piece of armor, yet it appears to pulse with a dark aura of power."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +700 <br> STR +700 <br> AGI +700  <br> VIT +700 <br> LCK +700 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +12000 <br> MaxREI +12000  <br> Hohou +200 <br> Zanjutsu +200 <br> Hakuda +200 <br> Kidou +200 <br><font color=yellow>Honor Bonus +2 <br> Immunity to dodge/stun +1% <br> Damage Reduction +30%<br><br><font color=red>Requires level 500<br><br><font color=green>SET BONUS (chest)<br>+10% chance to instantly KO target.<br><br><i><font color=orange>Set bonus activated once all pieces of the set are equipped also + 100% exp boost and 20% honor boost gained.</font>"
					icon_state="Oblivions Darkest";mouse_drag_pointer="Oblivions Darkest"



		Hand
			Slot="Hand"
			Weapons
				icon='Weapons.dmi'
				Sword
					nosalvage=1
					noenchant=1
					StatBoosts=list("STR"=1)
					GoldValue=0;SilvValue=1;CoprValue=50
					desc="A basic sword. > Increases STR by 1"
					icon_state="Sword";mouse_drag_pointer="Sword"
				Rapier
					nosalvage=1
					noenchant=1
					StatBoosts=list("STR"=2)
					GoldValue=0;SilvValue=3;CoprValue=0
					desc="A sharp sword, designed for stabbing. > Increases STR by 2"
					icon_state="Rapier";mouse_drag_pointer="Rapier"
				Golden_Blade
					icon_state="Golden Blade";mouse_drag_pointer="Golden Blade"
				Save_the_Queen
					icon_state="Save the Queen";mouse_drag_pointer="Save the Queen"
				Falchion
					icon_state="Falchion";mouse_drag_pointer="Falchion"
				Schimitar
					icon_state="Schimitar";mouse_drag_pointer="Schimitar"
				Cross_Sword
					noenchant=1
					nosalvage=1
					StatBoosts=list("STR"=10, "MGC" = 10, "AGI"=10,"MaxSTM"= 100,"MaxREI"=100)
					GoldValue=35;SilvValue=3;CoprValue=0
					desc="A simple sword with some minor boosts."
					desc2="<center><font color=red><i>STATS</i></font></center><br>STR +10 <br> MGC +10 <br> AGI +10  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +100 <br> MaxREI +100<br><font color=yellow>Can not be Refined. "
					icon_state="Cross Sword";mouse_drag_pointer="Cross_Sword"
				Darkness_Bane
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=40,"STR"=40,"AGI"=30,"VIT"=30,"MaxSTM"= 300,"MaxREI"=300)
					GoldValue=50;SilvValue=3;CoprValue=0
					desc="A useful weapon, if you're afraid of the Dark!"
					desc2="<center><font color=red><i>STATS</i></font></center><br>STR +40 <br> MGC +40 <br> AGI +30  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +300 <br> MaxREI +300<br><font color=yellow>Can not be Refined. "
					icon_state="Brightest Night";mouse_drag_pointer="Brightest Night"
				Hollows_Tongue
					noenchant=1
					oname="Hollows Tongue"
					StatBoosts=list("MGC"=150,"AGI"=100,"VIT"=90,"MaxSTM"= 500,"MaxREI"=1200,"Kidou"=50)
					SalvageItems=list("Bones"=1,"Iron"=1)
					GoldValue=50000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A weird whip like weapon crafted from the living tongue of a beast Hollow."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +150 <br> AGI +100 <br> VIT +90 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +1300 <br> Kidou +50<br><font color=yellow>Can not be Refined. "
					icon_state="Serpents Tongue";mouse_drag_pointer="Serpents Tongue"
				The_BoneCrusher
					noenchant=1
					StatBoosts=list("STR"=150,"AGI"=100,"VIT"=90,"MaxSTM"= 1200,"MaxREI"=500,"Zanjutsu"=50)
					GoldValue=50000;SilvValue=0;CoprValue=0;BadgesValue=0
					SalvageItems=list("Bones"=2,"Iron"=1)
					desc="As the name implies, this weapon is capable of inflicting severe damage."
					desc2="<center><font color=red><i>STATS</i></font></center><br>STR +150 <br> AGI +100 <br> VIT +90 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1200 <br> MaxREI +500 <br> Zanjutsu +50 <br><font color=yellow>Can not be Refined."
					icon_state="Emperors Mallet";mouse_drag_pointer="Emperors Mallet"
				The_Annihilator
					LvlReq=100
					oname="The Annihilator"
					StatBoosts=list("STR"=80,"AGI"=60,"VIT"=60,"MaxSTM"= 500,"MaxREI"=250,"Zanjutsu"=15, "Hohou"=15)
					SalvageItems=list("Bones"=2,"Mithril"=1,"Iron"=2)
					GoldValue=800000;SilvValue=0;CoprValue=0;BadgesValue=0
					desc="A decent weapon for a melee. Crafted from mithril ore, very durable.(LVL 100)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>STR +80 <br> AGI +60 <br> VIT +60 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +250 <br> Zanjutsu +15 <br> Hohou +15 <br><br><font color=red>Requires level 100"
					icon_state="Excalibur";mouse_drag_pointer="Excalibur"
				Charon
					LvlReq=100
					oname="Charon"
					StatBoosts=list("MGC"=80,"AGI"=60,"VIT"=60,"MaxSTM"= 250,"MaxREI"=500,"Kidou"=20,"Hohou"= 10)
					GoldValue=800000;SilvValue=0;CoprValue=0;BadgesValue=0
					SalvageItems=list("Bones"=2,"Gems"=1,"Iron"=2)
					desc="A decent weapon for a Rei users. Made from some sort of dark material.(LVL 200)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +80 <br> AGI +60 <br> VIT +60 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +250 <br> MaxREI +500  <br> Hohou +10  Kidou +20 <br><br><font color=red>Requires level 100"
					icon_state="Dark Scepter";mouse_drag_pointer="Dark Scepter"

				Brightest_Night
					icon_state="Brightest Night";mouse_drag_pointer="Brightest Night"
				Excalibur
					icon_state="Excalibur";mouse_drag_pointer="Excalibur"
				Fairy_Club
					icon_state="Fairy Club";mouse_drag_pointer="Fairy Club"
				Dirk_of_Despair
					icon_state="Dirk of Despair";mouse_drag_pointer="Dirk of Despair"
				Black_Hearted_Dagger
					icon_state="Black Hearted Dagger";mouse_drag_pointer="Black Hearted Dagger"
				Glove_of_Despair
					icon_state="Glove of Despair";mouse_drag_pointer="Glove of Despair"
				Padded_Claws
					icon_state="Padded Claws";mouse_drag_pointer="Padded Claws"
				Golden_Knuckles
					icon_state="Golden Knuckles";mouse_drag_pointer="Golden Knuckles"
				Diamond_Knuckles
					icon_state="Diamond Knuckles";mouse_drag_pointer="Diamond Knuckles"
				Dark_Scepter
					icon_state="Dark Scepter";mouse_drag_pointer="Dark Scepter"
				Iron_Thorn_Whip
					icon_state="Iron Thorn Whip";mouse_drag_pointer="Iron Thorn Whip"
				Chain_Whip
					icon_state="Chain Whip";mouse_drag_pointer="Chain Whip"
				Silver_Tipped_Whip
					icon_state="Silver Tipped Whip";mouse_drag_pointer="Silver Tipped Whip"
				Whip_Tail
					icon_state="Whip Tail";mouse_drag_pointer="Whip Tail"
				Metalic_Whip
					icon_state="Metalic Whip";mouse_drag_pointer="Metalic Whip"
				Leviathans_Tail
					icon_state="Leviathans Tail";mouse_drag_pointer="Leviathans Tail"
				Serpents_Tongue
					icon_state="Serpents Tongue";mouse_drag_pointer="Serpents Tongue"
				Boomerang
					icon_state="Boomerang";mouse_drag_pointer="Boomerang"
				Seeker
					icon_state="Seeker";mouse_drag_pointer="Seeker"
				Mystic_Boomerang
					icon_state="Mystic Boomerang";mouse_drag_pointer="Mystic Boomerang"
				White_Whale
					icon_state="White Whale";mouse_drag_pointer="White Whale"
				Wooden_Boomerang
					icon_state="Wooden Boomerang";mouse_drag_pointer="Wooden Boomerang"
				Ax
					icon_state="Ax";mouse_drag_pointer="Ax"
				Ice_Ax
					icon_state="Ice Ax";mouse_drag_pointer="Ice Ax"
				Ax_of_Despair
					icon_state="Ax of Despair";mouse_drag_pointer="Ax of Despair"
				Axe
					icon_state="Axe";mouse_drag_pointer="Axe"
				Silver_Axe
					icon_state="Silver Axe";mouse_drag_pointer="Silver Axe"
				Club
					icon_state="Club";mouse_drag_pointer="Club"
				Spiked_Club
					icon_state="Spiked Club";mouse_drag_pointer="Spiked Club"
				Ice_Club
					icon_state="Ice Club";mouse_drag_pointer="Ice Club"
				Shuriken
					icon_state="Shuriken";mouse_drag_pointer="Shuriken"
				Emperors_Mallet
					icon_state="Emperors Mallet";mouse_drag_pointer="Emperors Mallet"
				Wand_of_Despair
					icon_state="Wand of Despair";mouse_drag_pointer="Wand of Despair"
				Cane
					StatBoosts=list("MGC"=10)
					noenchant=1
					nosalvage=1
					GoldValue=0;SilvValue=2;CoprValue=0
					desc="A basic cane. > Increases MGC by 10"
					desc2="<center><font color=red><i>STATS</i></font></center><br> MGC +10"
					icon_state="Cane";mouse_drag_pointer="Cane"
				Metal_Cane
					noenchant=1
					nosalvage=1
					StatBoosts=list("MGC"=30)
					GoldValue=0;SilvValue=3;CoprValue=0
					desc="A shiney metal cane. > Increases MGC by 30"
					desc2="<center><font color=red><i>STATS</i></font></center><br> MGC +30"
					icon_state="Metal Cane";mouse_drag_pointer="Metal Cane"
				Hunters_Spear
					icon_state="Hunters Spear";mouse_drag_pointer="Hunters Spear"
				Harpoon
					icon_state="Harpoon";mouse_drag_pointer="Harpoon"
				The_Deepest_Dawn
					noenchant=1
					StatBoosts=list("STR"=35, "MGC" = 35, "AGI"=35, "Kidou"=10, "Zanjutsu"= 10,"MaxSTM"= 300,"MaxREI"=300)
					GoldValue=130;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=2,"Iron"=2,"Gems"=2)
					desc="An ancient and powerful sword of unknown origin.(LVL 25)"
					desc2="<center><font color=red><i>STATS</i></font></center><br> STR +35 <br> MGC +35 <br> AGI +35  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +300 <br> MaxREI +300 <br> Kidou +10 <br> Zanjutsu +10<br><br><font color=red>Requires level 25"
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"
					LvlReq=25
				The_Flaming_Nemesis
					noenchant=1
					StatBoosts=list("STR"=100, "MGC" = 10, "AGI"=100, "MaxSTM"= 1500,"MaxREI"=500,"Zanjutsu"=50)
					GoldValue=130;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=2,"Iron"=2,"MeteorFragment"=1)
					desc="An ancient and powerful sword of unknown origin. > Greatly increases your power.(LVL 50)"
					desc2="<center><font color=red><i>STATS</i></font></center><br> STR +100 <br> MGC +10 <br> AGI +100  <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1500 <br> MaxREI +500 <br> Zanjutsu +50 <br><br><font color=red>Requires level 50"
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"
					LvlReq=50

				Nemesis_Stave
					noenchant=1
					StatBoosts=list("VIT"=100, "MGC" = 100, "AGI"=50, "MaxSTM"= 500,"MaxREI"=1500, "Kidou"=50)
					GoldValue=130;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=2,"Iron"=2,"Gems"=2)
					desc="An ancient and powerful staff of unknown origin. > Greatly increases your power.(LVL 50)"
					desc2="<center><font color=red><i>STATS</i></font></center><br> MGC +100 <br> VIT +100 <br> AGI +50 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +1500 <br> Kidou +50 <br><br><font color=red>Requires level 50"
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"
					LvlReq=50

				The_Devourer_Of_Souls
					oname="The Devourer of Souls"
					StatBoosts=list("Hohou"=10, "Zanjutsu" = 10, "Kidou"=10,"Hakuda"=10, "MaxSTM"= 500,"MaxREI"=500,"STR"=50,"MGC"=50,"AGI"=50,"LCK"=20,"MGCDEF"=30,"Income"=250)
					GoldValue=10000;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=2,"Iron"=2,"Gems"=2,"MeteorFragment"=2,"EnchantedOre"=1)
					desc="A very powerful weapon with mysterious properties. > Can be upgraded."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +50 <br> STR +50 <br> AGI +50 <br> LCK +20 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +500 <br> MaxREI +500  <br> Hohou +10 <br> Zanjutsu +10 <br> Hakuda +10 <br> Kidou +10 <br> MGCDEF +30 <br> Income +250<br><br><font color=red>Requires level 100"
					icon_state="Golden Blade";mouse_drag_pointer="Golden Blade"
					LvlReq=100

				Zeus_Sword
					noenchant=1
					nosalvage=1
					StatBoosts=list("Hohou"=100, "Zanjutsu" = 150,"Hakuda"=150,"STR"=500,"AGI"=500,"Income"=1000,"invisibility"=1,"see_invisible"=1)
					GoldValue=100000;SilvValue=3;CoprValue=0
					desc="A rare and unique weapon, customized by the Gods themselves.. "
					desc2="Can not be identified<br> <font color=yellow>Can not be refined."
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"

				Choushou
					noenchant=1
					nosalvage=1
					StatBoosts=list("Hohou"=50, "Kidou" = 150,"Hakuda"=250,"STR"=100,"AGI"=300,"VIT"=100,"MGC"=300,"LCK"=200,"MaxSTM"= 3500,"MaxREI"=3500)
					GoldValue=100000;SilvValue=3;CoprValue=0
					desc="A rare and unique weapon, customized by the Gods themselves.. > Immensely increases your power - Unique"
					desc2="Can not be identified.<br> <font color=yellow>Can not be refined."
					icon_state="Deepest Dawn";mouse_drag_pointer="Deepest Dawn"


				Wrath_of_The_Hollow_King
					oname="Wrath of the Hollow King"
					StatBoosts=list("Hohou"=30, "Zanjutsu" = 30, "Kidou"=30,"Hakuda"=30, "MaxSTM"= 1000,"MaxREI"=1000,"STR"=100,"MGC"=100,"AGI"=100,"LCK"=50,"MGCDEF"=50,"Income"=600,"HonorSet"=1)
					GoldValue=200000;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=15,"Iron"=12,"Gems"=12,"MeteorFragment"=8,"EnchantedOre"=5,"Mithril"=2)
					desc="The second upgrade of the Devourer of souls. > Can be upgraded again.(LVL 100)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +100 <br> STR +100 <br> AGI +100 <br> LCK +50 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +1000 <br> MaxREI +1000  <br> Hohou +30 <br> Zanjutsu +30 <br> Hakuda +30 <br> Kidou +30 <br> MGCDEF +50 <br> Income +600<br><font color=yellow> Honor Bonus +1 <br><br><font color=red>Requires level 100"
					icon_state="Golden Blade";mouse_drag_pointer="Golden Blade"
					LvlReq=100
					Unique=1

				Martyr_of_The_Wretched_God
					oname="Martyr of The Wretched God"
					StatBoosts=list("Hohou"=60, "Zanjutsu" = 60, "Kidou"=60,"Hakuda"=60, "MaxSTM"= 2000,"MaxREI"=2000,"STR"=200,"MGC"=200,"AGI"=200,"LCK"=100,"MGCDEF"=100,"Income"=1000,"HonorSet"=1)
					GoldValue=200000;SilvValue=3;CoprValue=0
					SalvageItems=list("Bones"=30,"Iron"=30,"Gems"=20,"MeteorFragment"=12,"EnchantedOre"=8,"Mithril"=2,"DivineOre"=2)
					desc="The final upgrade of the Devourer of souls. > Immensely increases your power and honor - VERY rare.(LVL 350)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +200 <br> STR +200 <br> AGI +200 <br> LCK +100 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +2000 <br> MaxREI +2000  <br> Hohou +60 <br> Zanjutsu +60 <br> Hakuda +60 <br> Kidou +60 <br> MGCDEF +100 <br> Income +1000<br><font color=yellow> Honor Bonus +1 <br><br><font color=red>Requires level 350"
					icon_state="Golden Blade";mouse_drag_pointer="Golden Blade"
					LvlReq=350
					Unique=1

				Festive_Weapon
					noenchant=1
					nosalvage=1
					StatBoosts=list("Hohou"=220, "Zanjutsu" = 220, "Kidou"=220,"Hakuda"=220, "MaxSTM"= 13000,"MaxREI"=13000,"STR"=1000,"MGC"=1000,"AGI"=1000,"VIT"=1000,"LCK"=600,"MGCDEF"=600,"Income"=4000,"HonorSet"=2,"CritBonus"=10)
					GoldValue=1;SilvValue=3;CoprValue=0;BadgesValue=15000
					desc="A weapon only obtainable during Holiday seasons."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +1000 <br> STR +1000 <br> AGI +1000  <br> VIT +1000 <br> LCK +600 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +13000 <br> MaxREI +13000  <br> Hohou +220 <br> Zanjutsu +220 <br> Hakuda +220 <br> Kidou +220 <br> Income +4000 <br> MGCDEF +600 <br><font color=yellow>Honor Bonus +2 <br> Critical Bonus +10%<br> <font color=yellow>Can not be refined."
					icon_state="Black Hearted Dagger";mouse_drag_pointer="Black Hearted Dagger"
					LvlReq=1

				Sanguine_Slasher
					oname="Sanguine Slasher"
					StatBoosts=list("Hohou"=150, "Zanjutsu" = 150, "Kidou"=150,"Hakuda"=150, "MaxSTM"= 4000,"MaxREI"=4000,"STR"=400,"MGC"=400,"AGI"=400,"VIT"=400,"LCK"=100,"MGCDEF"=100,"Income"=2000,"HonorSet"=2,"CritBonus"=1)
					GoldValue=0;SilvValue=3;CoprValue=0;BadgesValue=200
					desc="The Sanguine Slasher offers superior damage boosts, it is said to have been crafted from the Master of Sanguine Village."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +1000 <br> STR +1000 <br> AGI +1000  <br> VIT +1000 <br> LCK +600 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +13000 <br> MaxREI +13000  <br> Hohou +220 <br> Zanjutsu +220 <br> Hakuda +220 <br> Kidou +220 <br> Income +4000 <br> MGCDEF +600 <br><font color=yellow>Honor Bonus +2 <br> Critical Bonus +10%<br><br><font color=red>Requires level 350"
					icon_state="Black Hearted Dagger";mouse_drag_pointer="Black Hearted Dagger"
					LvlReq=50

				The_Decimator
					oname="The Decimator"
					StatBoosts=list("Hohou"=300, "Zanjutsu" = 300, "Kidou"=300,"Hakuda"=300, "MaxSTM"= 10000,"MaxREI"=10000,"STR"=900,"MGC"=900,"AGI"=600,"VIT"=600,"LCK"=300,"MGCDEF"=900,"Income"=3000,"HonorSet"=2,"CritBonus"=2)
					GoldValue=0;SilvValue=3;CoprValue=0;BadgesValue=500
					SalvageItems=list("Bones"=50,"Iron"=50,"Gems"=50,"MeteorFragment"=50,"EnchantedOre"=50,"Mithril"=50,"DivineOre"=50)
					desc="This item will be changed in V2, the weapon has levels which will increase its power via exp rather than start out with stats like these."
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +900 <br> STR +900 <br> AGI +600  <br> VIT +600 <br> LCK +300 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +10000 <br> MaxREI +10000  <br> Hohou +300 <br> Zanjutsu +5300 <br> Hakuda +300 <br> Kidou +300 <br> Income +3000 <br> MGCDEF +900 <br><font color=yellow>Honor Bonus +2 <br> Critical Bonus +2%<br><br><font color=red>Requires level 550"
					icon_state="Emperors Mallet";mouse_drag_pointer="Emperors Mallet"
					LvlReq=550
					Epic=1

				The_Legendary_Ark
					LvlReq=500
					noenchant=1
					nosalvage=1
					Unique=1
					Epic=1
					StatBoosts=list("STR"=10000,"MGC"=10000,"AGI"=10000,"VIT"=10000,"LCK"=10000,"MaxSTM"= 50000,"MaxREI"=50000,"Hohou"=1000,"Hakuda"=1000,"Zanjutsu"=1000,"Kidou"=1000,"Income"=10000, "HonorSet"=20)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=10000
					desc="The most powerful item that exists. It has a few secret abilities.(LVL 500)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +10000 <br> STR +10000 <br> AGI +10000  <br> VIT +10000 <br> LCK +10000 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +50000 <br> MaxREI +50000  <br> Hohou +1000 <br> Zanjutsu +1000 <br> Hakuda +1000 <br> Kidou +1000 <br> Honor Bonus +20<br><br><font color=red>Required level 500"
					icon_state="Mystic Boomerang";mouse_drag_pointer="Mystic Boomerang"

				Abyssal_Shard
					LvlReq=200
					noenchant=1
					nosalvage=1
					Unique=1
					StatBoosts=list("STR"=3000,"MGC"=3000,"AGI"=3000,"VIT"=3000,"LCK"=3000,"MaxSTM"= 12000,"MaxREI"=12000,"Hohou"=500,"Hakuda"=500,"Zanjutsu"=500,"Kidou"=500,"Income"=3000, "HonorSet"=10)
					GoldValue=0;SilvValue=0;CoprValue=0;BadgesValue=1500
					desc="A custom item created for VIP 4 members.(LVL 200)"
					desc2="<center><font color=red><i>STATS</i></font></center><br>MGC +3000 <br> STR +3000 <br> AGI +3000  <br> VIT +3000 <br> LCK +3000 <br><br><center><font color=red><i>EFFECTS</i></font></center><br> MaxSTM +12000 <br> MaxREI +12000  <br> Hohou +500 <br> Zanjutsu +500 <br> Hakuda +500 <br> Kidou +500 <br> Honor Bonus +10<br><br><font color=red>Required level 200"
					icon_state="Abyssal_shard";mouse_drag_pointer="Abyssal_shard"

