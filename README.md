We present some Matlab functions to generate Zero Correlation Zone (ZCZ) codes.

In a CDMA communications system, we would like to have a large set of codes available. A large set to serve many users, with the following features:
1. Each code with zero autocorrelation for non-zero phase shifts (no side lobes).
2. Zero cross-correlation between any pair of codes in the set.

It has been shown that fulfilling all of these conditions is impossible; however, it is possible to fulfill them partially.
Zero Correlation Zone (ZCZ) sequences have zero autocorrelation and zero cross-correlation in a limited area around zero phase shift.
They are bipolar sequences, meaning they take values ​​of +1 and -1.

The reference article to know more of ZCZ codes is Pingzhi Fan, N. Suehiro, N. Kuroyanagi and X. M. Deng, "Class of binary sequences with zero correlation zone", IEEE Electronics Letters, Vol. 35, No. 10, pp. 777-779, 1999

The codes are built according to the following parameters:
L = The length of the code.
Zcz = The number of zeros around the center of any correlation performed. It is the length of the zero correlation zone.
M = The number of different codes available with the same L and Zcz.

FUNCTIONS

zcz_code_L_M.m
Returns Zcz and the matrix with the Zero Correlation Zone (ZCZ) codes, L and M given

zcz_code_L_Zcz.m
Returns M and the matrix with the Zero Correlation Zone (ZCZ) codes, L and Zcz given

zcz_code_L_param_m.m
Returns Zcz and the matrix with the Zero Correlation Zone (ZCZ) codes, L and the parameter m given, where m is a parameter that defines the starter or initial vector. The larger m is, the larger Zcz is and the smaller M is

findAllUZCZ.m
Given L and UZCZ, It returns an array with all available codes of length L and one-sided zero-correlation zone of length UZCZ.
UZCZ = Zcz / 2. The number of zeros at either side from the center of any correlation performed. It is the length of the zero correlation zone at the right or at the left side.

zcz_code.m and period_corr.m
Functions that are called from the above ones

In order to know how to use the provided functions, please use Matlab's help command. For example:
>> help zcz_code_L_M




