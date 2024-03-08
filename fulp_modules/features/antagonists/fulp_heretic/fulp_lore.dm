/**
 * # The path of fulp.
 *
 * Goes as follows:
 *
 * Things
 */
#define PATH_FULP "Fulp Path"

/datum/heretic_knowledge/limited_amount/starting/base_beef
	name = "The Man of Beef"
	desc = "Opens up the Path of Fulp to you. \
		Allows you to transmute any meat and a knife into the beefblade. \
		You can only create two at a time. \
		You can not break it like you would a normal sickly blade, but anyone can take a bite out of it to teleport to a random location."
	gain_text = "I have met a peculiar man today, a man made of beef. He claimed to work his job at fulpstation, and promised to show me around."
	next_knowledge = list(/datum/heretic_knowledge/fulp_grasp)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/food/meat = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/beef)
	route = PATH_FULP


/datum/heretic_knowledge/fulp_grasp
	name = "Grasp of Bwoink"
	desc = "Your Mansus Grasp will now bwoink the victim."
	gain_text = "The Moderators rule the world of Fulp with their dark knowledge and mastery of the soul... \
		This is a little piece of their unimaginable power..."
	next_knowledge = list(/datum/heretic_knowledge/spell/antagroll)
	cost = 1
	route = PATH_FULP

/datum/heretic_knowledge/fulp_grasp/on_gain(mob/user, datum/antagonist/heretic/our_heretic)
	RegisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK, PROC_REF(on_mansus_grasp))

/datum/heretic_knowledge/fulp_grasp/on_lose(mob/user, datum/antagonist/heretic/our_heretic)
	UnregisterSignal(user, COMSIG_HERETIC_MANSUS_GRASP_ATTACK)

/datum/heretic_knowledge/fulp_grasp/proc/on_mansus_grasp(mob/living/source, mob/living/target)
	SIGNAL_HANDLER

	//the following line, including the comment, is copied from the banhammer code:
	playsound(target, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much


/datum/heretic_knowledge/spell/antagroll
	name = "Mentors' Basement"
	desc = "Grants you Rolling of the Antagonist, a spell that can only be cast in the vacuum of space. \
		It will render you immaterial and invisible for a random time, allowing you to bypass any obstacles."
	gain_text = "Madness of the Mentors knew no bounds. They searched for any way to escape the Basement, \
		even if that way was straight into the all-encompassing void."
	next_knowledge = list(
		/datum/heretic_knowledge/mark/beef_mark,
		/datum/heretic_knowledge/summon/fire_shark,
		/datum/heretic_knowledge/medallion,
	)
	spell_to_add = /datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash/antagroll
	cost = 1
	route = PATH_FULP


/datum/heretic_knowledge/mark/beef_mark
	name = "Mark of Beef"
	desc = "Your Mansus Grasp now applies the Mark of Beef. The mark is triggered from an attack with your Beefy Blade. \
		When triggered, the victim will themselves become a beefman."
	gain_text = "The Beefman has showed me the secrets to Fulpstation's all-natural top quality beef, \
		and the ways to conjure it into this plane."
	next_knowledge = list(/datum/heretic_knowledge/knowledge_ritual/fulp)
	route = PATH_FULP
	mark_type = /datum/status_effect/eldritch/beef


/datum/heretic_knowledge/knowledge_ritual/fulp
	next_knowledge = list(/datum/heretic_knowledge/spell/fire_blast)
	route = PATH_FULP

/datum/heretic_knowledge/knowledge_ritual/New()
	. = ..()

	required_atoms = list(/obj/item/food/meat = 3,
						/obj/item/melee/sickly_blade/beef = 2,
						)

/*
/datum/heretic_knowledge/spell/fire_blast
	name = "Volcano Blast"
	desc = "Grants you Volcano Blast, a spell that - after a short charge - fires off a beam of energy \
		at a nearby enemy, setting them on fire and burning them. If they do not extinguish themselves, \
		the beam will continue to another target."
	gain_text = "No fire was hot enough to rekindle them. No fire was bright enough to save them. No fire is eternal."
	next_knowledge = list(/datum/heretic_knowledge/mad_mask)
	spell_to_add = /datum/action/cooldown/spell/charged/beam/fire_blast
	cost = 1
	route = PATH_ASH


/datum/heretic_knowledge/mad_mask
	name = "Mask of Madness"
	desc = "Allows you to transmute any mask, four candles, a stun baton, and a liver to create a Mask of Madness. \
		The mask instills fear into heathens who witness it, causing stamina damage, hallucinations, and insanity. \
		It can also be forced onto a heathen, to make them unable to take it off..."
	gain_text = "The Nightwatcher was lost. That's what the Watch believed. Yet he walked the world, unnoticed by the masses."
	next_knowledge = list(
		/datum/heretic_knowledge/blade_upgrade/ash,
		/datum/heretic_knowledge/reroll_targets,
		/datum/heretic_knowledge/spell/space_phase,
		/datum/heretic_knowledge/curse/paralysis,
	)
	required_atoms = list(
		/obj/item/organ/internal/liver = 1,
		/obj/item/melee/baton/security = 1,  // Technically means a cattleprod is valid
		/obj/item/clothing/mask = 1,
		/obj/item/flashlight/flare/candle = 4,
	)
	result_atoms = list(/obj/item/clothing/mask/madness_mask)
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/blade_upgrade/ash
	name = "Fiery Blade"
	desc = "Your blade now lights enemies ablaze on attack."
	gain_text = "He returned, blade in hand, he swung and swung as the ash fell from the skies. \
		His city, the people he swore to watch... and watch he did, as they all burnt to cinders."
	next_knowledge = list(/datum/heretic_knowledge/spell/flame_birth)
	route = PATH_ASH

/datum/heretic_knowledge/blade_upgrade/ash/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target)
		return

	target.adjust_fire_stacks(1)
	target.ignite_mob()

/datum/heretic_knowledge/spell/flame_birth
	name = "Nightwatcher's Rebirth"
	desc = "Grants you Nightwatcher's Rebirth, a spell that extinguishes you and \
		burns all nearby heathens who are currently on fire, healing you for every victim afflicted. \
		If any victims afflicted are in critical condition, they will also instantly die."
	gain_text = "The fire was inescapable, and yet, life remained in his charred body. \
		The Nightwatcher was a particular man, always watching."
	next_knowledge = list(
		/datum/heretic_knowledge/ultimate/ash_final,
		/datum/heretic_knowledge/summon/ashy,
		/datum/heretic_knowledge/eldritch_coin,
	)
	spell_to_add = /datum/action/cooldown/spell/aoe/fiery_rebirth
	cost = 1
	route = PATH_ASH

/datum/heretic_knowledge/ultimate/ash_final
	name = "Ashlord's Rite"
	desc = "The ascension ritual of the Path of Ash. \
		Bring 3 burning or husked corpses to a transmutation rune to complete the ritual. \
		When completed, you become a harbinger of flames, gaining two abilites. \
		Cascade, which causes a massive, growing ring of fire around you, \
		and Oath of Flame, causing you to passively create a ring of flames as you walk. \
		You will also become immune to flames, space, and similar environmental hazards."
	gain_text = "The Watch is dead, the Nightwatcher burned with it. Yet his fire burns evermore, \
		for the Nightwatcher brought forth the rite to mankind! His gaze continues, as now I am one with the flames, \
		WITNESS MY ASCENSION, THE ASHY LANTERN BLAZES ONCE MORE!"
	route = PATH_ASH
	/// A static list of all traits we apply on ascension.
	var/static/list/traits_to_apply = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_NOFIRE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)

/datum/heretic_knowledge/ultimate/ash_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return

	if(sacrifice.on_fire)
		return TRUE
	if(HAS_TRAIT_FROM(sacrifice, TRAIT_HUSK, BURN))
		return TRUE
	return FALSE

/datum/heretic_knowledge/ultimate/ash_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	priority_announce(
		text = "[generate_heretic_text()] Fear the blaze, for the Ashlord, [user.real_name] has ascended! The flames shall consume all! [generate_heretic_text()]",
		title = "[generate_heretic_text()]",
		sound = ANNOUNCER_SPANOMALIES,
		color_override = "pink",
	)

	var/datum/action/cooldown/spell/fire_sworn/circle_spell = new(user.mind)
	circle_spell.Grant(user)

	var/datum/action/cooldown/spell/fire_cascade/big/screen_wide_fire_spell = new(user.mind)
	screen_wide_fire_spell.Grant(user)

	var/datum/action/cooldown/spell/charged/beam/fire_blast/existing_beam_spell = locate() in user.actions
	if(existing_beam_spell)
		existing_beam_spell.max_beam_bounces *= 2 // Double beams
		existing_beam_spell.beam_duration *= 0.66 // Faster beams
		existing_beam_spell.cooldown_time *= 0.66 // Lower cooldown

	var/datum/action/cooldown/spell/aoe/fiery_rebirth/fiery_rebirth = locate() in user.actions
	fiery_rebirth?.cooldown_time *= 0.16

	user.client?.give_award(/datum/award/achievement/misc/ash_ascension, user)
	if(length(traits_to_apply))
		user.add_traits(traits_to_apply, MAGIC_TRAIT)
*/
