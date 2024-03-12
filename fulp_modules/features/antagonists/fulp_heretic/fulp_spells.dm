/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash/antagroll
	name = "Rolling of the Antagonist"
	desc = "A spell that allows you pass unimpeded through some walls. Might be short, might be long, the forces of the Roll are unpredictable."
	invocation = "I wanna antagroll"
	invocation_type = INVOCATION_SHOUT
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "jaunt"
	//I think they deserve to be notified when it ends. I wanted to do the waterphone but it's not in the files and I don't care that much.
	exit_jaunt_sound = 'sound/ambience/antag/thatshowfamiliesworks.ogg'

/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash/antagroll/before_cast(atom/cast_on)
	. = ..()

	jaunt_duration = rand(1 SECONDS, 15 SECONDS)

/datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash/antagroll/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(isspaceturf(get_turf(owner)) || ismiscturf(get_turf(owner)))
		return TRUE
	if(feedback)
		to_chat(owner, span_warning("You must stand on a space or misc turf!"))
	return FALSE


/datum/action/cooldown/spell/pointed/antagroll
	name = "Rolling of the Antagonist"
	desc = "Roll over, crushing anyone in your way."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'fulp_modules/features/antagonists/fulp_heretic/icons/spells.dmi'
	button_icon_state = "jaunt"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 5 SECONDS

	invocation = "I wanna antagroll"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE

	active_msg = span_notice("We prepare to roll.")
	deactive_msg = span_notice("One may not roll while the Moderators are watching...")

	var/rolling_speed = 0.25 SECONDS

/datum/action/cooldown/spell/pointed/antagroll/cast(atom/cast_on)
	. = ..()
	if (owner.body_position == LYING_DOWN || !isturf(owner.loc))
		return FALSE

	var/turf/target = get_turf(cast_on)
	if (isnull(target))
		return FALSE

	if (target == owner.loc)
		target.balloon_alert(owner, "can't roll on yourself!")
		return FALSE

	var/picked_dir = get_dir(owner, target)
	if (!picked_dir)
		return FALSE
	var/turf/temp_target = get_step(owner, picked_dir) // we can move during the timer so we cant just pass the ref

	new /obj/effect/temp_visual/telegraphing/vending_machine_tilt(temp_target, rolling_speed)
	owner.balloon_alert_to_viewers("rolling...")
	addtimer(CALLBACK(src, PROC_REF(do_roll_over), owner, picked_dir), rolling_speed)

/datum/action/cooldown/spell/pointed/antagroll/proc/do_roll_over(owner, picked_dir)
	if (owner.body_position == LYING_DOWN || !isturf(owner.loc))
		return

	var/turf/target = get_step(owner, picked_dir) // in case we moved we pass the dir not the target turf

	if (isnull(target))
		return

	return owner.fall_and_crush(target, 25, 10, null, 5 SECONDS, picked_dir, rotation = get_rotation_from_dir(picked_dir))


/datum/action/cooldown/spell/pointed/ascend_door
	name = "Awakening of Doors"
	desc = "A door is a hinged or otherwise movable barrier that allows ingress (entry) into and egress (exit) from an enclosure. The created opening in the wall is a doorway or portal. A door's essential and primary purpose is to provide security by controlling access to the doorway (portal). Conventionally, it is a panel that fits into the doorway of a building, room, or vehicle. Doors are generally made of a material suited to the door's task. They are commonly attached by hinges, but can move by other means, such as slides or counterbalancing."
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "ash_shift"

	school = SCHOOL_FORBIDDEN
	cooldown_time = 5 SECONDS

	invocation = "A'I OP'N"
	invocation_type = INVOCATION_WHISPER
	spell_requirements = NONE

/datum/action/cooldown/spell/pointed/ascend_door/is_valid_target(atom/cast_on)
	if(istype(cast_on,/obj/machinery/door))
		return TRUE
	to_chat(owner, span_warning("You may only cast [src] on a door!"))
	return FALSE
