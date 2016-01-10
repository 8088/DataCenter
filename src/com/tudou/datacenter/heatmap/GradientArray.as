﻿package com.tudou.datacenter.heatmap 
{
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    
    public class GradientArray
    {
        public static const THERMAL:Array = [0, 167772262, 336396403, 504430711, 672727155, 857605496, 1025311865, 1193542778, 1361445755, 1529480062, 1714226559, 1882326399, 2050229378, 2218264197, 2386232710, 2571044231, 2739013001, 2906982028, 3075081868, 3243050383, 3427796369, 3595765395, 3763734164, 3931768213, 4099736983, 4284614554, 4284745369, 4284876441, 4285007513, 4285138585, 4285334937, 4285466009, 4285597081, 4285728153, 4285924505, 4286055577, 4286186649, 4286317721, 4286514073, 4286645145, 4286776217, 4286907289, 4287103641, 4287234713, 4287365785, 4287496857, 4287693209, 4287824281, 4287955353, 4288086425, 4288283033, 4288348568, 4288414103, 4288545431, 4288610966, 4288742293, 4288807829, 4288938900, 4289004691, 4289135763, 4289201554, 4289332625, 4289398161, 4289529488, 4289595024, 4289726351, 4289791886, 4289922958, 4289988749, 4290119820, 4290185612, 4290316683, 4290382218, 4290513546, 4290579081, 4290710409, 4290776198, 4290841987, 4290907777, 4290973822, 4291039612, 4291105401, 4291171447, 4291237236, 4291303026, 4291369071, 4291434861, 4291500650, 4291566696, 4291632485, 4291698275, 4291764320, 4291830110, 4291895899, 4291961945, 4292027734, 4292093524, 4292159569, 4292225359, 4292291148, 4292422730, 4292422983, 4292489029, 4292489282, 4292555328, 4292621118, 4292621627, 4292687417, 4292753462, 4292753972, 4292819762, 4292885807, 4292886061, 4292952106, 4292952360, 4293018406, 4293084195, 4293084705, 4293150750, 4293216540, 4293217050, 4293282839, 4293348885, 4293349138, 4293415184, 4293481230, 4293481485, 4293481996, 4293547788, 4293548299, 4293614091, 4293614602, 4293614858, 4293680905, 4293681416, 4293747208, 4293747719, 4293747975, 4293814022, 4293814278, 4293880325, 4293880581, 4293881092, 4293947139, 4293947395, 4294013442, 4294013698, 4294014209, 4294080001, 4294080512, 4294146560, 4294146816, 4294147328, 4294213376, 4294213632, 4294214144, 4294280192, 4294280704, 4294280960, 4294347008, 4294347520, 4294347776, 4294413824, 4294414336, 4294480384, 4294480640, 4294481152, 4294547200, 4294547456, 4294547968, 4294614016, 4294614528, 4294614784, 4294680832, 4294681344, 4294747392, 4294747648, 4294747904, 4294748416, 4294748672, 4294749184, 4294749440, 4294749952, 4294750208, 4294750464, 4294750976, 4294751232, 4294751744, 4294752000, 4294752512, 4294752768, 4294753280, 4294753536, 4294753792, 4294754304, 4294754560, 4294755072, 4294755328, 4294755840, 4294756096, 4294756608, 4294756869, 4294757130, 4294757391, 4294757652, 4294757913, 4294758174, 4294758435, 4294758696, 4294758957, 4294759219, 4294759480, 4294759741, 4294760258, 4294760519, 4294760780, 4294761041, 4294826838, 4294827099, 4294827360, 4294827622, 4294827883, 4294828144, 4294828405, 4294828666, 4294829183, 4294829444, 4294829705, 4294829966, 4294830227, 4294830489, 4294830750, 4294831011, 4294831272, 4294897069, 4294897330, 4294897591, 4294897852, 4294898369, 4294898630, 4294898892, 4294899153, 4294899414, 4294899675, 4294899936, 4294900197, 4294900458, 4294900719, 4294900980, 4294901241, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295];
		
        public static const RAINBOW:Array = [0,167772415,335544575,503316726,671088889,855638261,1023410423,1191182584,1358954741,1526726902,1711276277,1879048438,2046820599,2214592757,2382364918,2566914293,2734686453,2902458614,3070230773,3238002934,3422552309,3590324469,3758096630,3925868788,4093640949,4278190326,4278191862,4278193398,4278195190,4278196726,4278198518,4278200054,4278201590,4278203382,4278204918,4278206710,4278208246,4278209782,4278211574,4278213110,4278214902,4278216438,4278217974,4278219766,4278221302,4278223094,4278224630,4278226166,4278227958,4278229494,4278296822,4278232053,4278232821,4278233588,4278234356,4278235124,4278235891,4278236659,4278237426,4278238194,4278238962,4278239729,4278240497,4278241264,4278242032,4278242800,4278243567,4278244335,4278245102,4278245870,4278246638,4278247405,4278248173,4278248940,4278249708,4278250732,4278250722,4278250969,4278251215,4278251462,4278251452,4278251699,4278251945,4278252192,4278252183,4278252429,4278252676,4278252922,4278252913,4278253159,4278253406,4278253652,4278253643,4278253890,4278254136,4278254383,4278254373,4278254620,4278254866,4278255113,4278255360,4278910720,4279566080,4280221440,4280876800,4281597696,4282253056,4282908416,4283563776,4284219136,4284940032,4285595392,4286250752,4286906112,4287561472,4288282368,4288937728,4289593088,4290248448,4290903808,4291624704,4292280064,4292935424,4293590784,4294246144,4294967040,4294900736,4294834432,4294768384,4294702080,4294636032,4294569728,4294503680,4294437376,4294371328,4294305024,4294238976,4294172672,4294106624,4294040320,4293974272,4293907968,4293841920,4293775616,4293709568,4293643264,4293577216,4293510912,4293444864,4293378560,4293378048,4293377536,4293442560,4293507584,4293572608,4293637632,4293702656,4293767680,4293832704,4293897728,4293962752,4294027776,4294092800,4294158080,4294223104,4294288128,4294353152,4294418176,4294483200,4294548224,4294613248,4294678272,4294743296,4294808320,4294873344,4294938624,4294937088,4294935552,4294934016,4294932480,4294931200,4294929664,4294928128,4294926592,4294925312,4294923776,4294922240,4294920704,4294919424,4294917888,4294916352,4294914816,4294913536,4294912000,4294910464,4294908928,4294907648,4294906112,4294904576,4294903040,4294901760,4294903045,4294904330,4294905615,4294906900,4294908185,4294909470,4294910755,4294912040,4294913325,4294914867,4294916152,4294917437,4294918722,4294920007,4294921292,4294922577,4294923862,4294925147,4294926432,4294927974,4294929259,4294930544,4294931829,4294933114,4294934399,4294935684,4294936969,4294938254,4294939539,4294941081,4294942366,4294943651,4294944936,4294946221,4294947506,4294948791,4294950076,4294951361,4294952646,4294954188,4294955473,4294956758,4294958043,4294959328,4294960613,4294961898,4294963183,4294964468,4294965753,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295];
        
        public static const BLUE_WHITE:Array = 
		[
		0, 50331903, 100663551, 167772415, 218104063, 285212927, 335544575, 385876223, 452985077, 503316726,
		570425591, 620757240, 671088889, 738197753, 788529401, 855638266, 905969914, 956301562, 1023410427, 1073742071,
		1140850935, 1191182584, 1241514232, 1308623096, 1358954744, 1426063609, 1476395257, 1526726905, 1593835770, 1644167418, 
		1711276282, 1761607930, 1811939578, 1879048440, 1929380090, 1996488954, 2046820603, 2097152251, 2164261113, 2214592761,
		2281701625, 2332033273, 2382364923, 2449473787, 2499805436, 2566914298, 2617245946, 2667577594, 2734686458, 2785018106,
		2852126972, 2902458620, 2952790267, 3019899132, 3070230780, 3137339644, 3187671292, 3238002939, 3305111803, 3355443452,
		3422552316, 3472883964, 3523215612, 3590324477, 3640656124, 3707764988, 3758096636, 3808428285, 3875537149, 3925868797,
		3992977662, 4043309309, 4093640957, 4160749822, 4211081470, 4278190335,
		
		4278191103, 4278191871, 4278192639, 4278193407, 4278194175, 4278194943, 4278195711, 4278196479, 4278197247, 4278198015, 4278198783, 4278199551, 4278200319, 4278201087, 4278201855, 4278202623, 4278203391, 4278204159, 4278204927, 4278205695, 4278206463, 4278207231, 4278207999, 4278208767, 4278209535, 4278210303, 4278211071, 4278211839, 4278212607, 4278213375, 4278214143, 4278214911, 4278215679, 4278216447, 4278217215, 4278217983, 4278218751, 4278219519, 4278220287, 4278221055, 4278221823, 4278222591, 4278223359, 4278224127, 4278224895, 4278225663, 4278226431, 4278227199, 4278227967, 4278228735, 4278229503, 4278230271, 4278231039, 4278231807, 4278232575, 4278233343, 4278234111, 4278234879, 4278235647, 4278236415, 4278237183, 4278237951, 4278238719, 4278239487, 4278240255, 4278241023, 4278241791, 4278242559, 4278243327, 4278244095, 4278244863, 4278245631, 4278246399,
		4278247167, 
		
		4278255615,
		
		4278452223,4278648831,4278845439,4279042047,4279238655,4279435263,4279631871,4279828479,4280025087,4280221695,4280418303,4280614911,4280811519,4281008127,4281204735,4281401343,4281597951,4281794559,4281991167,4282187775,4282384383,4282580991,4282777599,4282974207,4283170815,4283367423,4283564031,4283760639,4283957247,4284153855,4284350463,4284547071,4284743679,4284940287,4285136895,4285333503,4285530111,4285726719,4285923327,4286119935,4286316543,4286513151,4286709759,4286906367,4287102975,4287299583,4287496191,4287692799,4287889407,4288086015,4288282623,4288479231,4288675839,4288872447,4289069055,4289265663,4289462271,4289658879,4289855487,4290052095,4290248703,4290445311,4290641919,4290838527,4291035135,4291231743,4291428351,4291624959,4291821567,4292018175,4292214783,4292411391,4292607999,4292804607,

		4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295,
		4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295,
		4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295,
		4294967295
		];        
    }
	
}