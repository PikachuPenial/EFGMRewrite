//	Modelname can be anything. I would reccomend to give every introcam the name of the map in either the mdl or the folder tree.
//	Example:	$modelname "custom/SwampFeverDrought/Introcam.mdl"
	$modelname "efgm/intros/intro_walk_lookback.mdl"	
	$model		cam	cam //Loads the actual model
	
//	Sequences	
	$sequence	ref	cam //Adds a static "Reference"  pose to the model
	$sequence	sequence	"anims/sequence" snap fps 60 //Your own animation name goes here.
	
//	FPS 60 and other stuff may be added aswell. Higher FPS gets a smoother camera movement,-
// 	but DO NOT forget to play back in 60 fps in blender aswell, otherwise your animation may just play twice as fast.

//	-------------------------------------------------------------------------------------------------------------------------------------------
//	Example of Swamp Fever:Drought's introcam sequences:
//	$sequence "INTRO1" 		anims/intro_new1 snap fps 60
//	$sequence "INTRO2" 		anims/intro_new2 snap fps 60
//	$sequence "INTRO3" 		anims/intro_new3 snap fps 60
//	$sequence "INTRO1_END" 	anims/intro_new1 frame 878 878 
//	$sequence "INTRO2_END" 	anims/intro_new2 frame 878 878
//	$sequence "INTRO3_END" 	anims/intro_new3 frame 878 878

//	"_end" is not required. It's just a helper in hammer to remember where the camera stops.
//	the "frame 878 878" part specifies the last frame of the sequence, which was 878 on my animations. but it could be anything.
//	If you don't want the helper, just delete the entire line.
//	-------------------------------------------------------------------------------------------------------------------------------------------
//	Don't touch any of these.
	$attachment		"cam" "cam" 0 0 0 rotate 0 0 0
	$cdmaterials	"editor\"
	$definebone		"Root_DoNotEdit"	""					-16 0 0 -0	 90 0 0 0 0 -0 0 0
	$definebone		"cam"				"Root_DoNotEdit"	0 -16 0 -0	-90 0 0 0 0 -0 0 0
//	-------------------------------------------------------------------------------------------------------------------------------------------

