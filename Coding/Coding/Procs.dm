/*atom/var/SavedIcon
atom/proc/ColorFlick(var/icon/I2F)
	src.icon=I2F
	spawn(3)	if(src)	src.icon=src.SavedIcon*/

proc/WorldStatusUpdate()
	var/PlayerLimitNote="/[PlayerLimit]"
	if(!PlayerLimit)	PlayerLimitNote=""
	if(!StatusNote)	world.status="(v[GameVersion]) (Players: [PlayerCount][PlayerLimitNote])"
	else	world.status="[StatusNote]]<br>\[(v[GameVersion]) (Players: [PlayerCount][PlayerLimitNote])"

proc/ListCheck(var/Object,var/list/Listo)
	if(Object in Listo)	return 1
	else	return 0

mob/proc/PixelBounce()
	var/PX=rand(0,4);var/PY=rand(0,4)
	src.pixel_x+=PX;src.pixel_y+=PY
	spawn(2)	{src.pixel_x-=PX;src.pixel_y-=PY}

mob/proc/KnockBack(var/mob/M,var/SrcLoc)
	if(!src.CanPVP(M))	return
	if(MyGetDist(src,M)>src.SightRange-1)	return
	M.PixelBounce()
	var/turf/T=get_step(M,get_dir(SrcLoc,M))
	if(T.Enter(M))
		M.loc=T;T.Entered(M)

mob/proc/KnockBackFollow(var/mob/M)
	if(!src.CanPVP(M))	return
	if(!ListCheck(M,oview(src.SightRange,src)))	{src.TargetMob(null);return}
	var/turf/T=get_step(M,get_dir(M,src))
	if(T.Enter(src))
		src.loc=T;T.Entered(src)

mob/proc/StunProc(var/Time=5,var/Type="Stun",var/mob/StunnedBy)
	if(src.Stunned)	return
	if(src.Class=="Bount")	{DamageShow(src,"Immune");return}
	if(rand(1,100)<=src.ImmunityBonus)	{DamageShow(src,"Immune");return}
	if(ismob(StunnedBy))
		if(!StunnedBy.CanPVP(src))	return
		if(!ListCheck(src,oview(StunnedBy.SightRange,StunnedBy)))	{StunnedBy.TargetMob(null);return}
	src.Stunned=1
	if(src.SkillBeingCharged)	call(src,"[src.SkillBeingCharged] Release")()
	if(Type=="Stun"||Type=="White Prostration")
		ShowEffect(src,'Effects.dmi',Type,"Above",Time*10,1,ExtraTag="Stun")
	else	ShowEffect(src,'Effects.dmi',Type,"",Time*10,1,ExtraTag="Stun")
	spawn(Time*10)	if(src)	src.Stunned=0

mob/proc/StunProc2(var/Time=5,var/Type="Stun",var/mob/StunnedBy)
	if(src.Stunned)	return
	if(src.Class=="Bount")	{DamageShow(src,"Immune");return}
	if(ismob(StunnedBy))
		if(!StunnedBy.CanPVP(src))	return
		if(!ListCheck(src,oview(StunnedBy.SightRange,StunnedBy)))	{StunnedBy.TargetMob(null);return}
	src.Stunned=1
	if(src.SkillBeingCharged)	call(src,"[src.SkillBeingCharged] Release")()
	if(Type=="Stun"||Type=="White Prostration")
		ShowEffect(src,'Effects.dmi',Type,"Above",Time*10,1,ExtraTag="Stun")
	else	ShowEffect(src,'Effects.dmi',Type,"",Time*10,1,ExtraTag="Stun")
	spawn(Time*10)	if(src)	src.Stunned=0
mob/proc/SetRespawn(/**/)
	src.RespawnX=src.x
	src.RespawnY=src.y
	src.RespawnZ=src.z
	QuestShow(src,"Respawn Point has been Stored")

proc/MyGetDist(var/atom/A1,var/atom/A2)
	if(!A1 || !A2)	return
	if(A1.z!=A2.z)	return 999999
	return get_dist(A1,A2)

proc/MyFlick(var/IS,var/atom/A)
	if(A && (IS in icon_states(A.icon)))	flick(IS,A)

proc/AscSort(var/list/TextList)
	var/list/SortedList=list()
	while(TextList.len>1)
		var/CurHigh=TextList[1]
		for(var/x in TextList)
			if(sorttext(CurHigh,x)==-1)	CurHigh=x
		SortedList+=CurHigh;TextList-=CurHigh
	SortedList+=TextList
	return SortedList

proc/DesSort(var/list/TextList)
	var/list/SortedList=list()
	while(TextList.len>1)
		var/CurLow=TextList[1]
		for(var/x in TextList)
			if(sorttext(CurLow,x)!=-1)	CurLow=x
		SortedList+=CurLow;TextList-=CurLow
	SortedList+=TextList
	return SortedList

proc/PlayVoice(var/mob/Nodes,var/File,var/HalfSound=1)
	if(ismob(Nodes))
		if(Nodes.VoiceVol>0)	Nodes<<sound(File,volume=round(Nodes.VoiceVol/HalfSound))
	else	for(var/mob/Player/M in Nodes)
		if(M.VoiceVol>0)	M<<sound(File,volume=round(M.VoiceVol/HalfSound))

proc/PlayTimedSound(var/mob/Nodes,var/File,var/PlayTime=10)
	if(ismob(Nodes))
		if(Nodes.EffectVol>0)	Nodes<<sound(File,channel=8)
		spawn(PlayTime)	if(Nodes)	Nodes<<sound(null,channel=8,volume=Nodes.EffectVol)
	else	for(var/mob/Player/M in Nodes)
		if(M.EffectVol>0)	M<<sound(File,channel=8,volume=M.EffectVol)
		spawn(PlayTime)	if(M)	M<<sound(null,channel=8)

proc/PlaySoundEffect(var/mob/Nodes,var/File,var/HalfSound=1)
	if(ismob(Nodes))
		if(Nodes.EffectVol>0)	Nodes<<sound(File,volume=round(Nodes.EffectVol/HalfSound))
	else	for(var/mob/Player/M in Nodes)
		if(M.EffectVol>0)	M<<sound(File,volume=round(M.EffectVol/HalfSound))

proc/PlayMenuSound(var/mob/Nodes,var/File)
	if(ismob(Nodes))
		if(Nodes.MenuVol>0)	Nodes<<sound(File,volume=Nodes.MenuVol)
	else	for(var/mob/Player/M in Nodes)
		if(M.MenuVol>0)	M<<sound(File,volume=M.MenuVol)

proc/PlayMusic(var/mob/Nodes,var/File)
	if(ismob(Nodes))
		if(Nodes.MusicVol>0)	{Nodes<<sound(null);Nodes<<sound(File,Nodes.LoopMusic,0,7,Nodes.MusicVol)}
	else	for(var/mob/Player/M in Nodes)
		if(M.MusicVol>0)	{M<<sound(null);M<<sound(File,M.LoopMusic,0,7,M.MusicVol)}

mob/proc/Restat()
	src.StatPoints=(src.Level-1)*3 + src.boughtstats
	for(var/obj/Items/Equipment/E in src.EquipmentList)
		for(var/Stat in E.StatBoosts)
			src.vars["[Stat]"]-=E.StatBoosts[Stat]
			src.vars["[Stat]"]-=(E.StatBoosts[Stat]*E.enc)/5
	src.Bonus_Removal()
	src.Gotbonus0=0;src.Gotbonus1=0;src.Gotbonus2=0;src.Gotbonus3=0;src.Gotbonus4=0
	src.MaxREI=200;src.MaxSTM=300;src.STR=10;src.VIT=1;src.AGI=1;src.LCK=1;src.MGC=1;src.MGCDEF=1
	for(var/obj/Skills/Universal/Blur/S in src.Skills)	src.AGI+=S.Level*2
	for(var/obj/Skills/Universal/ExoShell/S in src.Skills)	src.MaxSTM+=S.Level*20
	for(var/obj/Skills/Universal/Spirit_Shine/S in src.Skills)	src.MaxREI+=S.Level*10
	for(var/obj/Skills/Universal/Brute/S in src.Skills)	src.STR+=S.Level*2
	for(var/obj/Skills/Universal/Stone_Skin/S in src.Skills)	src.VIT+=S.Level*2
	for(var/obj/Skills/Universal/Mystic_Glow/S in src.Skills)	src.MGC+=S.Level*2
	for(var/obj/Skills/Universal/Lucky_Stars/S in src.Skills)	src.LCK+=S.Level*2
	for(var/obj/Skills/Universal/Mystic_Aura/S in src.Skills)	src.MGCDEF+=S.Level*2
	src.MaxSTM+=(src.Level-1)*10;src.MaxREI+=(src.Level-1)*5
	if(src.Subscriber)
		src.StatPoints+=(src.Level-1)
	for(var/obj/Items/Equipment/E in src.EquipmentList)
		for(var/Stat in E.StatBoosts)
			src.vars["[Stat]"]+=E.StatBoosts[Stat]
			src.vars["[Stat]"]+=(E.StatBoosts[Stat]*E.enc)/5
	src.Bonus_Check()

mob/proc/Retrait()
	src.TraitPoints=src.Level-1
	for(var/obj/Items/Equipment/E in src.EquipmentList)
		for(var/Stat in E.StatBoosts)
			src.vars["[Stat]"]-=E.StatBoosts[Stat]
			src.vars["[Stat]"]-=(E.StatBoosts[Stat]*E.enc)/5
	src.Bonus_Removal()
	src.Exp-=src.Prodigy*100;src.SkillPoints-=src.Training
	src.Gotbonus0=0;src.Gotbonus1=0;src.Gotbonus2=0;src.Gotbonus3=0;src.Gotbonus4=0
	src.Hohou=0;src.Zanjutsu=0;src.Hakuda=0;src.Kidou=0
	src.Training=0;src.Manual=0;src.Prodigy=0;src.Income=0
	for(var/obj/Items/Equipment/E in src.EquipmentList)
		for(var/Stat in E.StatBoosts)
			src.vars["[Stat]"]+=E.StatBoosts[Stat]
			src.vars["[Stat]"]+=(E.StatBoosts[Stat]*E.enc)/5
	src.Bonus_Check()

mob/proc/Respec(/**/)
	for(var/obj/O in src.Spells)	del O;src.Spells=list()
	for(var/obj/O in src.Skills)	del O;src.Skills=list()
	for(var/obj/O in src.Kidous)	del O;src.Kidous=list()
	for(var/obj/O in src.ShikaiSkills)	del O;src.ShikaiSkills=list()
	for(var/obj/O in src.BankaiSkills)	del O;src.BankaiSkills=list()
	for(var/obj/O in src.FinalFormSkills)	del O;src.FinalFormSkills=list()
	for(var/obj/O in src.Vaizard)	del O;src.VaizardSkills=list()
	for(var/datum/StatusEffects/E in src.StatusEffects)	E.RemovalProc(src)
	src.StmRegenBonus=0;src.ReiRegenBonus=0;src.StmRegenCost=10;src.CanShunpo=0
	if(src.Class=="Quincy")
		src.ReiRegenBonus=1;src.CanShunpo=1
		src.Skills+=new/obj/Skills/Quincy/Spirit_Arrow;src.Skills+=new/obj/Skills/Universal/Flash_Step
		if("Sanrei Training" in src.CompletedQuests)	src.Skills+=new/obj/Skills/Quincy/Final_Form
	if(src.Class=="Soul Reaper")
		src.StmRegenBonus=1
		src.ComboList=list("S1","D1","F1","F2","F3")
		src.Skills+=new/obj/Skills/SoulReaper/Basic_Combat;src.Skills+=new/obj/Skills/SoulReaper/Guard
		if("Shikai Training" in src.CompletedQuests)	src.Skills+=new/obj/Skills/SoulReaper/Shikai
		if("Bankai Training" in src.CompletedQuests)	src.Skills+=new/obj/Skills/SoulReaper/Bankai
		if("Vaizard Training" in src.CompletedQuests)	src.Skills+=new/obj/Skills/SoulReaper/Vaizard
	if(src.Class=="Bount")
		src.StmRegenBonus=1
		src.ReiRegenBonus=1
		src.ComboList=list("F1","F2","F3")
		src.Skills+=new/obj/Skills/Bount/Summon_Pet
		src.Skills+=new/obj/Skills/Bount/Dismiss_Pet
		src.Skills+=new/obj/Skills/Bount/Heal_Pet
		src.Skills+=new/obj/Skills/Bount/Pet_Skills
		src.BountPetCheck()
		if("Merge Training" in src.CompletedQuests)	usr.Skills+=new/obj/Skills/Bount/Fuse
	src.Spells+=new/obj/Spells/Teleportation/Teleportation
	src.Spells+=new/obj/Spells/Teleportation/Recall
	src.CurSkill="Selected Skill"
	for(var/obj/HUD/CoolDown/C in src.client.screen)	if(C.screen_loc=="13,18")
		C.SkillRef=null;C.icon_state=""
	src.ArrowType="Spirit Arrow"
	src.HotKeys=list()
	for(var/i=1;i<=9;i++)	src.HotKeys+="Selected Skill"
	//trait resets
	src.Nexp+=src.Prodigy*100
	src.Hohou=0;src.Zanjutsu=0;src.Hakuda=0;src.Kidou=0
	src.Training=0;src.Manual=0;src.Prodigy=0;src.Income=0
	//bonus resets
	src.DodgeBonus=0;src.CritBonus=0;MaxArrowCharges=1
	src.ArrCreateSpd=0;src.DistChargeSpd=0;src.GuardBonus=0;src.CounterBonus=0
	src.DoubleStrikeBonus=0;src.ShieldBonus=0;src.ImmunityBonus=0;src.HonorSet=0
	src.Gotbonus0=0;src.Gotbonus1=0;src.Gotbonus2=0;src.Gotbonus3=0;src.Gotbonus4=0
	//stat resets
	src.SkillPoints=src.Level-1;src.StatPoints=(src.Level-1)*3 + src.boughtstats;src.TraitPoints=src.Level-1
	src.MaxREI=200;src.MaxSTM=300;src.STR=30;src.MGC=30;src.VIT=1;src.AGI=1;src.LCK=1;src.MGCDEF=1
	src.MaxSTM+=(src.Level-1)*10;src.MaxREI+=(src.Level-1)*5
/*	if(src.Level>500)
		src.TraitPoints+= src.Level-499
		src.MaxSTM+=(src.Level-499)*30
		src.MaxREI+=(src.Level-499)*15*/
	if(src.Subscriber)
		src.StatPoints+= src.Level-1
		src.SkillPoints+=src.Level-1
		//src.TraitPoints+=src.Level-1
	for(var/obj/Items/Equipment/E in src.EquipmentList)
		for(var/Stat in E.StatBoosts)
			src.vars["[Stat]"]+=E.StatBoosts[Stat]
			src.vars["[Stat]"]+=(E.StatBoosts[Stat]*E.enc)/5
	src.Bonus_Check()
	src.HUD()

proc/TextInput(var/mob/M,var/Message,var/Title,var/Default)
	if(!M.TextCapture)	return
	M.TextCapture=null
	winset(M,"TextInput","title='[Title]';is-visible=true;pos=100,100")
	winset(M,"TextInput.label","text='[Message]'")
	winset(M,"TextInput.Text","text='[Default]';focus=true")
	while(M)
		if(M.TextCapture)	return	M.TextCapture
		if(winget(M,"TextInput","is-visible")=="false")
			M.TextCapture="...";return
		sleep(1)

mob/proc/CheckPlayer(var/mob/M)
	var/list/chests=Split(src.ChestList,"*")
	var/AllChests=0;for(var/obj/NPC/Random/Chest/C in world)	AllChests+=1
	var/FM="<td><center><b><font color=gray>"
	var/TextList="<html><body bgcolor=black><b><font color=gray>"
	TextList+="<title>[M]'s Profile</title><center>"
	TextList+="<table border=1 bgcolor=black bordercolor=gray width=100%>"
	TextList+="<tr>[FM]- [M] -<br>Level [M.Level] [M.Class]</table>"
	if(M.Zanpakuto)
		TextList+="<table border=1 bgcolor=black bordercolor=gray width=100%>"
		TextList+="<tr>[FM]- Zanpakuto Info -<br>"
		TextList+="Type: [M.Zanpakuto.Element] [M.Zanpakuto.SpiritType]<br>"
		TextList+="Call: [sd.ProcessHTML(M.Zanpakuto.Command)], [sd.ProcessHTML(M.Zanpakuto.name)]!</table>"
	TextList+="<table border=1 bgcolor=black bordercolor=gray width=100%>"
	TextList+="<tr><td colspan=3><b><font color=gray><center>Special Bonuses"
	TextList+="<tr>[FM]Equipment Bonus[FM]Permanent Bonus[FM]Devoured Souls"
	TextList+="<tr>[FM][M.HonorSet][FM][M.HonorBonus][FM][num2text(round(M.Devour),1000000)]</table>"
	if(M.insquad)
		TextList+="<table border=1 bgcolor=black bordercolor=gray width=100%>"
		TextList+="<tr><td colspan=2><b><font color=gray><center>Squad Information"
		TextList+="<tr>[FM]Squad [FM]Personal Squad Level"
		TextList+="<tr>[FM][M.Squad][FM][M.Squadlevel]</table>"
	TextList+="<table border=1 bgcolor=black bordercolor=gray width=100%>"
	TextList+="<tr><td colspan=6><b><font color=gray><center>Battle Stats"
	TextList+="<tr>[FM]NPCs Killed[FM]Deaths by NPC[FM]PVP Kills[FM]Deaths in PVP[FM]Honor[FM]Treasures Found"
	TextList+="<tr>[FM][num2text(round(M.Kills),1000000)][FM][num2text(round(M.Deaths),1000000)][FM][M.PvpKills][FM][M.PvpDeaths][FM][num2text(round(M.Honor),1000000)][FM][max(0,chests.len-1)]/[AllChests]"
	TextList+="</table><br>"
	TextList+="<table bgcolor=black border=1 bordercolor=gray width=100%>"
	var/Phours=round(M.PlayTime/60/60)
	var/Pminutes=round(M.PlayTime/60-(60*Phours))
	TextList+="<tr>[FM]Total Playtime[FM][Phours]h [Pminutes]m"
	TextList+="<tr><td colspan=2><center><font color=gray><b>Playtime Breakdown"
	TextList+="<tr><td><center><font color=gray><b>Level<td><center><font color=gray><b>Reached After"
	TextList+="[M.LevelLog]"
	src<<browse("[TextList]","window=DetailBrowser")

mob/proc/InspectPlayer(var/mob/M)
	var/TextList="<html><body bgcolor=black><b><font color=gray>"
	var/FM="<td><center><b><font color=white>"
	var/FM2="<td><center><b><font color=yellow>"
	TextList+="<title>[M]'s Equipment</title><center>"
	TextList+="<table border=0 bgcolor=black bordercolor=gray width=100%><br>"
	TextList+="<tr>[FM2]WEAPON: [FM][M.Hand]"
	TextList+="<tr>[FM2]ARMOR: [FM][M.Body]"
	TextList+="<tr>[FM2]HELMET: [FM][M.Head]"
	TextList+="<tr>[FM2]FEET: [FM][M.Feet]"
	TextList+="<tr>[FM2]BACK: [FM][M.Back]"
	src<<browse("[TextList]","window=DetailBrowser")



proc/QuestShow(var/mob/M,var/Texto)
	spawn()
		while(M && M.QuestDisplay.len>=6)	sleep(1)
		if(!M)	return
		M.WriteLine(1,1,1,1,"QuestWrite","",1)
		if(Texto)	M.QuestDisplay+="[Texto]"
		var/counter=0
		for(var/T in M.QuestDisplay)
			M.WriteLine(1,4,16,-12*counter,"QuestWrite","[T]",0)
			counter+=1
		if(Texto)	spawn(50)
			if(!M)	return
			if(M.QuestDisplay.len<2)	M.QuestDisplay=list()
			else	M.QuestDisplay=M.QuestDisplay.Copy(2,0)
			QuestShow(M)

mob/proc/EnemyStart(var/Distance,var/atom/Loco)
	for(var/mob/Enemy/M in oview(Distance,Loco))
		//if(M.MultiCore)	M=M.MultiCore
		if(src.invisibility==0)
			if(!M.StartedBy)
				M.TargetMob(src)
				M.StartedBy=src
				src.LevelShiftEnemy(M)
				spawn(rand(0,5))	if(M)	M.EnemyAI()

mob/proc/ForceEnemyStart(var/mob/Enemy/M)
	if(istype(M,/mob/Enemy))
		if(!M.StartedBy)
			M.TargetMob(src);M.StartedBy=src
			src.LevelShiftEnemy(M)
			spawn(rand(0,5))	if(M)	M.EnemyAI()

atom/proc/BackDir(var/dir2Check=src.dir)
	if(dir2Check==1)	return 2
	if(dir2Check==2)	return 1
	if(dir2Check==4)	return 8
	if(dir2Check==8)	return 4
	if(dir2Check==6)	return 9
	if(dir2Check==9)	return 6
	if(dir2Check==5)	return 10
	if(dir2Check==10)	return 5

mob/proc/DeathCheck(var/mob/Killer)
	/*if(src.key=="Millamber")
		src.STM=src.MaxSTM
		Killer.STM=0
		world<<"<b><font color=red>[Killer] <font color=white>dared to attack Kabuto and was instantly obliterated."
		Killer.DeathCheck()
		return*/
	if(src.z==2)	return
	if(src.STM<=0)
		for(var/obj/Items/Potions/Phoenix_Feather/F in src.Inventory)
			if(!src.z==13)
				src.STM=src.MaxSTM;src.StmBar()
				QuestShow(src,"[F] Used");F.Discard(1);return
		src.Stunned=0;src.CanMove=1
		src.TurnMode=0;src.ArrowStr=0;src.ArrowDist=0
		for(var/datum/StatusEffects/S in src.StatusEffects)	S.RemovalProc(src)
		for(var/obj/Supplemental/Effect/E in src.loc)	if(E.MyExtraTag=="Stun")	del E
		for(var/atom/X in src.DeathCache)	{src.DeathCache-=X;del X}
		if(istype(Killer,/mob/Enemy))	Killer:TauntedBy=null
		if(src.ArenaRound)
			UpdateArenaScores(src.name,src.ArenaRound-1)
			src.ArenaBonus=0;src.ArenaRound=0
		if(src.client)	//basic death messages and player reset
			src.Revert()
			if(WorldPVP==0)
				src.PVP=0;src.overlays-=PVPicon
			if(src.PVPingAgainst)
				src.PVPingAgainst.PVPingAgainst=null
				src.PVPingAgainst=null
				del src.PVPFlag
			if(src.SkillBeingCharged)	call(src,"[src.SkillBeingCharged] Release")()
			src.loc=locate(src.RespawnX,src.RespawnY,src.RespawnZ)
			for(var/mob/Pets/P in src.Pets)	P.loc=null
		/*	if(src.waraa)
				src.waraa =0
				wara -= 1
				War_Checkb()
			if(src.warbb)
				src.warbb = 0
				warb -= 1
				War_Check()*/
			if(src.Arena)
				src.Arena.User=null;src.Arena=null
			if(src.tourny)
				src.tourny = 0
				Entries.Remove(src)
				src.verbs -=typesof(/mob/tournyverb/verb)
				src.loc=locate(src.oldlx,src.oldly,src.oldlz)
				Killer.loc=locate(16,197,13)
				Killer.PVP=0
				world<<"<b><font color=green>Tournament Info : [Killer]<font color=white><b> has annihilated [src] in the Tournament! [src] didn't stand a chance.."
				Tournament_AI()
			if(src.client && Killer.client)	//pvp honor
				var/Honor2Give=0
				if(abs(src.Level-Killer.Level)<=10)	Honor2Give=5
				else	if(Killer.Level<src.Level)	Honor2Give=8 //for killing a higher level
				else	Honor2Give=-1
				Killer.Honor+=Honor2Give;src.PvpDeaths+=1;Killer.PvpKills+=1
				Killer<<"<b><font size=1><font color=red>You have defeated [src] (Worth: [Honor2Give] Honor)"
				src<<"<b><font size=1><font color=red>You have been defeated by [Killer]"
				var/P = rand(1,5)
				if(P ==1)
					world<<"<b><font size=1><font color=#663399>[src] has been crushed by the might of [Killer]."
				if(P ==2)
					world<<"<b><font size=1><font color=#663399>[src] has been disintegrated by [Killer]."
				if(P ==3)
					world<<"<b><font size=1><font color=#663399>[src] was found wanting and perished at the hands of [Killer]."
				if(P ==4)
					world<<"<b><font size=1><font color=#663399>A loud cracking sound is heard as [src]'s skull was crushed by [Killer]."
				if(P ==5)
					world<<"<b><font size=1><font color=#663399>Your hair stands up at the sound of [src]'s screams of agony as [Killer] slowly hacks [src] into pieces. "
			else	{src.Deaths+=1;src<<"<b><font color=red>You have been killed by [Killer]"}
		else	//Respawning Enemies
			ShowEffect(src.loc,'Effects.dmi',"HollowHide")
			if(istype(src,/mob/Pets))	src.loc=null
			else
				src.loc=locate(rand(81,99),rand(81,99),2)
				spawn(rand(300,600))//300,600
					if(!src.RespawnZ)
						for(var/atom/x in src.Cache)	del x
						del src;return
					if(istype(src,/mob/Enemy))	src:LevelShift(initial(src.Level))
					src.loc=locate(src.RespawnX+rand(-1,1),src.RespawnY+rand(-1,1),src.RespawnZ)
					ShowEffect(src.loc,'Effects.dmi',"EnergyBall")
		if(!Killer.client && Killer.Owner && Killer.Owner.client)	Killer=Killer.Owner
		if(Killer.client && !src.client && !src.Owner)	//Exp from NPCs
			var/mob/MaxDamager=src.FindMaxDamager()
			if(MaxDamager)
				if(MaxDamager.client)	Killer=MaxDamager
				else	if(MaxDamager.Owner)	Killer=MaxDamager.Owner
			if(!Killer.client && Killer.Owner)	Killer=Killer.Owner
			if(Killer.ezcheck2==1)
				return
			Killer.EnemyDropCheck(src)
			//Killer.EnemyRareCheck(src)
			Killer.QuestKillCheck(src)
			Killer.Kills+=1
			var/R = rand(1,6200000)
			if(R == 999999)
				Killer.bank.DepositItem2(new /obj/Items/Potions/Glowing_Red_Mask)
				world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a strange mask piece. </font>"
				Killer<<"<b>The rare item has been stored in your Bank"
				text2file("[time2text(world.realtime)]:[Killer] found maskpiece<br>","gmlog.html")
			var/E = rand(1,2200000)
			if(Killer.VIP==5)
				if(E == 35000 || E== 150000 || E==256000 || E==343000)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Hand/Weapons/The_Devourer_Of_Souls)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the legendary sword, Devourer of Souls! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Devourer<br>","gmlog.html")
				if(E == 195000 || E==169456 || E==3 || E==150)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Head/Cowl_of_Infinity)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the epic helm, <b><font color=#B93B8F size=3>Cowl of Infinity</font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Cowlbr>","gmlog.html")
				if(E==765234 || E==39000|| E== 2000000 || E== 999999)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Back/The_Cloak_Of_Zeus)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the legendary Cloak of Zeus! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Cloak of Zeus<br>","gmlog.html")
				if(E==25000 || E == 555 || E==555555 || E==10)
					var/Q = rand(5,20)
					Killer.Badges +=Q
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found [Q] Honor Badges! </font>"
					Killer<<"<b>You have found [Q] Honor Badges."
					text2file("[time2text(world.realtime)]:[Killer] found [Q] Badges<br>","gmlog.html")
			else
				if(E == 35000 || E== 150000)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Hand/Weapons/The_Devourer_Of_Souls)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the legendary sword, Devourer of Souls! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Devourer<br>","gmlog.html")
				if(E == 195000)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Head/Cowl_of_Infinity)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the epic helm, <b><font color=#B93B8F size=3>Cowl of Infinity</font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Cowlbr>","gmlog.html")
				if(E==765234 || E==39000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Back/The_Cloak_Of_Zeus)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the legendary Cloak of Zeus! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Cloak of Zeus<br>","gmlog.html")
				if(E==25000 || E == 555)
					var/Q = rand(5,20)
					Killer.Badges +=Q
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found [Q] Honor Badges! </font>"
					Killer<<"<b>You have found [Q] Honor Badges."
					text2file("[time2text(world.realtime)]:[Killer] found [Q] Badges<br>","gmlog.html")
			var/L = rand(1,500000)
			if(Killer.VIP==5)
				if(L == 50000 || L == 22 || L==249125 || L==55000)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Body/Armor/Celestial_Plate)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the Celestial Plate! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Celestial Plate<br>","gmlog.html")
				if(L==125000 || L == 5 ||L==67000 || L==500000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Mystic/Celestial_Cloth)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the Celestial Cloth! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Celestial Cloth<br>","gmlog.html")
				if(L==25000 || L==1 || L==225000)
					var/S = rand(1,5)
					Killer.Badges +=S
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found [S] Honor Badge(s)! </font>"
					Killer<<"<b>You have found [S] Honor Badge."
					text2file("[time2text(world.realtime)]:[Killer] found [S] Badges<br>","gmlog.html")
			else
				if(L == 50000 || L == 22)
					Killer.bank.DepositItem2(new /obj/Items/Equipment/Body/Armor/Celestial_Plate)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the Celestial Plate! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Celestial Plate<br>","gmlog.html")
				if(L==125000 || L == 5)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Mystic/Celestial_Cloth)
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found the Celestial Cloth! </font>"
					Killer<<"<b>The rare item has been stored in your Bank"
					text2file("[time2text(world.realtime)]:[Killer] found Celestial Cloth<br>","gmlog.html")
				if(L==25000)
					var/S = rand(1,5)
					Killer.Badges +=S
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found [S] Honor Badge(s)! </font>"
					Killer<<"<b>You have found [S] Honor Badge."
					text2file("[time2text(world.realtime)]:[Killer] found [S] Badges<br>","gmlog.html")
			var/Y = rand(1,300000)
			if(Killer.VIP==5)
				if(Y == 35000 || Y== 120000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Head/Charred_Helmet)
					Killer<<"<b>You have found a Charred Helm. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Charred Helmet<br>","weaponlog.html")
				if(Y == 79 || Y==100)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Reward_scroll)
					Killer<<"<b>You have found a Reward Scroll. The item has been placed in your bank."
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a Reward Scroll! </font>"
					text2file("[time2text(world.realtime)]:[Killer] found Charred Helmet<br>","weaponlog.html")
				if(Y == 105000 || Y==300000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/Nemesis_Stave)
					Killer<<"<b>You have found a Nemesis Stave. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Nemesis Stave<br>","weaponlog.html")
				if(Y == 150000 || Y==1)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/The_Flaming_Nemesis)
					Killer<<"<b>You have found a Flaming Nemesis. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Flaming Nemesis<br>","weaponlog.html")
				if(Y == 220000 || Y==123)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/The_Deepest_Dawn)
					Killer<<"<b>You have found a DeepestDawn. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Deep dawn<br>","weaponlog.html")
				if(Y == 150 || Y==200000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Mystic/The_Robe_of_Power)
					Killer<<"<b>You have found a Robe of Power. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Robe of Power<br>","weaponlog.html")
				if(Y == 55000 || Y==50000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Armor/The_Vermillion)
					Killer<<"<b>You have found a Vermillion. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Vermillion<br>","weaponlog.html")
			else
				if(Y == 35000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Head/Charred_Helmet)
					Killer<<"<b>You have found a Charred Helm. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Charred Helmet<br>","weaponlog.html")
				if(Y == 79)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Reward_scroll)
					Killer<<"<b>You have found a Reward Scroll. The item has been placed in your bank."
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a Reward Scroll! </font>"
					text2file("[time2text(world.realtime)]:[Killer] found Charred Helmet<br>","weaponlog.html")
				if(Y == 765)
					Killer.DivineOre+=1
					Killer<<"<b>You have found a Divine Ore."
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a Divine Ore! </font>"
					text2file("[time2text(world.realtime)]:[Killer] found Divine Ore<br>","weaponlog.html")
				if(Y == 12345)
					Killer.DivineOre+=1
					Killer<<"<b>You have found a Divine Ore."
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a Divine Ore! </font>"
					text2file("[time2text(world.realtime)]:[Killer] found Divine Ore<br>","weaponlog.html")
				if(Y == 299123)
					Killer.DivineOre+=1
					Killer<<"<b>You have found a Divine Ore."
					world<<"<b><font color=red size=3>World Drop : <font color=yellow>[Killer] <font color=white> has found a Divine Ore! </font>"
					text2file("[time2text(world.realtime)]:[Killer] found Divine Ore<br>","weaponlog.html")
				if(Y == 105000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/Nemesis_Stave)
					Killer<<"<b>You have found a Nemesis Stave. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Nemesis Stave<br>","weaponlog.html")
				if(Y == 150000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/The_Flaming_Nemesis)
					Killer<<"<b>You have found a Flaming Nemesis. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Flaming Nemesis<br>","weaponlog.html")
				if(Y == 220000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Hand/Weapons/The_Deepest_Dawn)
					Killer<<"<b>You have found a DeepestDawn. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Deep dawn<br>","weaponlog.html")
				if(Y == 150)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Mystic/The_Robe_of_Power)
					Killer<<"<b>You have found a Robe of Power. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Robe of Power<br>","weaponlog.html")
				if(Y == 55000)
					Killer.bank.DepositItem2(new  /obj/Items/Equipment/Body/Armor/The_Vermillion)
					Killer<<"<b>You have found a Vermillion. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found Vermillion<br>","weaponlog.html")
			/*	var/Z = rand(1,40000)
				if(Killer.Giftcd==1)
					Z=0
				if(Z == 39999)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Gift_Box)
					world<<"<b><font color=red size=3>Easter Drop : <font color=yellow>[Killer] <font color=white> has found a Gift Box! </font>"
					Killer<<"<b>You have found a GiftBox. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found a Giftbox!<br>","weaponlog.html")
					Killer.Giftcd=1
					spawn(72000)
					Killer.Giftcd=0
				if(Z == 20000)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Gift_Box)
					world<<"<b><font color=red size=3>Easter Drop : <font color=yellow>[Killer] <font color=white> has found a Gift Box! </font>"
					Killer<<"<b>You have found a GiftBox. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found a Giftbox!<br>","weaponlog.html")
					Killer.Giftcd=1
					spawn(72000)
					Killer.Giftcd=0
				if(Z == 10000)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Gift_Box)
					world<<"<b><font color=red size=3>Easter Drop : <font color=yellow>[Killer] <font color=white> has found a Gift Box! </font>"
					Killer<<"<b>You have found a GiftBox. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found a Giftbox!<br>","weaponlog.html")
					Killer.Giftcd=1
					spawn(72000)
					Killer.Giftcd=0
				if(Z == 30000)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Gift_Box)
					world<<"<b><font color=red size=3>Easter Drop : <font color=yellow>[Killer] <font color=white> has found a Gift Box! </font>"
					Killer<<"<b>You have found a GiftBox. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found a Giftbox!<br>","weaponlog.html")
					Killer.Giftcd=1
					spawn(72000)
					Killer.Giftcd=0
				if(Z == 1)
					Killer.bank.DepositItem2(new  /obj/Items/Other/Gift_Box)
					world<<"<b><font color=red size=3>Easter Drop : <font color=yellow>[Killer] <font color=white> has found a Gift Box! </font>"
					Killer<<"<b>You have found a GiftBox. The item has been placed in your bank."
					text2file("[time2text(world.realtime)]:[Killer] found a Giftbox!<br>","weaponlog.html")
					Killer.Giftcd=1
					spawn(72000)
					Killer.Giftcd=0*/
			var/ExpGain=src.Level*30+rand(-5,5)
			ExpGain=min(ExpGain,Killer.Level*30+rand(-5,5))
			if(istype(src,/mob/Enemy/Bosses))	ExpGain*=3.5
			if(istype(src,/mob/Enemy/Evolved_Hollows))	ExpGain*=1.8
			if(istype(src,/mob/Enemy/Special_Bosses))	ExpGain*=5
			ExpGain=round(ExpGain/max(1,(Killer.Level-src.Level)))
			if(Killer.Level && src.Level >=250)
				if(Killer.ezcheck<1)
					if(abs(src.Level-Killer.Level)<=20 && !Killer.Locked)
						Killer.Honor+=1*(GoldEvent*2)
			if(Serverxp == 1)
				if(!Killer.Locked && Killer.Level<=50)
					Killer.GiveExp((ExpGain * 10 * Killer.vipexp) * Killer.Expboost,"Killed [src]")
					Killer.GiveGold(0,0,src.Level+round((src.Level*Killer.Income * Killer.vipgold)/90*GoldEvent))//divide by 70
				else
					if(!Killer.Locked && Killer.Level>=550)
						Killer.GiveExp((ExpGain * 6 * Killer.vipexp) * Killer.Expboost,"Killed [src]")
						Killer.GiveGold(0,0,src.Level+round((src.Level*Killer.Income * Killer.vipgold)/90*GoldEvent))//divide by 70
					else
						if(!Killer.Locked)
							Killer.GiveExp((ExpGain * 3 * Killer.vipexp) * Killer.Expboost,"Killed [src]")
							Killer.GiveGold(0,0,src.Level+round((src.Level*Killer.Income * Killer.vipgold)/90*GoldEvent))//divide by 70
				if(Killer.insquad && !Killer.Locked)
					Killer.Squadexp+=ExpGain/70 * Killer.vipsquad
			else
				if(Killer.Subscriber == 1)
					Killer.GiveExp(ExpGain * 2 * Killer.vipexp,"Killed [src]")
					Killer.GiveGold(0,0,src.Level+round((src.Level*Killer.Income*Killer.vipgold)/90*GoldEvent))
				else
					Killer.GiveExp(ExpGain,"Killed [src]")
					Killer.GiveGold(0,0,src.Level+round((src.Level*Killer.Income)/90*GoldEvent))
			if(Killer.Party)	for(var/mob/M in Killer.Party.Members)
				if(M!=Killer && MyGetDist(M,Killer)<=Killer.SightRange && !M.invisibility)
					var/LevelDifference=abs(Killer.Level-M.Level)
					if(LevelDifference>=1)	LevelDifference-=1
					var/ExpDifferential=round(ExpGain/2)*round(LevelDifference/5)
					if(Serverxp == 1)
						M.GiveExp(max(0,round(ExpGain*3)-ExpDifferential),"Party Killed [src]")
						M.GiveGold(0,0,src.Level+round((src.Level*M.Income)/50*GoldEvent))
					else
						if(M.Subscriber)
							M.GiveExp(max(0,round(ExpGain)-ExpDifferential),"Party Killed [src]")
						else
							M.GiveExp(max(0,round(ExpGain/2)-ExpDifferential),"Party Killed [src]")
					M.QuestKillCheck(src);//M.EnemyDropCheck(src)
			if(KillEvent==1)
				Killer.KillPoints+=1
			//	A_SB.Update(Killer) // Update the scoreboard
			var/F=rand(1,10)
			if(F==5)
				Killer.Devour+=1
			if(Killer.z==8)
				for(var/atom/x in src.Cache)	del x
				Killer.MatchStart();del src;return
			else	if(!findtext(Killer.Beastiary,"[src.name],",1,0))	Killer.Beastiary+="[src.name],"
		src.Damagers=list()
		src.STM=src.MaxSTM
		src.StmBar()

mob/proc/EnemyDropCheck(var/mob/Enemy/E)
	if(!istype(E,/mob/Enemy))	return
	if(E.Spoils.len<1)	return
	var/datum/EnemySpoils/S=pick(E.Spoils)
	if(S && rand(1,100)<=S.DropRate+round(src.LCK/5))
		var/NewPath=text2path(S.ItemPath);var/obj/NewObj=new NewPath
		if(NewObj.name=="Hollow Mask")	NewObj.name="[E.name] Mask"
		src.GetItem(NewObj)

/*mob/proc/EnemyRareCheck(var/mob/Enemy/E)
	if(!istype(E,/mob/Enemy))	return
	var/datum/EnemyRares/S=pick(E.Spoils)
	if(S && rand(1,10000)==S.DropRate+round(src.LCK/30))
		var/NewPath=text2path(S.ItemPath);var/obj/NewObj=new NewPath
		if(NewObj.name=="Hollow Mask")	NewObj.name="[E.name] Mask"
		src.GetItem(NewObj)*/

mob/proc/QuestKillCheck(var/mob/Enemy/E)
	if(src.z==8)	return
	for(var/datum/QuestDatum/Q in src.Quests)
		for(var/datum/ObjectiveDatum/D in Q.Objectives)
			if(D.Objective=="Kill" && D.Stat==E.name)
				D.Current+=1
				if(D.Current<=D.Goal)	src.TrackQuests()
				if(D.Current==D.Goal)	src.QuestRefresh()
				if(D.Current<=D.Goal)	QuestShow(src,"[D.Current]/[D.Goal] [E]s Killed")

mob/proc/GetExpBar()
	return	round(src.Exp/src.Nexp*25,1)

mob/proc/GiveExp(var/ExpGain,var/Reason="Unknown")
	if(src.ezcheck2==1)
		return
	src.Exp+=ExpGain
	if(src.ExpDisplay=="Orb" || src.ExpDisplay=="Both")
		var/xoff=12
		if(ExpGain>=10)	xoff=8
		if(ExpGain>=100)	xoff=4
		for(var/obj/HUD/ExpOrb/O in src.client.screen)
			O.icon_state="[src.GetExpBar()]"
			//MyFlick("ExpFlash",O)
		src.WriteLine(5,xoff,19,12,"ExpGain","[ExpGain]",1)
		spawn(30)	if(src)	src.WriteLine(5,xoff,19,1,"ExpGain","",1)
	if(src.ExpDisplay=="Screen" || src.ExpDisplay=="Both")
		if(src.z != 16 && src.z != 19 && src.z != 20 && src.z != 24 && src.z != 25 && src.z != 26)
			QuestShow(src,"+[ExpGain] EXP: [src.Exp] / [src.Nexp]")
	var/list/TmpList=list("[Reason]: +[ExpGain] EXP: [src.Exp] / [src.Nexp]")
	var/hb=src.HonorBonus
	TmpList+=src.ExpLog;src.ExpLog=TmpList
	if(src.HonorBonus >= 0) src.Honor+= hb + src.HonorSet
	else
		src.onscreen=1
		//if(src.Level >= 250)	src.Honor += 1
	src.LevelCheck()
	src.SLevelCheck()

proc/TrueValue(var/mob/Gold,var/Silver,var/Copper)
	if(ismob(Gold))
		Copper=Gold.Copper;Silver=Gold.Silver;Gold=Gold.Gold
	Gold="[Gold]";Silver="[Silver]";Copper="[Copper]"
	while(length(Silver)<2)	Silver="0[Silver]"
	while(length(Copper)<2)	Copper="0[Copper]"
	return	"[Gold][Silver][Copper]"

proc/CheckGold(var/Held,var/Cost)
	if(length(Cost)<length(Held))	Cost="0[Cost]"
	if(length(Held)<length(Cost))	Held="0[Held]"
	if(sorttext(Cost,Held)==1)	return 1

mob/proc/GiveGold(var/G2,var/S2,var/C2,var/P2)
	if(src.ezcheck2==1)
		return
	src.Copper+=C2;src.Silver+=S2;src.Gold+=G2;src.Platinum+=P2
	while(src.Copper>=100)
		src.Silver+=1;src.Copper-=100
	while(src.Silver>=100)
		src.Gold+=1;src.Silver-=100
	while(src.Gold>=5000000)
		src.Platinum+=1;src.Gold-=5000000
	if(src.InventoryOpen)	src.DisplayInventory()

mob/proc/TakeGold(var/G2,var/S2,var/C2,var/P2)
	src.Copper-=C2;src.Silver-=S2;src.Gold-=G2;src.Platinum-=P2
	while(src.Copper<0)
		src.Silver-=1;src.Copper+=100
	while(src.Silver<0)
		src.Gold-=1;src.Silver+=100
	while(src.Gold<0)
		src.Platinum-=1;src.Gold+=5000000
	if(src.InventoryOpen)	src.DisplayInventory()

mob/proc/ClearCharOptions()
	PlayMenuSound(src,'OOT_MainMenu_Cancel.wav')
	for(var/obj/HUD/CharOptions/O in src.client.screen)	del O

mob/proc/ShowWings()
	var/obj/Supplemental/Follower/X = new();X.density=0;X.layer=5;X.icon='Effects.dmi';MyFlick("WingR",X)
	src.Followers+=X;X.loc=locate(src.x+1,src.y,src.z);X.pixel_x=-8;X.xoff=1;X.yoff=0;X.dir=src.dir
	spawn(10)	if(X)	del X
	X = new();X.density=0;X.layer=5;X.icon='Effects.dmi';MyFlick("WingL",X)
	src.Followers+=X;X.loc=locate(src.x-1,src.y,src.z);X.pixel_x=8;X.xoff=-1;X.yoff=0;X.dir=src.dir
	spawn(10)	if(X)	del X

var/MobStats=3
mob/proc/ApplyStats(/**/)
	var/Multiplier=1;if(istype(src,/mob/Enemy/Bosses))	Multiplier=6
	if(istype(src,/mob/Enemy/Special_Bosses/Ultima))	Multiplier=8
	if(istype(src,/mob/Enemy/Midlevel))	Multiplier=2
	if(istype(src,/mob/Enemy/Midlevel/Luminous_Fly_Snap))	Multiplier=3
	if(istype(src,/mob/Enemy/Midlevel/Luminous_Pokie))	Multiplier=3
	if(istype(src,/mob/Enemy/Midlevel/Luminous_Gator))	Multiplier=3
	if(istype(src,/mob/Enemy/Midlevel/Luminous_Wasp))	Multiplier=3
	if(istype(src,/mob/Enemy/Soul_Reapers/Shinigami_Guard))	Multiplier=4
	if(istype(src,/mob/Enemy/Soul_Reapers/Shinigami_Ninja))	Multiplier=4
	if(istype(src,/mob/Enemy/Soul_Reapers/Shinigami_Patrol))	Multiplier=4
	if(istype(src,/mob/Enemy/Soul_Reapers/Unseated_Shinigami))	Multiplier=4
	if(istype(src,/mob/Enemy/Soul_Reapers/Drunk_Shinigami))	Multiplier=4
	if(istype(src,/mob/Enemy/Soul_Reapers/Cursed_Shinigami))	Multiplier=4
	if(istype(src,/mob/Enemy/Ghosts/Shinigami_Ghost))	Multiplier=4
	if(istype(src,/mob/Enemy/Evolved_Hollows))	Multiplier=3
	if(istype(src,/mob/Enemy/Special_Bosses/Super_Ultima))	Multiplier=1
	if(istype(src,/mob/Enemy/Special_Bosses/Wild_Beast))	Multiplier=1
	if(istype(src,/mob/Enemy/Special_Bosses/Flame_Eater))	Multiplier=1
	if(istype(src,/mob/Pets))	Multiplier=10
	src.MaxSTM=(initial(src.MaxSTM)+((src.Level-1)*40))*Multiplier
	src.MaxREI=(initial(src.MaxREI)+((src.Level-1)*20))*Multiplier
	src.STR=(initial(src.STR)+((src.Level-1)*MobStats))*Multiplier
	src.VIT=(initial(src.VIT)+((src.Level-1)*MobStats))*1
	src.MGC=(initial(src.MGC)+((src.Level-1)*MobStats))*Multiplier
	src.MGCDEF=(initial(src.MGCDEF)+((src.Level-1)*MobStats))*1
	src.AGI=(initial(src.AGI)+((src.Level-1)*MobStats))*1
	src.LCK=(initial(src.LCK)+((src.Level-1)*MobStats))*Multiplier
	src.STM=src.MaxSTM;src.StmBar()
	src.REI=src.MaxREI;src.ReiBar()

mob/proc/BountPetCheck(/**/)
	if(src.Class!="Bount")	return
	if(src.Level>=50&&src.Level<100)	if(src.GainedSun==0)
		for(var/mob/Pets/BountPets/P in src.Pets)
			src.Pets-=P;del P
		src.Pets+=new/mob/Pets/BountPets/Sun_Flower
		for(var/mob/Pets/BountPets/P in src.Pets)
			P.Owner=src
			P.Level+=src.Level;P.ApplyStats()
		src<<"You Pet has evolved!";src<<"Youll now need to create a new combo for your Evolved Pet!";src.GainedSun=1
	if(src.Level>=100&&src.Level<500)	if(src.GainedEvoSun==0)
		for(var/mob/Pets/BountPets/P in src.Pets)
			src.Pets-=P;del P
		src.Pets+=new/mob/Pets/BountPets/Evo_Sun_Flower
		for(var/mob/Pets/BountPets/P in src.Pets)
			P.Owner=src
			P.Level+=src.Level;P.ApplyStats()
		src<<"You Pet has evolved!";src<<"Youll now need to create a new combo for your Evolved Pet!";src.GainedEvoSun=1
mob/proc/SLevelCheck(/**/)
	if(src.Squadlevel>=5)
		if(src.Squadexp<src.Squadnexp)	src.Squadexp=src.Squadnexp
		return
	if(src.Squadexp>=src.Squadnexp)
		src.Squadlevel+=1
		src.Squadexp=src.Squadexp-src.Squadnexp
		src.Squadnexp+=src.Squadlevel * 5000000
		src.Bonus_Removal2()
		src.Bonus_Check()
		world<<"<b><font size=1><font color=green size=2>Squad Info: <font color=blue size=1>[src] has Reached <font color=red>Squad Level</font> [src.Squadlevel]!"
		text2file("[time2text(world.timeofday,"hhmmss")]:[src]([src.client.computer_id])[src.Level]","LevelLogs/Squadlevel/[time2text(world.timeofday,"YYYYMMMDD")].txt")
		src.Save()
mob/proc/LevelCheck(/**/)
	if(src.Level==50 && src.lvl51<=0)
		src<<"<font color=yellow><br>Congratulations on reaching level 51, you will no longer benefit from extra experience from kills .</font></b>"
		src.lvl51=1
	if(src.Level>=100 && !src.badge100)
		src.bBadges+=2
		src.badge100=1
		src<<"<font color=yellow><br>You have received 2 bound Honor Badges for reaching level 100. Congratulations.</font></b>"
	if(src.Level>=200  && !src.badge200)
		src.bBadges+=5
		src.badge200=1
		src<<"<font color=yellow><br>You have received 5 bound Honor Badges for reaching level 200. Congratulations.</font></b>"
	if(src.Level>=300  && !src.badge300)
		src.bBadges+=8
		src.badge300=1
		src<<"<font color=yellow><br>You have received 8 bound Honor Badges for reaching level 300. Congratulations.</font></b>"
	if(src.Level>=400  && !src.badge400)
		src.bBadges+=10
		src.badge400=1
		src<<"<font color=yellow><br>You have received 10 bound Honor Badges for reaching level 400. Congratulations.</font></b>"
	if(src.Level>=500  && !src.badge500)
		src.bBadges+=15
		src.badge500=1
		src<<"<font color=yellow><br>You have received 15 bound Honor Badges for reaching level 500. Congratulations.</font></b>"
	if(src.Level==750  && !src.badge750)
		src.bBadges+=25
		src.badge750=1
		src<<"<font color=yellow><br>You have received 25 bound Honor Badges for reaching level 750. Congratulations.</font></b>"
	if(src.Level>=750)
		src.Level=750
		src.Nexp=20000000
		if(src.Exp>src.Nexp)	src.Exp=src.Nexp
		return
	if(src.LHD!=round((src.Level*3+7)/6))	return
	if(src.Exp>=src.Nexp)
		src.ShowWings()
		src.Level+=1
		src.LHD=round((src.Level*3+7)/6)
		src.MaxSTM+=10
		src.MaxREI+=5
		src.STM=src.MaxSTM
		src.REI=src.MaxREI
	//	if(src.Level>500)
	//		src.TraitPoints+=2
	//		src.MaxSTM+=30
	//		src.MaxREI+=15
		src.StatPoints+=3
		src.TraitPoints+=1
		src.SkillPoints+=1
		src.Exp=src.Exp-src.Nexp
		if(src.Level>500)
			src.Nexp+=src.Level*50000
		else
			if(src.Level>=200)
				src.Nexp+=src.Level*500
			else
				src.Nexp+=src.Level*100
		var/Phours=round(src.PlayTime/60/60)
		var/Pminutes=round(src.PlayTime/60-(60*Phours))
		src.LevelLog="<tr><td><center><font color=gray><b>[src.Level]<td><center><font color=gray><b>[Phours]h [Pminutes]m[src.LevelLog]"
		world<<"<b><font size=1><font color=blue>[src] has Reached Level [src.Level]"
		text2file("[time2text(world.timeofday,"hhmmss")]:[src]([src.client.computer_id])[src.Level]","LevelLogs/[time2text(world.timeofday,"YYYYMMMDD")].txt")
		for(var/obj/HUD/ExpOrb/O in src.client.screen)
			O.icon_state="[src.GetExpBar()]"
		for(var/obj/HUD/LevelOrb/O in src.client.screen)
			O.icon_state="LvlFlash"
		UpdateOverallScores(src.name,src.Class,src.Level,src.PlayTime)
		if(src.Level%10==0)
			src.GetItem(new/obj/Items/Other/Progress_Cupon)
		src.BountPetCheck()
		for(var/mob/Pets/P in src.Pets)
			P.ShowWings();P.Level+=1;P.ApplyStats()
		src.TrackQuests()
		src.QuestRefresh()
		src.LevelDisplay()
		src.LevelCheck()
		src.HUDRefresh()
		src.StmBar()
		src.ReiBar()
		src.Save()
		if(src.Subscriber)
			src.StatPoints+=1
			src.SkillPoints+=1
			//src.TraitPoints+=1

proc/Split(var/text2split,var/SplitBy)
	var/CurPos=1
	var/list/SplitList=list()
	while(findtext(text2split,SplitBy,CurPos,0))
		var/NextPos=findtext(text2split,SplitBy,CurPos,0)
		SplitList+=copytext(text2split,CurPos,NextPos)
		CurPos=NextPos+1
	if(CurPos<=length(text2split))	SplitList+=copytext(text2split,CurPos,0)
	return SplitList

mob/proc/ChangeName()
	var/list/L
	L = list("font size","span","font color","http","www","<br>","<",">",".","a href","*",";",".",",","-",":","/","+","|")
	var/NewName=TextInput(src,"Input Character Name","Name",src.name)
	if(!NewName)	return
	if(!src)	return
	if(lentext(NewName) > 30)
		src<<"<font color=red>Name must not exceed 30 letters!"
		src.name=src.key
		return
	for(var/X in L)
		if(findtext(NewName,X))
			src<<"You cannot add html or fonts"
			src.name=src.key
			return
	src.name=TrimSpaces(NewName)
	src.NameGuard()





proc/TrimSpaces(var/Text2Trim)
	while(length(Text2Trim)>=1 && copytext(Text2Trim,1,2)==" ")
		Text2Trim=copytext(Text2Trim,2,0)
	while(length(Text2Trim)>=2 && copytext(Text2Trim,length(Text2Trim),0)==" ")
		Text2Trim=copytext(Text2Trim,1,length(Text2Trim))
	return Text2Trim

mob/proc/NameGuard(/**/)
	var/list/ReservedNames=list("Falacy","FaIacy","Strai","SolarOblivion","SoIarOblivion","SolarObIivion","SoIarObIivion","Millamber","Tmx85","Millamber","XxLucifersAngelxX","Kabuto","Nikorayu")
	for(var/mob/Player/M in world)	if(M.client && M!=src)	ReservedNames+=M.name
	src.name=FilterMessage(src.name)
	if(!src.name)	src.name=src.key
	src.name=sd.ProcessHTML(copytext(src.name,1,16))
	if(length(src.name)>=1)	src.name="[uppertext(copytext(src.name,1,2))][copytext(src.name,2)]"
	src.name=AsciiCheck(src.name)
	if(!src.name)	src.name=src.key
	if(src.name in ReservedNames)
		src.name=src.key;src<<"<font color=red>This Name is Reserved!"


var/obj/AngleArrow=new/obj/Supplemental/AngleArrow
obj/Supplemental/AngleArrow
//	icon='Effects.dmi';icon_state="AngleArrow"

proc/Spaceless(var/T)
	while(findtext(T," ",1,0))
		T=copytext(T,1,findtext(T," ",1,0))+copytext(T,findtext(T," ",1,0)+1,0)
	while(findtext(T,"'",1,0))
		T=copytext(T,1,findtext(T,"'",1,0))+copytext(T,findtext(T,"'",1,0)+1,0)
	while(findtext(T,".",1,0))
		T=copytext(T,1,findtext(T,".",1,0))+copytext(T,findtext(T,".",1,0)+1,0)
	return T

var/icon/RedAlphabet='Alphabet.dmi'
obj/Supplemental/NameDisplay
//	icon='Alphabet.dmi'
	layer=3
	pixel_y=-10
	New(var/px,var/IS)
		src.pixel_x=px+9
		src.icon_state=IS
		if(LowLetter(IS))	src.pixel_y-=2
atom/proc/AddName(var/Name2Add)
	if(ismob(src) && src:client)
		src.overlays-=AngleArrow;src.overlays+=AngleArrow
	if(RedAlphabet=='Alphabet.dmi')	RedAlphabet+=rgb(150,0,0)
	if(!Name2Add)	Name2Add=src.name
	var/letter=" "
	var/spot=0
	for(var/O in src.overlays)	if(O:name=="NameDisplay")	src.overlays-=O
	var/PixelSpace=6
	var/px=((1*PixelSpace)-(length(Name2Add)*PixelSpace)/2)-PixelSpace
	while(src)
		spot+=1
		letter=copytext(Name2Add,spot,spot+1)
		if(!letter)	return
		px+=PixelSpace
		var/obj/NL=new/obj/Supplemental/NameDisplay(px,letter)
		if(SlimLetter(letter))	px-=4
		if(isobj(src))	NL.icon='NPCAlphabet.dmi'
		if(istype(src,/mob/Enemy/Bosses))	NL.icon=RedAlphabet
		if(istype(src,/mob/Enemy/Special_Bosses))	NL.icon=RedAlphabet
		src.overlays+=NL
	SaveConfig()
atom/proc/AddLevel(var/Name2Add)
	if(RedAlphabet=='Alphabet.dmi')	RedAlphabet+=rgb(150,0,0)
	if(!Name2Add)	Name2Add="(XXX)"
	var/letter=" "
	var/spot=0
	for(var/O in src.overlays)
		if(O)	if(O:name=="LevelDisplay")	src.overlays-=O
		else	src.overlays-=O
	while(src)
		spot+=1
		letter=copytext(Name2Add,spot,spot+1)
		if(!letter)	return
		var/px=(length(src.name)*6/2)+spot*6
		var/obj/NL=new/obj/Supplemental/NameDisplay(px,letter)
		if(istype(src,/mob/Enemy/Bosses))	NL.icon=RedAlphabet
		if(istype(src,/mob/Enemy/Special_Bosses))	NL.icon=RedAlphabet
		NL.name="LevelDisplay"
		src.overlays+=NL

mob/proc/LoadVoiceSet()
	if(src.VoiceSet=="Ichigo")
		src.AttVoices=list('IchigoAtt1.wav','IchigoAtt2.wav','IchigoAtt3.wav','IchigoAtt4.wav')
		src.HurtVoices=list('IchigoHurt1.wav')
	if(src.VoiceSet=="Toshiro")
		src.AttVoices=list('ToshiroAtt1.wav','ToshiroAtt2.wav','ToshiroAtt3.wav','ToshiroAtt4.wav')
		src.HurtVoices=list('ToshiroHurt1.wav')
	if(src.VoiceSet=="Sora")
		src.AttVoices=list('SoraAtt1.wav','SoraAtt2.wav','SoraAtt3.wav','SoraAtt4.wav')
		src.HurtVoices=list('SoraHurt1.wav','SoraHurt2.wav','SoraHurt3.wav')
	if(src.VoiceSet=="Young Link")
		src.AttVoices=list('YLAtt1.wav','YLAtt2.wav','YLAtt3.wav','YLAtt4.wav')
		src.HurtVoices=list('YLHurt1.wav','YLHurt2.wav','YLHurt3.wav')
	if(src.VoiceSet=="Link")
		src.AttVoices=list('LinkAtt1.wav','LinkAtt2.wav','LinkAtt3.wav','LinkAtt4.wav','LinkAtt5.wav','LinkAtt6.wav')
		src.HurtVoices=list('LinkHurt1.wav','LinkHurt2.wav','LinkHurt3.wav')
	if(src.VoiceSet=="Rukia")
		src.AttVoices=list('RukiaAtt1.wav','RukiaAtt2.wav','RukiaAtt3.wav')
		src.HurtVoices=list('RukiaHurt1.wav','RukiaHurt2.wav','RukiaHurt3.wav')

atom/proc/ZanConfigure(var/atom/A)
	if(A.name=="BackSpikes")	src.icon='BackSpikes.dmi'
	if(A.name=="Enlarge")	src.icon='Enlarge.dmi'
	if(A.name=="FrontSpikes")	src.icon='FrontSpikes.dmi'
	if(A.name=="Overall")	src.icon='Overall.dmi'

atom/proc/HairConfigure(var/HS)
	if(HS=="Byakuya")	src.icon='Byakuya.dmi'
	if(HS=="ByakuyaBankai")	src.icon='ByakuyaBankai.dmi'
	if(HS=="Ichigo")	src.icon='Ichigo.dmi'
	if(HS=="IchigoBankai")	src.icon='IchigoBankai.dmi'
	if(HS=="Izuru")	src.icon='Izuru.dmi'
	if(HS=="IzuruBankai")	src.icon='IzuruBankai.dmi'
	if(HS=="Kenpachi")	src.icon='Kenpachi.dmi'
	if(HS=="KenpachiBankai")	src.icon='KenpachiBankai.dmi'
	if(HS=="Renji")	src.icon='Renji.dmi'
	if(HS=="RenjiBankai")	src.icon='RenjiBankai.dmi'
	if(HS=="Toshiro")	src.icon='Toshiro.dmi'
	if(HS=="ToshiroBankai")	src.icon='ToshiroBankai.dmi'
	if(HS=="Urahara")	src.icon='Urahara.dmi'
	if(HS=="UraharaBankai")	src.icon='UraharaBankai.dmi'
	if(HS=="Uryu")	src.icon='Uryu.dmi'
	if(HS=="UryuBankai")	src.icon='UryuBankai.dmi'
	if(HS=="Maki")	src.icon='Maki.dmi'
	if(HS=="MakiBankai")	src.icon='MakiBankai.dmi'
	if(HS=="Yoruichi")	src.icon='Yoruichi.dmi'
	if(HS=="YoruichiBankai")	src.icon='YoruichiBankai.dmi'

var/list/CachedRGBs=list()
proc/MyRGB(var/icon/I,var/RGB)
	//return I+RGB
	//This apparently uses up epic amounts of memory?
	var/ThisCode="[I][RGB]"
	if(ThisCode in CachedRGBs)	return CachedRGBs[ThisCode]
	I+=RGB
	CachedRGBs+=ThisCode
	CachedRGBs[ThisCode]=I
	return I

obj/HairOver
	pixel_y=9
	layer=6
atom/proc/AddHair(var/Style,var/State)
	if(!src.HairOver)
		var/obj/HairOver/HO=new()
		src.HairOver=HO
	src.HairOver.layer=src.layer+2
	src.overlays-=src.HairOver
	if(Style=="Bald")	return
	src.HairOver.HairConfigure("[Style][State]")
	src.HairOver.icon=MyRGB(src.HairOver.icon,rgb(src.HairR,src.HairG,src.HairB))
	src.overlays+=src.HairOver


obj/Supplemental/Effect
	mouse_opacity=0
	var/MyExtraTag	//used to check for stun effects, cleared on death
	New(atom/A)
		spawn()
			while(A)
				if(src.x!=A.x || src.y!=A.y || src.z!=A.z)	src.loc=locate(A.x,A.y,A.z)
				sleep(1)
			del src
proc
	ShowEffect(var/atom/A,IC,IS,Position,duration=10,loop=0,WasStay,ExtraTag,NewDir)
		//stopped using the Stay (WasStay) variable...
		if(!A)	return
		var/obj/Supplemental/Effect/X=new(A)
		X.density=0;X.layer=9;X.MyExtraTag=ExtraTag
		if(X.icon!=IC)	X.icon=IC
		X.loc=locate(A.x,A.y,A.z)
		if(Position=="between2")
			if(A.dir==NORTH)	X.pixel_y+=16;X.pixel_x+=rand(-8,8)
			if(A.dir==SOUTH)	X.pixel_y-=16;X.pixel_x+=rand(-8,8)
			if(A.dir==EAST)	X.pixel_x+=16;X.pixel_y+=rand(-8,8)
			if(A.dir==WEST)	X.pixel_x-=16;X.pixel_y+=rand(-8,8)
		if(Position=="Above")	X.pixel_y=12
		if(Position=="onNORTH")	X.dir=NORTH
		if(Position=="onSOUTH")	X.dir=SOUTH
		if(Position=="onEAST")	X.dir=EAST
		if(Position=="onWEST")	X.dir=WEST
		if(NewDir)	X.dir=NewDir
		if(loop==1)	X.icon_state="[IS]"
		MyFlick("[IS]",X)
		if(duration)	spawn(duration)	if(X)	del(X)
		else	world.log<<"Infinite Effect: [A], [IC], [IS], [Position], [duration], [loop], [WasStay], [ExtraTag], [NewDir]"

var/list/DamageNums=list()
proc/PopulateDamageNums()
	set background=1
	for(var/i=1;i<=500;i++)
		DamageNums+=new/obj/Supplemental/DamageNum

var/list/HealNums=list()
proc/PopulateHealNums()
	set background=1
	for(var/i=1;i<=500;i++)
		HealNums+=new/obj/Supplemental/HealNum

obj
	Supplemental
		DamageNum
//			icon='DamageNums.dmi'
			density=0;layer=10
		HealNum
//			icon='HealNums.dmi'
			density=0;layer=10
		/*DamageNumColor
			icon='DamageNumColor.dmi'
			New()
				spawn(11)	del src*/
proc/DamageShow(var/S,var/damage,var/DamageIcon='DamageNums.dmi')
	if(!S)	return
	src=S
	if(istext(damage))
		var/obj/O=DamageNums[1]
		DamageNums-=O;DamageNums+=O
		if(O.icon!='DamageNums.dmi')	O.icon='DamageNums.dmi'
		O.loc=locate(src:x,src:y,src:z)
		MyFlick("[damage]",O)
		spawn(10)	O.loc=null
		return
	damage=num2text(damage)
	var/pxplus=-7
	var/spot=0
	var/RandX=rand(0,20)
	var/RandY=rand(0,12)
	while(pxplus<(length(damage)*7)-7)
		spot+=1
		if(!copytext(damage,spot,spot+1))	return
		pxplus+=7
		var/obj/Supplemental/DamageNum/O=DamageNums[1]
		DamageNums-=O;DamageNums+=O
		O.pixel_x=pxplus+RandX
		O.pixel_y=RandY
		if(O.icon!=DamageIcon)	O.icon=DamageIcon
		O.loc=locate(src:x,src:y,src:z)
		//var/obj/Supplemental/DamageNumColor/DNC=new()
		//DNC.icon+=rgb(VarR,VarG,VarB);DNC.layer=O.layer+1;O.overlays+=DNC
		MyFlick("[copytext(damage,spot,spot+1)]",O)
		spawn(10)	O.loc=null

proc/HealShow(var/S,var/damage,var/HealIcon='HealNums.dmi')
	if(!S)	return
	src=S
	if(istext(damage))
		var/obj/O=HealNums[1]
		HealNums-=O;HealNums+=O
		if(O.icon!='HealNums.dmi')	O.icon='HealNums.dmi'
		O.loc=locate(src:x,src:y,src:z)
		MyFlick("[damage]",O)
		spawn(10)	O.loc=null
		return
	damage=num2text(damage)
	var/pxplus=-7
	var/spot=0
	var/RandX=rand(0,20)
	var/RandY=rand(0,12)
	while(pxplus<(length(damage)*7)-7)
		spot+=1
		if(!copytext(damage,spot,spot+1))	return
		pxplus+=7
		var/obj/Supplemental/HealNum/O=HealNums[1]
		HealNums-=O;HealNums+=O
		O.pixel_x=pxplus+RandX
		O.pixel_y=RandY
		if(O.icon!=HealIcon)	O.icon=HealIcon
		O.loc=locate(src:x,src:y,src:z)
		//var/obj/Supplemental/DamageNumColor/DNC=new()
		//DNC.icon+=rgb(VarR,VarG,VarB);DNC.layer=O.layer+1;O.overlays+=DNC
		MyFlick("[copytext(damage,spot,spot+1)]",O)
		spawn(10)	O.loc=null

mob/proc
	LevelOrbGlow()
		if(src.StatPoints<=0 && src.SkillPoints<=0 && src.TraitPoints<=0)
			for(var/obj/HUD/LevelOrb/O in src.client.screen)
				O.icon_state="LvlOrb"
	ButtonGlow(/**/)
		if(src.SkillPoints>=1)
			var/obj/SL=new/obj/HUD/UnLearned_Skill(3,2);SL.icon_state="SkillsGlowL";src.client.screen+=SL
			var/obj/SR=new/obj/HUD/UnLearned_Skill(4,2);SR.icon_state="SkillsGlowR";src.client.screen+=SR
			var/obj/CL=new/obj/HUD/UnLearned_Skill(6,2);CL.icon_state="CombosGlowL";src.client.screen+=CL
			var/obj/CR=new/obj/HUD/UnLearned_Skill(7,2);CR.icon_state="CombosGlowR";src.client.screen+=CR
			var/obj/AL=new/obj/HUD/UnLearned_Skill(9,2);AL.icon_state="ArtsGlowL";src.client.screen+=AL
			var/obj/AR=new/obj/HUD/UnLearned_Skill(10,2);AR.icon_state="ArtsGlowR";src.client.screen+=AR
		if(src.StatPoints>=1)
			var/obj/NL=new/obj/HUD/UnLearned_Skill(12,2);NL.icon_state="StatsGlowL";src.client.screen+=NL
			var/obj/NR=new/obj/HUD/UnLearned_Skill(13,2);NR.icon_state="StatsGlowR";src.client.screen+=NR
		if(src.TraitPoints>=1)
			var/obj/NL=new/obj/HUD/UnLearned_Skill(15,2);NL.icon_state="TraitsGlowL";src.client.screen+=NL
			var/obj/NR=new/obj/HUD/UnLearned_Skill(16,2);NR.icon_state="TraitsGlowR";src.client.screen+=NR
	WriteTraitScreen()
		for(var/obj/HUD/UnLearned_Skill/O in src.client.screen)	del O
		src.ButtonGlow()
		src.WriteLine(9,0,17,12,"SkillPoints","Trait Points: [round(src.TraitPoints)]",1)
		src.WriteLine(2,src.CSV(src.Zanjutsu),16,12,"SkillPoints","[round(src.Zanjutsu)]",0)
		src.WriteLine(2,src.CSV(src.Hakuda),14,12,"SkillPoints","[round(src.Hakuda)]",0)
		src.WriteLine(2,src.CSV(src.Hohou),12,12,"SkillPoints","[round(src.Hohou)]",0)
		src.WriteLine(2,src.CSV(src.Kidou),10,12,"SkillPoints","[round(src.Kidou)]",0)
		src.WriteLine(2,src.CSV(src.Prodigy),8,12,"SkillPoints","[round(src.Prodigy)]",0)
		src.WriteLine(2,src.CSV(src.Training),6,12,"SkillPoints","[round(src.Training)]",0)
		src.WriteLine(2,src.CSV(src.Income),4,12,"SkillPoints","[round(src.Income)]",0)
	WriteStatScreen()
		for(var/obj/HUD/UnLearned_Skill/O in src.client.screen)	del O
		src.ButtonGlow()
		src.WriteLine(9,0,17,12,"SkillPoints","Stat Points: [round(src.StatPoints)]",1)
		src.WriteLine(2,src.CSV(src.MaxSTM),15,12,"SkillPoints","[round(src.MaxSTM)]",0)
		src.WriteLine(2,src.CSV(src.MaxREI),14,12,"SkillPoints","[round(src.MaxREI)]",0)
		src.WriteLine(2,src.CSV(src.STR),12,12,"SkillPoints","[round(src.STR)]",0)
		src.WriteLine(2,src.CSV(src.VIT),11,12,"SkillPoints","[round(src.VIT)]",0)
		src.WriteLine(2,src.CSV(src.MGC),9,12,"SkillPoints","[round(src.MGC)]",0)
		src.WriteLine(2,src.CSV(src.MGCDEF),8,12,"SkillPoints","[round(src.MGCDEF)]",0)
		src.WriteLine(2,src.CSV(src.AGI),6,12,"SkillPoints","[round(src.AGI)]",0)
		src.WriteLine(2,src.CSV(src.LCK),5,12,"SkillPoints","[round(src.LCK)]",0)

mob/proc/CSV(var/Stat2Center)//Center Stat Value
	var/StartOffset=12
	if(Stat2Center>=10)	StartOffset-=3
	if(Stat2Center>=100)	StartOffset-=4
	if(Stat2Center>=1000)	StartOffset-=3
	return StartOffset

mob/proc/DamageChain(var/obj/Bankai/Chains/C,var/damage)
	if(C.HP<=0)	return
	var/DamageIcon='DamageNums.dmi'
	DamageShow(C,damage,DamageIcon)
	C.HP-=damage
	var/mob/ThisOwner=C.Owner
	if(C.HP<=0)
		if(!C.Owner)	return
		C.Owner.TurnMode=0
		MyFlick("Destroy",C)
		C.icon_state="invis"
		C.density=0
		var/counter=0
		for(var/obj/Bankai/Chains/X in C.Owner.ChainList)
			counter+=1;if(X==C)	break
		if(counter<=C.Owner.ChainList.len/2)
			spawn()	for(var/obj/Bankai/Chains/X in get_step(C,C.BackDir(C.ActualDir)))	X.Destroy()
			for(var/obj/Bankai/Chains/X in get_step(C,C.NextDir))	X.DestroyForward()
		else
			spawn()	for(var/obj/Bankai/Chains/X in get_step(C,C.NextDir))	X.DestroyForward()
			for(var/obj/Bankai/Chains/X in get_step(C,C.BackDir(C.ActualDir)))	X.Destroy()
		if(ThisOwner)
			ThisOwner.icon_state=""
			ThisOwner.CanMove=1
		spawn(10)	if(C)	del C

mob/proc/CanPVP(var/mob/M)
	if(src.Owner)	src=src.Owner
	if(M.Owner)	M=M.Owner
	if(src==M)	return
	if(src.client && M.client)
		if(src.PVPingAgainst==M || M.PVPingAgainst==src)	return 1
		if(!src.PVP || !M.PVP)	return
	return 1

mob/proc/Damage(var/mob/M,var/damage,var/Element,var/DblChance=1,var/DamageType="Break")	//2 DblChance = Backlash Damage
	//if(M.MultiCore)	M=M.MultiCore
	/*if(M.key=="Millamber")
		M.STM=M.MaxSTM
		src.STM=0
		src.DeathCheck()
		world<<"<b><font color=red>[src] <font color=white>dared to attack Kabuto and was instantly obliterated."*/
	if(src==M)	return
	if(src.jailed==1)	return
	if(M.jailed==1)	return
	if(src.key=="Millamber")
		if(PVPAll)
			goto PVPAll
	if(!src.CanPVP(M))	return
	if(src.client && src.Target && MyGetDist(src,src.Target)<=src.SightRange)
	else	src.TargetMob(M)
	src.ForceEnemyStart(M)
	if(M.client && M.Target && MyGetDist(M,M.Target)<=M.SightRange)
	else	M.TargetMob(src)
	PVPAll
	M.ForceEnemyStart(src)
	if(M.invisibility ==0)
		M.RegenWait=10
	M.CombatPhase()
	if(!M.Blocking && M.OverDriveOn)
		M.OverDriveStr=1;return
	if(DblChance==1)
		if(rand(1,100)<=src.DoubleStrikeBonus)	{DamageShow(src,"Double Strike");src.Damage(M,damage,Element,0,DamageType)}
	if(!src || !M)	return	//killed in the arena with Double Strike I'm guessing <.< still not 100% sure
	var/LckBonus=max(0,round((src.LCK-M.LCK)/*/2*/))	//your chance to crit
	var/SpdBonus=max(0,round((M.AGI-src.AGI)/25/*was 15 then 20*/))	//their chance to dodge
	if(rand(1,300)<=1+M.DodgeBonus+SpdBonus-(src.Hakuda/2)+(M.Hohou/3))//added src and M level to divide stats
		DamageShow(M,pick("Dodge","Miss"));PlaySoundEffect(view(M,M.SightRange),'miss.wav');return
	var/DamageIcon='DamageNums.dmi'
	if(src.client)	M.PVPWait=10
	if(M.client)	src.PVPWait=10
	if("Scatter" in M.ToggledSkills)
		if(M.dir==get_dir(M,src))
			PlaySoundEffect(view(src,src.SightRange),pick('SwordBlock1.wav','SwordBlock2.wav'),2)
			ShowEffect(M,'Effects.dmi',"counterspark","between2",10)
			ShowEffect(M,'Effects.dmi',"PetalSpark","",10);return
	if("Blood Mist Shield" in M.ToggledSkills)
		if(M.dir==get_dir(M,src))
			PlaySoundEffect(view(src,src.SightRange),pick('SwordBlock1.wav','SwordBlock2.wav'),2)
			ShowEffect(M,'Effects.dmi',"counterspark","between2",10)
			ShowEffect(M,'Effects.dmi',"BMSpark","",10);return
	/*if(src.Zanpakuto && src.Bankai && src.Zanpakuto.SpiritType=="Hornet")
		for(var/mob/M2 in oview(1,M.loc))
			M2.STM-=200;M.StmBar()
		for(var/turf/T in oview(1,M.loc))
			if(!T.density)
				var/obj/Supplemental/Suzume_Destroy/MT=new(T);src.Cache+=MT
				spawn(10)	if(MT)	del MT
				goto AoEDone
	AoEDone*/
	if(rand(1,M.GuardBonus)==10)
		M.Guard();DamageShow(M,"Guard")
	if(DamageType=="Melee")	damage=src.MeleeDamage(M,damage)
	if(DamageType=="Mystic")	damage=src.MysticDamage(M,damage)
	if(src.FindEffect("Offensive Tactics"))	damage+=round(damage*(10/100))
	if(src.Vaizard)	damage+=round(damage*(10/100))
	if(M.FindEffect("Defensive Strategy"))	damage-=round(damage*(10/100))
	if(M.Vaizard)	damage-=round(damage*(10/100))
	if(M.AttackHeight==src.AttackHeight||M.Blocking)
		if(M.AttackHeight!=0 || M.Blocking)
			PlaySoundEffect(view(M,M.SightRange),pick('SwordBlock1.wav','SwordBlock2.wav'),2)
			ShowEffect(M,'Effects.dmi',"counterspark","between2",10)
			if(M.Blocking)	M.dir=get_dir(M,src)
			if(DamageType=="Melee")
				if(M.Blocking && DblChance!=2 && MyGetDist(src,M)<=1)
					for(var/obj/Skills/SoulReaper/Backlash/B in M.Skills)
						DamageShow(M,"Backlash");M.Damage(src,max(0,round(damage/2)),null,2,"Break")
			if(M in oview(1,src))
				for(var/obj/Skills/SoulReaper/Counter_Attack/G in M.Skills)
					if(rand(1,100)<=10)	{MyFlick("F3",M);src.StunProc(2,"Stun",M);PlayVoice(view(M,M.SightRange),pick(M.AttVoices))}
					//else	M.ColorFlick(M.GuardIcon)
					goto Flicked
			//M.ColorFlick(M.GuardIcon)
			Flicked
			for(var/obj/Skills/SoulReaper/Guard_Breaker/G in src.Skills)
				damage=round(damage/2)//DamageShow(M,"Guard Break")
				DamageIcon='GuardDamage.dmi'
				goto NoReturn
			return
			NoReturn
	//else	M.ColorFlick(M.DamageIcon)
	if(M.client)	PlayVoice(view(M,M.SightRange),pick(M.HurtVoices))
	src.AttackCauseStatusEffects(M)
	if(Element)
		new/obj/Supplemental/ElemSpark(M,Element)
		if(Element in M.ElemWeakness)	damage*=2
		if(Element in M.ElemStrength)	damage=round(damage/2)
		if(Element in M.Immunities)	{damage=0;DamageShow(M,"Immune")}
	if(DamageType=="Melee")	damage+=round(damage*(src.Zanjutsu/100))
	if(DamageType=="Mystic")	damage+=round(damage*(src.Kidou/100))
	if(rand(1,100)<=1+LckBonus+src.CritBonus)	{damage*=2;DamageIcon='CritDamage.dmi'}
	damage-=round(damage*(M.ShieldBonus/200)+M.VIT/30)
	if(istype(M,/mob/Enemy))	if(M.Level-src.Level>1)	damage=round(damage/(M.Level-src.Level))
	if(src.client && M.client)	damage=round(damage/2,1)	//PVP Damage
	if(istype(M,/mob/Enemy/Special_Bosses))	damage=round(damage/2.5)
	for(var/datum/StatusEffects/Invincibles/SEI in M.StatusEffects)	damage=0
	//figure up the last gasps after all damage calcs!
	for(var/obj/Skills/SoulReaper/Last_Gasp/G in M.Skills)
		if(M.z!=13)
			if(WorldPVP==0)
				if(M.STM<=damage && M.STM>1)		{damage=min(damage,M.STM-1);DamageShow(M,"Last Gasp");M.LastGasp("Last_Gasp")}
	for(var/obj/Skills/Quincy/Pride_of_the_Quincy/G in M.Skills)
		if(M.z!=13)
			if(WorldPVP==0)
				if(M.STM<=damage && M.STM>1)		{damage=min(damage,M.STM-1);DamageShow(M,"Pride");M.LastGasp("Quincy_Pride")}
	damage=round(damage)
	for(var/obj/Items/Equipment/Hand/Weapons/X in src.EquipmentList)
		if(istype(X,/obj/Items/Equipment/Hand/Weapons/The_Legendary_Ark))
			for(var/mob/Enemy/O in oview(src,src.SightRange))
				damage=round(damage)
				//DamageShow(O,damage,DamageIcon)
				O.STM-=damage;O.StmBar()
				O.DeathCheck(src)
			//	goto continue12
		if(istype(X,/obj/Items/Equipment/Hand/Weapons/Abyssal_Shard))
			for(var/mob/Enemy/O in oview(src.Target,src.Target.SightRange))
				damage=round(damage)/2
				O.STM-=damage;O.StmBar()
				//DamageShow(O,damage,DamageIcon)
				O.DeathCheck(src)
		else
			goto continue11
				//goto continue12
	continue11
	M.STM-=damage;M.StmBar()
	DamageShow(M,damage,DamageIcon)
//	continue12
	if(istype(M,/mob/Enemy))	M.TrackDamage(src,damage)
	if(M.REI<M.MaxREI)
		for(var/obj/Skills/Universal/Rei_Rage/R in M.Skills)
			M.REI=min(M.MaxREI,round(M.REI+(damage*(R.Level*(10/100)))));M.ReiBar()
	M.DeathCheck(src)

mob/proc/LastGasp(var/EffectType="Last_Gasp")
	var/Pathy=text2path("/datum/StatusEffects/Invincibles/[EffectType]")
	var/datum/StatusEffects/E=new Pathy
	src.AddEffect(E)
	spawn(10)	if(src && E)	E.RemovalProc(src)

mob/proc/AttackCauseStatusEffects(var/mob/M)
	if(src.Shikai)	for(var/obj/Skills/Shikais/Earth_Beast/Wound/S in src.Shikai)
		var/Durate=7+((S.Level-1)*2)
		var/DPS=round(src.STR/10)
		M.AddEffect(new/datum/StatusEffects/PoisonTypes/Bleed(Durate,src.name,DPS,"Cause [DPS] Bleed Damage for [Durate] Seconds"))
	if(src.Shikai)	for(var/obj/Skills/Shikais/Ice_Dragon/Freeze_Blade/S in src.Shikai)
		var/O=rand(1,100)
		if(O <= S.Level*10)
			M.StunProc(40,"Freeze",src)
	if(src.Shikai)	for(var/obj/Skills/Bankais/God_Spear/Sword_Pierce/S in src.Shikai)
		var/Durate=5+((S.Level-1)*2)
		var/DPS=round(src.STR/20)
		M.AddEffect(new/datum/StatusEffects/PoisonTypes/Poison(Durate,src.name,DPS,"Cause [DPS] Poison Damage for [Durate] Seconds"))

mob/proc/MeleeDamage(var/mob/M,var/damage=0)
	damage=max(1,damage-M.VIT/2)//was vit 1.5
	for(var/datum/StatusEffects/Berserk/B in src.StatusEffects)	damage+=round(damage*(B.AtkBoost/100))
	for(var/datum/StatusEffects/Berserk/B in M.StatusEffects)	damage+=round(damage*(B.DefDown/100))
	if(src.Shikai)	for(var/obj/Skills/Shikais/Shared/Blind_Strength/S in src.Skills)
		damage+=round(damage*(0.01+(((S.Level-1)/100)*1)))
	for(var/obj/Skills/SoulReaper/Combat_Mastery/S in src.Skills)
		damage+=round(damage*min(5,src.ComboCount-1)*S.Level*0.1)
	for(var/obj/Skills/SoulReaper/Spirit_Shell/S in M.Skills)
		damage-=round(damage*S.Level*0.05)
	return damage

mob/proc/MysticDamage(var/mob/M,var/damage=0)
	damage=max(0,damage-M.MGCDEF*1.5)//was mgc 1.5
	//damage=max(1,damage-M.MGCDEF*3)//was mgc 1.5
	for(var/obj/Skills/SoulReaper/Spirit_Shell/S in M.Skills)
		damage-=round(damage*S.Level*0.05)
	return damage