class Head{

int triangleNum = 383;
int headRandomSpawn = 1; // set to 0 for no random spawn effect

float headScale = 0.7;
float nodDistance = 0.5; // multiplier of distance moved by head nods, looks best at around 0.3 so far

float headWireframe = -1.5; // 2 for black borders, 0 for no borders, -2 for white borders.
float wireSize = 1; // stroke weight on the triangles
boolean headFill = true; // true for filled triangles, false for no fill

int headHue = 180; // Hue of the head, 147 is default

Head(int headRandomSpawn, float headScale,  float nodDistance, float headWireframe, float wireSize, boolean headFill, int headHue)
{
  this.headRandomSpawn = headRandomSpawn;
  this.headScale = headScale;
  this.nodDistance = nodDistance;
  this.headWireframe = headWireframe;
  this.wireSize = wireSize;
  this.headFill = headFill;
  this.headHue = headHue;
  
  
  initialiseTriangleOrder();// creates a shuffled intlist named triangleOrder, for use in randomising the spawning of head parts
  
}




float[][] TRI = {
/* TRI[0][X] point A */      {0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 177, 180, 183, 186, 189, 192, 195, 198, 201, 204, 207, 210, 213, 216, 219, 222, 225, 228, 231, 234, 237, 240, 243, 246, 249, 252, 255, 258, 261, 264, 267, 270, 273, 276, 279, 282, 285, 288, 291, 294, 297, 300, 303, 306, 309, 312, 315, 318, 321, 324, 327, 330, 333, 336, 339, 342, 345, 348, 351, 354, 357, 360, 363, 366, 369, 372, 375, 378, 381, 384, 387, 390, 393, 396, 399, 402, 405, 408, 411, 414, 417, 420, 423, 426, 429, 432, 435, 438, 441, 444, 447, 450, 453, 456, 459, 462, 465, 468, 471, 474, 477, 480, 483, 486, 489, 492, 495, 498, 501, 504, 507, 510, 513, 516, 519, 522, 525, 528, 531, 534, 537, 540, 543, 546, 549, 552, 555, 558, 561, 564, 567, 570, 573, 576, 579, 582, 585, 588, 591, 594, 597, 600, 603, 606, 609, 612, 615, 618, 621, 624, 627, 630, 633, 636, 639, 642, 645, 648, 651, 654, 657, 660, 663, 666, 669, 672, 675, 678, 681, 684, 687, 690, 693, 696, 699, 702, 705, 708, 711, 714, 717, 720, 723, 726, 729, 732, 735, 738, 741, 744, 747, 750, 753, 756, 759, 762, 765, 768, 771, 774, 777, 780, 783, 786, 789, 792, 795, 798, 801, 804, 807, 810, 813, 816, 819, 822, 825, 828, 831, 834, 837, 840, 843, 846, 849, 852, 855, 858, 861, 864, 867, 870, 873, 876, 879, 882, 885, 888, 891, 894, 897, 900, 903, 906, 909, 912, 915, 918, 921, 924, 927, 930, 933, 936, 939, 942, 945, 948, 951, 954, 957, 960, 963, 966, 969, 972, 975, 978, 981, 984, 987, 990, 993, 996, 999, 1002, 1005, 1008, 1011, 1014, 1017, 1020, 1023, 1026, 1029, 1032, 1035, 1038, 1041, 1044, 1047, 1050, 1053, 1056, 1059, 1062, 1065, 1068, 1071, 1074, 1077, 1080, 1083, 1086, 1089, 1092, 1095, 1098, 1101, 1104, 1107, 1110, 1113, 1116, 1119, 1122, 1125, 1128, 1131, 1134, 1137, 1140, 1143, 1146},

/* TRI[1][X] point B */      {1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85, 88, 91, 94, 97, 100, 103, 106, 109, 112, 115, 118, 121, 124, 127, 130, 133, 136, 139, 142, 145, 148, 151, 154, 157, 160, 163, 166, 169, 172, 175, 178, 181, 184, 187, 190, 193, 196, 199, 202, 205, 208, 211, 214, 217, 220, 223, 226, 229, 232, 235, 238, 241, 244, 247, 250, 253, 256, 259, 262, 265, 268, 271, 274, 277, 280, 283, 286, 289, 292, 295, 298, 301, 304, 307, 310, 313, 316, 319, 322, 325, 328, 331, 334, 337, 340, 343, 346, 349, 352, 355, 358, 361, 364, 367, 370, 373, 376, 379, 382, 385, 388, 391, 394, 397, 400, 403, 406, 409, 412, 415, 418, 421, 424, 427, 430, 433, 436, 439, 442, 445, 448, 451, 454, 457, 460, 463, 466, 469, 472, 475, 478, 481, 484, 487, 490, 493, 496, 499, 502, 505, 508, 511, 514, 517, 520, 523, 526, 529, 532, 535, 538, 541, 544, 547, 550, 553, 556, 559, 562, 565, 568, 571, 574, 577, 580, 583, 586, 589, 592, 595, 598, 601, 604, 607, 610, 613, 616, 619, 622, 625, 628, 631, 634, 637, 640, 643, 646, 649, 652, 655, 658, 661, 664, 667, 670, 673, 676, 679, 682, 685, 688, 691, 694, 697, 700, 703, 706, 709, 712, 715, 718, 721, 724, 727, 730, 733, 736, 739, 742, 745, 748, 751, 754, 757, 760, 763, 766, 769, 772, 775, 778, 781, 784, 787, 790, 793, 796, 799, 802, 805, 808, 811, 814, 817, 820, 823, 826, 829, 832, 835, 838, 841, 844, 847, 850, 853, 856, 859, 862, 865, 868, 871, 874, 877, 880, 883, 886, 889, 892, 895, 898, 901, 904, 907, 910, 913, 916, 919, 922, 925, 928, 931, 934, 937, 940, 943, 946, 949, 952, 955, 958, 961, 964, 967, 970, 973, 976, 979, 982, 985, 988, 991, 994, 997, 1000, 1003, 1006, 1009, 1012, 1015, 1018, 1021, 1024, 1027, 1030, 1033, 1036, 1039, 1042, 1045, 1048, 1051, 1054, 1057, 1060, 1063, 1066, 1069, 1072, 1075, 1078, 1081, 1084, 1087, 1090, 1093, 1096, 1099, 1102, 1105, 1108, 1111, 1114, 1117, 1120, 1123, 1126, 1129, 1132, 1135, 1138, 1141, 1144, 1147},

/* TRI[2][X] point C */      {2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 56, 59, 62, 65, 68, 71, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, 128, 131, 134, 137, 140, 143, 146, 149, 152, 155, 158, 161, 164, 167, 170, 173, 176, 179, 182, 185, 188, 191, 194, 197, 200, 203, 206, 209, 212, 215, 218, 221, 224, 227, 230, 233, 236, 239, 242, 245, 248, 251, 254, 257, 260, 263, 266, 269, 272, 275, 278, 281, 284, 287, 290, 293, 296, 299, 302, 305, 308, 311, 314, 317, 320, 323, 326, 329, 332, 335, 338, 341, 344, 347, 350, 353, 356, 359, 362, 365, 368, 371, 374, 377, 380, 383, 386, 389, 392, 395, 398, 401, 404, 407, 410, 413, 416, 419, 422, 425, 428, 431, 434, 437, 440, 443, 446, 449, 452, 455, 458, 461, 464, 467, 470, 473, 476, 479, 482, 485, 488, 491, 494, 497, 500, 503, 506, 509, 512, 515, 518, 521, 524, 527, 530, 533, 536, 539, 542, 545, 548, 551, 554, 557, 560, 563, 566, 569, 572, 575, 578, 581, 584, 587, 590, 593, 596, 599, 602, 605, 608, 611, 614, 617, 620, 623, 626, 629, 632, 635, 638, 641, 644, 647, 650, 653, 656, 659, 662, 665, 668, 671, 674, 677, 680, 683, 686, 689, 692, 695, 698, 701, 704, 707, 710, 713, 716, 719, 722, 725, 728, 731, 734, 737, 740, 743, 746, 749, 752, 755, 758, 761, 764, 767, 770, 773, 776, 779, 782, 785, 788, 791, 794, 797, 800, 803, 806, 809, 812, 815, 818, 821, 824, 827, 830, 833, 836, 839, 842, 845, 848, 851, 854, 857, 860, 863, 866, 869, 872, 875, 878, 881, 884, 887, 890, 893, 896, 899, 902, 905, 908, 911, 914, 917, 920, 923, 926, 929, 932, 935, 938, 941, 944, 947, 950, 953, 956, 959, 962, 965, 968, 971, 974, 977, 980, 983, 986, 989, 992, 995, 998, 1001, 1004, 1007, 1010, 1013, 1016, 1019, 1022, 1025, 1028, 1031, 1034, 1037, 1040, 1043, 1046, 1049, 1052, 1055, 1058, 1061, 1064, 1067, 1070, 1073, 1076, 1079, 1082, 1085, 1088, 1091, 1094, 1097, 1100, 1103, 1106, 1109, 1112, 1115, 1118, 1121, 1124, 1127, 1130, 1133, 1136, 1139, 1142, 1145, 1148},

/* TRI[3][X] Saturation */      {37, 37, 27, 27, 22, 54, 54, 27, 27, 22, 27, 27, 27, 27, 37, 100, 100, 27, 27, 22, 27, 27, 27, 22, 27, 22, 27, 27, 37, 54, 54, 100, 100, 99, 22, 27, 27, 22, 22, 27, 27, 37, 54, 54, 54, 54, 54, 100, 99, 27, 22, 27, 22, 37, 54, 100, 100, 100, 100, 100, 99, 99, 27, 37, 27, 27, 35, 22, 27, 22, 37, 54, 54, 54, 78, 71, 78, 71, 98, 100, 100, 100, 99, 99, 27, 30, 30, 30, 31, 34, 35, 20, 31, 20, 19, 38, 38, 27, 38, 38, 38, 38, 38, 36, 38, 36, 38, 54, 50, 19, 19, 85, 85, 35, 19, 19, 19, 19, 47, 54, 36, 49, 19, 30, 35, 85, 52, 65, 100, 95, 78, 88, 78, 78, 98, 98, 100, 100, 89, 100, 100, 100, 100, 100, 100, 99, 95, 95, 86, 86, 86, 95, 86, 95, 86, 95, 100, 89, 100, 86, 95, 86, 99, 38, 35, 31, 35, 100, 95, 100, 99, 100, 100, 100, 67, 100, 67, 67, 67, 35, 35, 38, 19, 27, 37, 27, 21, 19, 35, 35, 35, 21, 35, 18, 52, 54, 65, 98, 100, 100, 35, 52, 54, 65, 52, 65, 25, 25, 33, 54, 54, 54, 65, 98, 54, 65, 100, 85, 88, 89, 100, 54, 25, 100, 100, 100, 99, 99, 35, 35, 35, 35, 35, 38, 33, 39, 39, 33, 39, 39, 39, 39, 39, 21, 21, 108, 108, 27, 39, 21, 21, 46, 46, 46, 53, 53, 53, 53, 53, 53, 53, 88, 88, 73, 73, 54, 54, 73, 30, 73, 53, 88, 73, 86, 88, 100, 100, 100, 100, 100, 99, 99, 67, 35, 35, 38, 38, 38, 39, 39, 39, 39, 39, 53, 46, 46, 53, 53, 53, 88, 88, 53, 53, 100, 100, 100, 100, 100, 99, 99, 99, 99, 67, 57, 35, 35, 35, 57, 57, 57, 65, 100, 65, 54, 100, 100, 100, 100, 100, 57, 74, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 57, 74, 57, 74, 100, 100, 100, 74, 100, 100, 100, 100, 108, 108, 108, 108, 108, 108, 108, 108, 108, 100, 71, 71, 37, 78, 100, 100, 27, 25, 54, 47, 100, 95},

/* TRI[4][X] Brightness */      {61, 61, 93, 93, 100, 38, 38, 93, 93, 100, 93, 93, 93, 93, 61, 22, 22, 93, 93, 100, 93, 93, 93, 100, 93, 100, 93, 93, 61, 38, 38, 22, 22, 31, 100, 93, 93, 100, 100, 93, 93, 61, 38, 38, 38, 38, 38, 22, 31, 93, 100, 93, 100, 61, 38, 22, 22, 22, 22, 22, 31, 31, 93, 61, 63, 93, 69, 100, 93, 100, 61, 38, 38, 38, 31, 38, 31, 38, 23, 22, 22, 22, 31, 31, 93, 46, 46, 46, 81, 67, 67, 100, 73, 100, 100, 58, 58, 93, 58, 58, 58, 58, 58, 40, 58, 40, 58, 38, 50, 100, 100, 24, 24, 69, 100, 100, 100, 100, 43, 35, 87, 54, 100, 99, 89, 24, 47, 25, 16, 22, 32, 26, 32, 32, 32, 23, 22, 16, 18, 22, 22, 22, 22, 22, 22, 31, 32, 32, 35, 35, 35, 32, 35, 32, 35, 32, 22, 35, 22, 35, 32, 35, 31, 58, 89, 74, 69, 22, 32, 22, 31, 22, 22, 22, 22, 22, 22, 22, 22, 49, 49, 62, 100, 93, 59, 93, 99, 100, 89, 89, 89, 99, 89, 98, 47, 33, 25, 16, 16, 16, 89, 47, 33, 25, 47, 25, 100, 100, 92, 33, 33, 33, 25, 16, 33, 25, 16, 18, 13, 18, 22, 33, 100, 22, 22, 22, 31, 31, 49, 49, 49, 49, 49, 62, 81, 45, 45, 92, 92, 45, 45, 45, 45, 100, 100, 108, 108, 93, 45, 100, 100, 36, 36, 36, 23, 23, 23, 23, 23, 23, 23, 13, 13, 18, 18, 33, 33, 18, 46, 18, 23, 13, 18, 13, 13, 18, 22, 22, 22, 22, 31, 31, 22, 49, 49, 62, 62, 62, 45, 45, 45, 45, 45, 23, 36, 36, 23, 23, 23, 13, 13, 23, 23, 18, 18, 18, 22, 22, 31, 31, 31, 31, 22, 46, 69, 69, 69, 46, 46, 46, 25, 24, 25, 38, 24, 24, 24, 24, 24, 46, 40, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 108, 46, 40, 46, 40, 24, 22, 24, 40, 24, 24, 24, 24, 108, 108, 108, 108, 108, 108, 108, 108, 108, 24, 38, 38, 61, 31, 22, 22, 93, 67, 38, 43, 16, 22}

};

float[][] PT ={
/* R = 0   X */              {712, 738, 813, 712, 593, 738, 593, 465, 550, 593, 550, 628, 593, 738, 628, 813, 738, 860, 813, 860, 940, 465, 376, 446, 465, 446, 520, 465, 520, 550, 550, 628, 647, 628, 647, 738, 738, 647, 733, 738, 733, 776, 738, 776, 860, 860, 940, 931, 940, 931, 1040, 376, 283, 345, 376, 446, 345, 446, 345, 428, 446, 478, 428, 446, 520, 478, 520, 478, 597, 478, 428, 597, 550, 520, 597, 550, 597, 647, 647, 597, 733, 776, 733, 860, 860, 733, 901, 860, 931, 901, 931, 901, 968, 931, 1040, 968, 1040, 968, 1073, 1040, 1073, 1132, 283, 287, 368, 283, 345, 368, 345, 428, 368, 428, 368, 481, 428, 597, 481, 597, 481, 582, 597, 733, 582, 733, 582, 706, 733, 706, 836, 733, 858, 836, 733, 901, 858, 901, 858, 1020, 901, 968, 1073, 901, 1073, 1020, 1073, 1020, 1132, 283, 249, 368, 287, 368, 358, 368, 481, 392, 481, 392, 457, 481, 457, 582, 858, 836, 920, 858, 920, 956, 858, 956, 1020, 1020, 956, 965, 1020, 965, 1036, 1020, 1036, 1116, 1020, 1132, 1116, 1132, 1116, 1148, 249, 287, 292, 287, 292, 358, 368, 358, 392, 249, 292, 263, 358, 292, 405, 358, 392, 405, 392, 405, 460, 392, 457, 460, 457, 565, 460, 582, 706, 565, 706, 565, 692, 706, 836, 692, 692, 836, 826, 836, 881, 826, 836, 965, 881, 965, 936, 881, 965, 936, 1001, 965, 1036, 1001, 1077, 1001, 1036, 1036, 1077, 1116, 1116, 1077, 1131, 1116, 1148, 1131, 249, 241, 263, 205, 241, 240, 205, 240, 196, 196, 202, 181, 181, 202, 183, 202, 183, 205, 183, 205, 221, 183, 187, 221, 205, 240, 237, 187, 221, 202, 237, 256, 240, 221, 237, 238, 221, 202, 238, 240, 256, 263, 237, 256, 238, 202, 238, 211, 211, 256, 238, 211, 256, 255, 211, 233, 255, 233, 255, 263, 256, 255, 287, 255, 263, 287, 256, 263, 287, 565, 518, 592, 565, 592, 692, 592, 681, 587, 592, 692, 681, 692, 681, 726, 692, 726, 826, 263, 320, 292, 292, 370, 320, 370, 320, 356, 370, 356, 446, 446, 356, 526, 446, 526, 498, 498, 587, 552, 552, 587, 526, 552, 587, 587, 587, 681, 587, 587, 681, 588, 681, 588, 662, 681, 726, 662, 726, 662, 703, 726, 703, 742, 726, 805, 841, 726, 838, 841, 838, 875, 841, 875, 841, 946, 875, 902, 946, 926, 902, 946, 926, 972, 946, 972, 991, 946, 991, 946, 1067, 841, 805, 845, 841, 845, 946, 946, 1067, 1007, 991, 1010, 1067, 1010, 1077, 1067, 1077, 1131, 1067, 1131, 1067, 1100, 1067, 1100, 1007, 1100, 1131, 1098, 1148, 1131, 1156, 1156, 1182, 1195, 1182, 1195, 1223, 1182, 1223, 1203, 1203, 1223, 1218, 1182, 1203, 1148, 1203, 1218, 1197, 1156, 1182, 1148, 1197, 1218, 1208, 1131, 1156, 1148, 1148, 1203, 1146, 1197, 1183, 1208, 1197, 1183, 1146, 1183, 1208, 1173, 1131, 1148, 1146, 1173, 1183, 1146, 1131, 1098, 1112, 263, 287, 300, 526, 586, 597, 202, 205, 240, 292, 405, 370, 1208, 1173, 1186, 1173, 1146, 1162, 1173, 1162, 1186, 1131, 1112, 1146, 1146, 1162, 1160, 1162, 1186, 1160, 1146, 1132, 1160, 1186, 1160, 1165, 1146, 1132, 1112, 1160, 1165, 1137, 1132, 1160, 1137, 1132, 1137, 1112, 263, 320, 300, 320, 300, 367, 320, 362, 367, 320, 356, 362, 356, 362, 526, 362, 367, 428, 362, 428, 492, 362, 526, 492, 526, 587, 573, 587, 573, 588, 573, 526, 586, 526, 597, 595, 526, 492, 595, 573, 588, 586, 588, 662, 681, 662, 703, 681, 703, 681, 717, 703, 742, 717, 742, 717, 808, 742, 805, 808, 805, 808, 845, 588, 681, 586, 681, 586, 696, 681, 717, 696, 717, 808, 696, 586, 597, 696, 696, 702, 808, 597, 702, 668, 597, 668, 595, 668, 595, 636, 668, 636, 700, 668, 738, 700, 702, 668, 738, 702, 738, 792, 702, 792, 808, 738, 700, 753, 738, 792, 753, 808, 845, 792, 845, 946, 792, 792, 753, 847, 792, 946, 847, 946, 847, 1007, 697, 652, 695, 597, 696, 702, 1007, 847, 926, 1007, 926, 1023, 1007, 1100, 1023, 1100, 1023, 1098, 1098, 1023, 1058, 300, 367, 397, 300, 380, 397, 367, 397, 412, 367, 428, 412, 428, 412, 477, 428, 481, 477, 428, 492, 481, 492, 553, 481, 492, 575, 553, 492, 595, 575, 595, 575, 636, 636, 575, 697, 575, 652, 697, 575, 553, 592, 575, 592, 652, 553, 592, 621, 592, 621, 652, -1125, -1125, -1125, -1125, -1125, -1125, 553, 481, 618, 481, 618, 640, 553, 621, 618, 652, 621, 618, 652, 618, 695, 695, 618, 700, 618, 700, 640, 700, 640, 785, 700, 768, 785, 695, 700, 768, 695, 746, 768, 695, 765, 746, 765, 746, 766, 746, 768, 766, 766, 836, 768, 765, 836, 766, 697, 695, 765, 697, 753, 765, 700, 697, 753, 636, 700, 697, 753, 847, 765, 196, 202, 240, 765, 847, 836, 768, 836, 785, 836, 785, 871, 847, 836, 871, 847, 926, 871, 871, 926, 785, 926, 785, 897, 926, 957, 897, 926, 1023, 957, 897, 957, 973, 957, 1023, 973, 973, 1023, 1020, 1023, 1058, 1020, 1058, 1020, 1041, 380, 397, 420, 397, 412, 420, 412, 420, 535, 412, 477, 535, 420, 535, 505, 481, 477, 561, 477, 561, 535, 505, 535, 583, 481, 561, 640, 561, 535, 583, 561, 640, 743, 561, 743, 583, 743, 583, 695, 583, 695, 692, 640, 785, 743, 743, 695, 801, 695, 801, 692, 801, 692, 870, 743, 801, 825, 785, 743, 825, 801, 870, 825, 785, 825, 900, 785, 897, 900, 825, 900, 870, 897, 973, 900, 900, 870, 921, 900, 973, 921, 973, 921, 976, 973, 1020, 976, 976, 1020, 1041, 370, 405, 431, 370, 446, 431, 405, 460, 431, 460, 431, 472, 431, 472, 473, 431, 446, 473, 460, 518, 472, 472, 518, 525, 472, 525, 527, 472, 527, 473, 446, 473, 498, 473, 527, 498, 518, 592, 525, 525, 527, 592, 527, 587, 592, 527, 498, 587, 826, 881, 876, 876, 875, 902, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, 826, 838, 876, 838, 876, 875, 876, 928, 902, 876, 911, 928, 881, 876, 911, 881, 936, 911, 936, 911, 942, 911, 942, 928, 942, 928, 991, 928, 991, 972, 928, 902, 926, 928, 926, 972, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, -1125, 942, 1010, 991, 942, 1001, 1010, 936, 942, 1001, 457, 582, 565, 836, 920, 965, 920, 956, 965, 1001, 1077, 1010, 241, 240, 263, 205, 221, 237, 565, 460, 518, 498, 552, 526, 726, 742, 805, 726, 826, 838},

/* R = 1   X */              {40, 67, 47, 40, 53, 67, 53, 82, 102, 53, 102, 100, 53, 67, 100, 47, 67, 87, 47, 87, 91, 82, 140, 135, 82, 135, 135, 82, 135, 102, 102, 100, 151, 100, 151, 67, 67, 151, 211, 67, 211, 111, 67, 111, 87, 87, 91, 127, 91, 127, 156, 140, 255, 227, 140, 135, 227, 135, 227, 232, 135, 158, 232, 135, 135, 158, 135, 158, 235, 158, 232, 235, 102, 135, 235, 102, 235, 151, 151, 235, 211, 111, 211, 87, 87, 211, 205, 87, 127, 205, 127, 205, 197, 127, 156, 197, 156, 197, 261, 156, 261, 306, 255, 340, 283, 255, 227, 283, 227, 232, 283, 232, 283, 282, 232, 235, 282, 235, 282, 367, 235, 211, 367, 211, 367, 355, 211, 355, 423, 211, 286, 423, 211, 205, 286, 205, 286, 308, 205, 197, 261, 205, 261, 308, 261, 308, 306, 255, 370, 283, 340, 283, 446, 283, 282, 431, 282, 431, 412, 282, 412, 367, 286, 423, 382, 286, 382, 376, 286, 376, 308, 308, 376, 427, 308, 427, 452, 308, 452, 355, 308, 306, 355, 306, 355, 433, 370, 340, 525, 340, 525, 446, 283, 446, 431, 370, 525, 727, 446, 525, 525, 446, 431, 525, 431, 525, 516, 431, 412, 516, 412, 436, 516, 367, 355, 436, 355, 436, 522, 355, 423, 522, 522, 423, 567, 423, 533, 567, 423, 427, 533, 427, 512, 533, 427, 512, 532, 427, 452, 532, 561, 532, 452, 452, 561, 355, 355, 561, 678, 355, 433, 678, 370, 577, 727, 516, 577, 626, 516, 626, 530, 530, 588, 550, 550, 588, 612, 588, 612, 616, 612, 616, 687, 612, 670, 687, 616, 626, 727, 670, 687, 751, 727, 793, 626, 687, 727, 776, 687, 751, 776, 626, 793, 727, 727, 793, 776, 751, 776, 827, 827, 793, 776, 827, 793, 848, 827, 878, 848, 878, 848, 883, 793, 848, 908, 848, 883, 908, 793, 727, 908, 436, 516, 567, 436, 567, 522, 567, 580, 596, 567, 522, 580, 522, 580, 570, 522, 570, 567, 727, 728, 525, 525, 581, 728, 581, 728, 706, 581, 706, 605, 605, 706, 886, 605, 886, 617, 617, 596, 638, 638, 667, 886, 638, 667, 596, 596, 580, 667, 667, 580, 816, 580, 816, 782, 580, 570, 782, 570, 782, 788, 570, 788, 781, 570, 810, 712, 570, 592, 712, 592, 602, 712, 602, 712, 806, 602, 607, 806, 610, 607, 806, 610, 596, 806, 596, 581, 806, 581, 806, 708, 712, 810, 841, 712, 841, 806, 806, 708, 887, 581, 573, 708, 573, 561, 708, 561, 678, 708, 678, 708, 775, 708, 775, 887, 775, 678, 957, 433, 678, 578, 578, 547, 521, 547, 521, 535, 547, 535, 560, 560, 535, 585, 547, 560, 642, 560, 585, 596, 578, 547, 642, 596, 585, 645, 678, 578, 642, 642, 560, 786, 596, 656, 645, 596, 656, 786, 656, 645, 708, 678, 642, 786, 708, 656, 786, 678, 957, 925, 727, 908, 980, 886, 846, 892, 588, 616, 626, 525, 525, 581, 645, 708, 822, 708, 786, 796, 708, 796, 822, 678, 925, 786, 786, 796, 866, 796, 822, 866, 786, 871, 866, 822, 866, 883, 786, 871, 925, 866, 883, 886, 871, 866, 886, 871, 886, 925, 727, 728, 980, 728, 980, 1026, 728, 820, 1026, 728, 706, 820, 706, 820, 886, 820, 1026, 1075, 820, 1075, 1052, 820, 886, 1052, 886, 667, 805, 667, 805, 816, 805, 886, 846, 886, 892, 993, 886, 1052, 993, 805, 816, 846, 816, 782, 825, 782, 788, 825, 788, 825, 823, 788, 781, 823, 781, 823, 851, 781, 810, 851, 810, 851, 841, 816, 825, 846, 825, 846, 862, 825, 823, 862, 823, 851, 862, 846, 892, 862, 862, 878, 851, 892, 878, 923, 892, 923, 993, 923, 993, 1008, 923, 1008, 996, 923, 903, 996, 878, 923, 903, 878, 903, 895, 878, 895, 851, 903, 996, 997, 903, 895, 997, 851, 841, 895, 841, 806, 895, 895, 997, 1027, 895, 806, 1027, 806, 1027, 887, 1025, 1050, 1052, 892, 862, 878, 887, 1027, 1087, 887, 1087, 1050, 887, 775, 1050, 775, 1050, 957, 957, 1050, 1078, 980, 1026, 1156, 980, 1150, 1156, 1026, 1156, 1143, 1026, 1075, 1143, 1075, 1143, 1160, 1075, 1127, 1160, 1075, 1052, 1127, 1052, 1062, 1127, 1052, 1033, 1062, 1052, 993, 1033, 993, 1033, 1008, 1008, 1033, 1025, 1033, 1050, 1025, 1033, 1062, 1055, 1033, 1055, 1050, 1062, 1055, 1063, 1055, 1063, 1050, -625, -625, -625, -625, -625, -625, 1062, 1127, 1100, 1127, 1100, 1147, 1062, 1063, 1100, 1050, 1063, 1100, 1050, 1100, 1052, 1052, 1100, 1103, 1100, 1103, 1147, 1103, 1147, 1146, 1103, 1091, 1146, 1052, 1103, 1091, 1052, 1061, 1091, 1052, 1051, 1061, 1051, 1061, 1065, 1061, 1091, 1065, 1065, 1068, 1091, 1051, 1068, 1065, 1025, 1052, 1051, 1025, 997, 1051, 996, 1025, 997, 1008, 996, 1025, 997, 1027, 1051, 530, 588, 626, 1051, 1027, 1068, 1091, 1068, 1146, 1068, 1146, 1078, 1027, 1068, 1078, 1027, 1087, 1078, 1078, 1087, 1146, 1087, 1146, 1147, 1087, 1116, 1147, 1087, 1050, 1116, 1147, 1116, 1153, 1116, 1050, 1153, 1153, 1050, 1131, 1050, 1078, 1131, 1078, 1131, 1135, 1150, 1156, 1190, 1156, 1143, 1190, 1143, 1190, 1218, 1143, 1160, 1218, 1190, 1218, 1261, 1127, 1160, 1170, 1160, 1170, 1218, 1261, 1218, 1306, 1127, 1170, 1147, 1170, 1218, 1306, 1170, 1147, 1176, 1170, 1176, 1306, 1176, 1306, 1295, 1306, 1295, 1335, 1147, 1146, 1176, 1176, 1295, 1280, 1295, 1280, 1335, 1280, 1335, 1295, 1176, 1280, 1227, 1146, 1176, 1227, 1280, 1295, 1227, 1146, 1227, 1243, 1146, 1147, 1243, 1227, 1243, 1295, 1147, 1153, 1243, 1243, 1295, 1251, 1243, 1153, 1251, 1153, 1251, 1212, 1153, 1131, 1212, 1212, 1131, 1135, 581, 525, 558, 581, 605, 558, 525, 516, 558, 516, 558, 538, 558, 538, 593, 558, 605, 593, 516, 516, 538, 538, 516, 553, 538, 553, 587, 538, 587, 593, 605, 593, 617, 593, 587, 617, 516, 567, 553, 553, 587, 567, 587, 596, 567, 587, 617, 596, 567, 533, 543, 543, 602, 607, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, 567, 592, 543, 592, 543, 602, 543, 576, 607, 543, 530, 576, 533, 543, 530, 533, 512, 530, 512, 530, 528, 530, 528, 576, 528, 576, 581, 576, 581, 596, 576, 607, 610, 576, 610, 596, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, -625, 528, 573, 581, 528, 532, 573, 512, 528, 532, 412, 367, 436, 423, 382, 427, 382, 376, 427, 532, 561, 573, 577, 626, 727, 616, 687, 727, 436, 516, 516, 617, 638, 886, 570, 781, 810, 570, 567, 592},

/* R = 2   X */              {13, 12, 13, 13, 13, 12, 13, 13, 11, 13, 11, 12, 13, 12, 12, 13, 12, 11, 13, 11, 13, 13, 13, 11, 13, 11, 11, 13, 11, 11, 11, 12, 11, 12, 11, 12, 12, 11, 8, 12, 8, 11, 12, 11, 11, 11, 13, 11, 13, 11, 13, 13, 13, 11, 13, 11, 11, 11, 11, 8, 11, 11, 8, 11, 11, 11, 11, 11, 8, 11, 8, 8, 11, 11, 8, 11, 8, 11, 11, 8, 8, 11, 8, 11, 11, 8, 8, 11, 11, 8, 11, 8, 8, 11, 13, 8, 13, 8, 11, 13, 11, 13, 13, 11, 6, 13, 11, 6, 11, 8, 6, 8, 6, 6, 8, 8, 6, 8, 6, 4, 8, 8, 4, 8, 4, 4, 8, 4, 4, 8, 6, 4, 8, 8, 6, 8, 6, 6, 8, 8, 11, 8, 11, 6, 11, 6, 13, 13, 13, 6, 11, 6, 4, 6, 6, 4, 6, 4, 4, 6, 4, 4, 6, 4, 4, 6, 4, 4, 6, 4, 6, 6, 4, 4, 6, 4, 4, 6, 4, 11, 6, 13, 11, 13, 11, 13, 13, 11, 9, 11, 9, 4, 6, 4, 4, 13, 9, 11, 4, 9, 5, 4, 4, 5, 4, 5, 5, 4, 4, 5, 4, 3, 5, 4, 4, 3, 4, 3, 3, 4, 4, 3, 3, 4, 4, 4, 5, 4, 4, 4, 5, 4, 5, 5, 4, 5, 5, 4, 4, 5, 9, 5, 4, 4, 9, 11, 11, 9, 11, 11, 13, 11, 13, 13, 11, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 11, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 7, 13, 13, 7, 13, 11, 7, 3, 5, 4, 3, 4, 3, 4, 3, 4, 4, 3, 3, 3, 3, 3, 3, 3, 4, 11, 7, 9, 9, 5, 7, 5, 7, 7, 5, 7, 5, 5, 7, 4, 5, 4, 5, 5, 4, 5, 5, 4, 4, 5, 4, 4, 4, 3, 4, 4, 3, 1, 3, 1, 1, 3, 3, 1, 3, 1, 0, 3, 0, 0, 3, 1, 4, 3, 5, 4, 5, 5, 4, 5, 4, 7, 5, 5, 7, 5, 5, 7, 5, 5, 7, 5, 5, 7, 5, 7, 9, 4, 1, 3, 4, 3, 7, 7, 9, 7, 5, 5, 9, 5, 9, 9, 9, 11, 9, 11, 9, 9, 9, 9, 7, 9, 11, 7, 13, 11, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 11, 13, 13, 13, 13, 11, 13, 13, 13, 13, 13, 11, 13, 13, 13, 11, 13, 11, 13, 13, 11, 11, 7, 7, 11, 7, 7, 4, 1, 2, 13, 13, 13, 9, 5, 5, 13, 13, 13, 13, 11, 13, 13, 13, 13, 11, 7, 11, 11, 13, 13, 13, 13, 13, 11, 13, 13, 13, 13, 13, 11, 13, 7, 13, 13, 13, 13, 13, 13, 13, 13, 7, 11, 7, 7, 7, 7, 5, 7, 9, 5, 7, 7, 9, 7, 9, 4, 9, 5, 1, 9, 1, 1, 9, 4, 1, 4, 4, 3, 4, 3, 1, 3, 4, 1, 4, 2, 1, 4, 1, 1, 3, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 3, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 2, 0, 0, 0, 1, 2, 0, 2, 2, 2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 0, 2, 2, 0, 2, 2, 0, 2, 1, 2, 1, 1, 2, 2, 1, 1, 3, 2, 3, 7, 2, 2, 1, 2, 2, 7, 2, 7, 2, 7, 1, 1, 1, 2, 0, 0, 7, 2, 4, 7, 4, 4, 7, 9, 4, 9, 4, 7, 7, 4, 5, 7, 5, 5, 7, 5, 5, 5, 5, 4, 5, 1, 4, 1, 4, 4, 1, 4, 4, 1, 1, 4, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 4, 1, 4, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 3, 3, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 13, 13, 13, 1, 2, 2, 1, 2, 3, 2, 3, 3, 2, 2, 3, 2, 4, 3, 3, 4, 3, 4, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 4, 5, 5, 5, 5, 5, 5, 5, 3, 5, 4, 3, 4, 3, 2, 4, 4, 2, 3, 2, 3, 4, 4, 3, 4, 3, 2, 3, 2, 3, 4, 3, 3, 3, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 3, 3, 2, 3, 3, 2, 3, 2, 4, 3, 4, 4, 2, 4, 3, 4, 4, 4, 4, 3, 3, 4, 4, 3, 4, 3, 3, 4, 5, 3, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 4, 5, 4, 4, 5, 5, 4, 4, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 3, 4, 4, 4, 4, 4, 4, 5, 9, 5, 13, 13, 11, 13, 13, 13, 3, 5, 5, 5, 5, 4, 3, 0, 1, 3, 4, 5}

};
  
  
  
  // when referencing these matrices it should work like this, for a B value of point A of triangle I:     PT[ R ][ int( TRI[ A ][ I ] ) ]
  //where b is between 0 and 2 (0 for x value, 1 for y value and 2 for z value)
  //and A is between 0 and 2, one value for each vertice

float aY = 0;
float bY = 0;
float cY = 0;
float aX = 0;
float bX = 0;
float cX = 0; // these are used in drawing the triangles
int zoomPoint = 1080; //This is the index of one of the center eye points
// zoom on 1143, 461, 5.
// screen scale was 1536,864.
  
IntList triangleOrder;
 // this is used as a replacement for I once I is used to find the order of the triangles --------------------------------------------------------------------------------------------------
int triangleCount = 0;

boolean isHeadComplete = false;

float eyeZoom = 0; // amount the eye has zoomed in
boolean zoomIn = false; // is the camera zooming into the eye


void render(){

        drawTriangles(450,  50,  abs(beatTimer - beatTimeMin/2)*2  ); // draws the head based on the settings given
        if(isHeadComplete == true){playMusic();}
        
        if(ap.position() > 8200){colourRandomiser = true;} // starts randomizing colour
        if(ap.position() > 21400 && zoomIn == false){zoomIn = true; eyeZoom = -0.001;} // zooms in at given time

}


void drawTriangles(float headX, float headY, float Nod){// -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - -  -  -  -  -  -  -  -  -  -  -  - start of void

  if(isBeat == true && colourRandomiser == true){headHue = int(random(0,255));} // this randomizes the colour of the head, if the value is true
  
  strokeWeight(wireSize);      
  if(headRandomSpawn == 0){triangleCount = TRI[0].length;} // decides if the number of present triangles starts at zero or maximum
  
  
  
  for(int I = 0; I<triangleCount; I++){ // start of for loop ---------------------------------------------
    
    int O = triangleOrder.get(I); // uses the shuffled order in spawning the triangles in
    
    fill(headHue// + random(-25,25)
    ,TRI[3][O]*2.5,  TRI[4][O] *(2.5) );  // fills the triangles
    
    if(headFill == false){noFill();}  
    stroke(headHue,  TRI[3][O]*2.5,  TRI[4][O] *(1+(1.5*(1-headWireframe))) );  // decides colours and strokes, wireframe is changed on main page

    aY = ( PT[1][int(TRI[0][O])]  -  (12 - PT[2][int(TRI[0][O])] ) * (Nod * nodDistance) )  * headScale + headY ; // sets the Y value, then adds (13 - Zlayer) * (beat based variable * nod distance)
    bY = ( PT[1][int(TRI[1][O])]  -  (12 - PT[2][int(TRI[1][O])] ) * (Nod * nodDistance) )  * headScale + headY ; // nod distance is changed at the start of main page for  customisability.
    cY = ( PT[1][int(TRI[2][O])]  -  (12 - PT[2][int(TRI[2][O])] ) * (Nod * nodDistance) )  * headScale + headY ;
    
    aX =  PT[0][int(TRI[0][O])]   * headScale + headX; // x values of the triangle points
    bX =  PT[0][int(TRI[1][O])]   * headScale + headX;
    cX =  PT[0][int(TRI[2][O])]   * headScale + headX;

if(zoomIn == true){
    aX = lerp(aX,PT[0][zoomPoint] * headScale + headX,eyeZoom); //-------------------------------------------from here
    bX = lerp(bX,PT[0][zoomPoint] * headScale + headX,eyeZoom);
    cX = lerp(cX,PT[0][zoomPoint] * headScale + headX,eyeZoom);
  
    aY = lerp(aY,(PT[1][zoomPoint]-(12-PT[2][zoomPoint])*(Nod * nodDistance))*headScale+headY,eyeZoom)  ;
    bY = lerp(bY,(PT[1][zoomPoint]-(12-PT[2][zoomPoint])*(Nod * nodDistance))*headScale+headY,eyeZoom)  ;
    cY = lerp(cY,(PT[1][zoomPoint]-(12-PT[2][zoomPoint])*(Nod * nodDistance))*headScale+headY,eyeZoom)  ; // -----------to here adds the zoom effect to zoom into the eye, comment it to turn it off
}

    if( aX < width && aX > 0 && aY < height && aY > 0 &&
        bX < width && bX > 0 && aY < height && aY > 0 &&
        cX < width && cX > 0 && aY < height && aY > 0     )
    {
    triangle(  aX,  aY,             //point A (x,y)  draws triangles, scales and translates based off values inputted at main terminal
               bX,  bY,             //point B (x,y)
               cX,  cY              //point C (x,y)      
            );
    }
            
    fill(255,0,255);       
  //  circle(PT[0][100] * headScale + headX, (PT[1][100]-(12-PT[2][100])*(Nod * nodDistance))*headScale+headY, 20);       // this is just a circle for reference when building eyezoom       
            
} // end of for loop -------------------------------------------------------------------------------------------

  if(zoomIn == true){  
    eyeZoom = eyeZoom * 1.05; // exponentially zooms in on the eye
  }


    if(triangleCount < triangleNum){triangleCount += 3;  triangleCount = constrain(triangleCount,0,triangleNum);} // this is used in spawning in the triangles 1 by 1
    
    if(triangleCount == triangleNum){isHeadComplete = true;} // specifies that the head has been finished
    
} // -----------------------------------------------------------------------------------------------------------------------end of draw triangles()








void initialiseTriangleOrder(){
  triangleOrder = new IntList();
  for(I=0;  I<triangleNum;  I++){  triangleOrder.append(I);  } // sets up order values
  triangleOrder.shuffle(); // randomises the order of the values
}


void drawPoints(float headX,float headY){
  noStroke();
  fill(200,200,200);
  for(I=0;I<213;I++){
    circle(PT[0][I] * headScale + headX, (PT[1][I] * headScale + headY)  +  (14 - PT[2][I]) * (beatTimer * nodDistance), 10);
  }
}






}
