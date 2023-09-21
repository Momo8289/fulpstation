/datum/action/cooldown/spell/shapeshift/werewolf_transform
	name = "Transform"
	desc = "Transform into werewolf form"
	button_icon_state = "power_human"
	spell_requirements = NONE
	shapeshift_type = /mob/living/carbon/human/werewolf
	possible_shapes = list(/mob/living/carbon/human/werewolf)
	var/show_to_player = TRUE
	var/datum/antagonist/werewolf/werewolf_datum
	cooldown_time = 2 SECONDS

/datum/action/cooldown/spell/shapeshift/werewolf_transform/New(datum/antagonist/werewolf/antag_datum)
	werewolf_datum = antag_datum
	return ..()

/datum/action/cooldown/spell/shapeshift/werewolf_transform/proc/enable_button()
	show_to_player = TRUE
	ShowTo(owner)

/datum/action/cooldown/spell/shapeshift/werewolf_transform/proc/disable_button()
	show_to_player = FALSE
	HideFrom(owner)

/datum/action/cooldown/spell/shapeshift/werewolf_transform/ShowTo(mob/viewer)
	if(!show_to_player)
		return
	return ..()

/datum/action/cooldown/spell/shapeshift/werewolf_transform/do_shapeshift(mob/living/caster)
	var/mob/living/shifted_mob = ..()
	werewolf_datum.werewolf_tackler = shifted_mob.AddComponent( \
		/datum/component/tackler/werewolf, \
		stamina_cost = WP_TACKLE_STAM_COST, \
		base_knockdown = WP_TACKLE_BASE_KNOCKDOWN, \
		range = WP_TACKLE_RANGE, \
		speed = WP_TACKLE_SPEED, \
		skill_mod = WP_TACKLE_SKILL_MOD, \
		min_distance = WP_TACKLE_MIN_DIST \
	)

	for(var/datum/action/cooldown/spell/power as anything in werewolf_datum.transformed_powers)
		power.Grant(shifted_mob)

	werewolf_datum.transformed = TRUE
	SEND_SIGNAL(shifted_mob, WEREWOLF_TRANSFORMED)
	return shifted_mob

/datum/action/cooldown/spell/shapeshift/werewolf_transform/do_unshapeshift(mob/living/caster)
	qdel(werewolf_datum.werewolf_tackler)

	for(var/datum/action/cooldown/spell/power as anything in werewolf_datum.transformed_powers)
		power.Remove(werewolf_datum.owner.current)

	werewolf_datum.transformed = FALSE
	SEND_SIGNAL(werewolf_datum.owner.current, WEREWOLF_REVERTED)
	return ..()
