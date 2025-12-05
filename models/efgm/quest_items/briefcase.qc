
$modelname "efgm\quest_items\briefcase.mdl"

$scale 2

$bodygroup "Body"
{
	studio "briefcase_ref.smd"
}

$surfaceprop "Plastic"

$cdmaterials "models\efgm\quest_items\"

$sequence idle	"briefcase_ref.smd"

$collisionmodel "briefcase_phys.smd"
{
	$mass 30
	$inertia 1
	$damping 0
	$rotdamping 0
	$rootbone " "

}