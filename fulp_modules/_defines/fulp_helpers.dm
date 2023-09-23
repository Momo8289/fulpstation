///Whether a mob is a Bloodsucker
#define IS_BLOODSUCKER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/bloodsucker))
///Whether a mob is a Vassal
#define IS_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal))
///Whether a mob is a werewolf
#define IS_WEREWOLF(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/werewolf))
///Whether a mob is a Favorite Vassal
#define IS_FAVORITE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/favorite))
///Whether a mob is a Revenge Vassal
#define IS_REVENGE_VASSAL(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/vassal/revenge))
///Whether a mob is a Monster Hunter
#define IS_MONSTERHUNTER(mob) (mob?.mind?.has_antag_datum(/datum/antagonist/monsterhunter))

///Check if we are indeed a Beefman
#define isbeefman(A) (is_species(A, /datum/species/beefman))

/// Whether the given area has been claimed by a bloodsucker
/proc/is_bloodsucker_lair(potential_lair)
	for(var/datum/antagonist/bloodsucker/sucker in GLOB.antagonists)
		if(sucker.bloodsucker_lair_area == potential_lair)
			return sucker
	return FALSE

/// Whether the given area has been claimed by a werewolf
/proc/is_werewolf_den(potential_den)
	for(var/datum/antagonist/werewolf/wolf in GLOB.antagonists)
		if(wolf.werewolf_den_area == potential_den)
			return wolf
	return FALSE
