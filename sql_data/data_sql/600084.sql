SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600084_RT`;
CREATE TABLE `600084_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600084`;
CREATE TABLE `600084` (
  `date` date NOT NULL COMMENT '交易日日期',
  `open_price` float(8,2) NOT NULL COMMENT '开盘价(当天第一笔交易单价)',
  `close_price` float(8,2) NOT NULL COMMENT '收盘价(当天第后笔交易单价，也就是当天最后一分钟的股票单价)',
  `max_price` float(8,2) NOT NULL COMMENT '最高价(当天所有交易的最高单价)',
  `min_price` float(8,2) NOT NULL COMMENT '最低价(当天所有交易的最低单价)',
  `volume` int(10) NOT NULL COMMENT '成交量(当天所有成交的股票数总和)',
  `amount` float(12,2) NOT NULL COMMENT '成交额(当天所有交易的股票数*单价的总和)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该日的收盘价较上一日的收盘价的涨跌幅)',
  `amplitude` float(3,2) NOT NULL COMMENT '振幅(|今日最高-今日最低|/昨日收盘 百分数)',
  `exchange_rate` float(8,2) NOT NULL COMMENT '换手率(当日成交所有股数/发行总股数 百分数)',
  `MACD` float(5,3) NOT NULL,
  `DIF` float(5,3) NOT NULL,
  `DEA` float(5,3) NOT NULL,
  `EMA12` float(5,3) NOT NULL,
  `EMA26` float(5,3) NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO `600084` VALUES('2016-11-10',28.36,34.03,34.03,28.36,30702,1044220.0,0.00,0.00,0.03,4.343,2.715,0.543,5.235,2.521);
INSERT INTO `600084` VALUES('2016-11-11',37.43,37.43,37.43,37.43,21100,789773.0,9.99,0.00,0.02,8.131,5.082,1.016,10.188,5.107);
INSERT INTO `600084` VALUES('2016-11-14',41.17,41.17,41.17,41.17,17318,712982.0,9.99,0.00,0.02,11.483,7.177,1.435,14.955,7.778);
INSERT INTO `600084` VALUES('2016-11-15',45.29,45.29,45.29,45.29,24835,1124780.0,10.01,0.00,0.02,14.504,9.065,1.813,19.622,10.557);
INSERT INTO `600084` VALUES('2016-11-16',49.82,49.82,49.82,49.82,51100,2545800.0,10.00,0.00,0.05,17.284,10.803,2.161,24.268,13.465);
INSERT INTO `600084` VALUES('2016-11-17',54.80,54.80,54.80,54.80,174632,9569830.0,10.00,0.00,0.17,19.901,12.438,2.488,28.965,16.527);
INSERT INTO `600084` VALUES('2016-11-18',60.28,60.28,60.28,58.01,7540885,4.54008E8,10.00,0.04,7.54,22.424,14.015,2.803,33.783,19.768);
INSERT INTO `600084` VALUES('2016-11-21',64.00,59.64,64.00,59.51,40054798,2.46656E9,-1.06,0.07,40.05,24.063,15.039,3.008,37.761,22.721);
INSERT INTO `600084` VALUES('2016-11-22',58.00,64.63,65.60,57.98,35128504,2.18795008E9,8.37,0.13,35.13,25.710,16.069,3.214,41.894,25.826);
INSERT INTO `600084` VALUES('2016-11-23',63.50,64.84,69.00,63.05,30396347,2.01757005E9,0.32,0.09,30.40,26.734,16.709,3.342,45.425,28.716);
INSERT INTO `600084` VALUES('2016-11-24',63.95,65.66,67.50,63.93,19602568,1.27895002E9,1.26,0.06,19.60,27.337,17.085,3.417,48.538,31.452);
INSERT INTO `600084` VALUES('2016-11-25',65.89,64.54,65.90,62.85,14634912,9.4088102E8,-1.71,0.05,14.63,27.354,17.096,3.419,51.000,33.903);
INSERT INTO `600084` VALUES('2016-11-28',64.00,60.41,64.00,60.30,15592229,9.6281203E8,-6.40,0.06,15.59,26.529,16.581,3.316,52.447,35.867);
INSERT INTO `600084` VALUES('2016-11-29',60.13,58.72,61.48,58.58,11271306,6.7429901E8,-2.80,0.05,11.27,25.365,15.853,3.171,53.412,37.560);
INSERT INTO `600084` VALUES('2016-11-30',58.36,57.14,58.99,56.88,8604460,4.96308E8,-2.69,0.04,8.60,23.961,14.976,2.995,53.986,39.010);
INSERT INTO `600084` VALUES('2016-12-01',57.21,58.84,59.88,56.27,11699669,6.78952E8,2.98,0.06,11.70,22.806,14.254,2.851,54.733,40.479);
INSERT INTO `600084` VALUES('2016-12-02',58.01,56.94,58.68,56.80,7608623,4.38476E8,-3.23,0.03,7.61,21.399,13.374,2.675,55.072,41.698);
INSERT INTO `600084` VALUES('2016-12-05',56.27,57.57,58.38,55.60,6619231,3.79217984E8,1.11,0.05,6.62,20.132,12.583,2.517,55.456,42.874);
INSERT INTO `600084` VALUES('2016-12-06',57.29,57.58,58.58,57.28,5603448,3.25048992E8,0.02,0.02,5.60,18.912,11.820,2.364,55.783,43.963);
INSERT INTO `600084` VALUES('2016-12-07',58.00,57.88,58.29,56.90,4850128,2.79238016E8,0.52,0.02,4.85,17.779,11.112,2.222,56.106,44.994);
INSERT INTO `600084` VALUES('2016-12-08',57.82,57.53,58.78,57.40,6103928,3.54257984E8,-0.60,0.02,6.10,16.644,10.402,2.080,56.325,45.923);
INSERT INTO `600084` VALUES('2016-12-09',57.10,54.45,57.29,53.78,9971035,5.5445299E8,-5.35,0.06,9.97,15.171,9.482,1.896,56.036,46.554);
INSERT INTO `600084` VALUES('2016-12-12',54.46,49.94,54.46,49.81,8632552,4.46416E8,-8.28,0.09,8.63,13.269,8.293,1.659,55.099,46.805);
INSERT INTO `600084` VALUES('2016-12-13',50.14,50.29,50.89,49.68,5424024,2.72860992E8,0.70,0.02,5.42,11.673,7.296,1.459,54.359,47.063);
INSERT INTO `600084` VALUES('2016-12-14',50.29,48.60,50.29,48.45,6457270,3.17921984E8,-3.36,0.04,6.46,10.073,6.296,1.259,53.473,47.177);
INSERT INTO `600084` VALUES('2016-12-15',48.49,49.06,49.75,48.06,4778389,2.35396992E8,0.95,0.03,4.78,8.764,5.477,1.095,52.794,47.317);
INSERT INTO `600084` VALUES('2016-12-16',48.70,50.08,50.38,48.70,4697663,2.32743008E8,2.08,0.03,4.70,7.768,4.855,0.971,52.376,47.521);
INSERT INTO `600084` VALUES('2016-12-19',49.73,49.57,50.50,49.53,4203009,2.10092992E8,-1.02,0.02,4.20,6.835,4.272,0.854,51.945,47.673);
INSERT INTO `600084` VALUES('2016-12-20',49.43,49.60,49.94,49.04,3217250,1.59156992E8,0.06,0.02,3.22,6.029,3.768,0.754,51.584,47.816);
INSERT INTO `600084` VALUES('2016-12-21',49.70,49.76,49.99,49.20,3249447,1.61308E8,0.32,0.02,3.25,5.350,3.344,0.669,51.303,47.960);
INSERT INTO `600084` VALUES('2016-12-22',49.77,49.05,49.77,48.90,3396570,1.67194E8,-1.43,0.02,3.40,4.666,2.916,0.583,50.957,48.041);
INSERT INTO `600084` VALUES('2016-12-23',49.05,47.00,49.22,46.88,5955171,2.84876E8,-4.18,0.05,5.96,3.815,2.384,0.477,50.348,47.963);
INSERT INTO `600084` VALUES('2016-12-26',46.70,46.81,47.00,45.25,4180404,1.92362E8,-0.40,0.04,4.18,3.081,1.926,0.385,49.804,47.878);
INSERT INTO `600084` VALUES('2016-12-27',46.70,46.66,47.32,46.45,2738808,1.28568E8,-0.32,0.02,2.74,2.452,1.532,0.306,49.320,47.788);
INSERT INTO `600084` VALUES('2016-12-28',46.70,45.63,46.80,45.58,3394733,1.5641E8,-2.21,0.03,3.39,1.799,1.124,0.225,48.752,47.628);
INSERT INTO `600084` VALUES('2016-12-29',45.62,45.41,45.95,45.33,2538726,1.15959E8,-0.48,0.01,2.54,1.239,0.774,0.155,48.238,47.464);
INSERT INTO `600084` VALUES('2016-12-30',45.26,44.96,45.79,44.81,3368630,1.52272E8,-0.99,0.02,3.37,0.729,0.456,0.091,47.734,47.278);
INSERT INTO `600084` VALUES('2017-01-03',45.00,46.14,46.39,45.00,4040109,1.84651008E8,2.62,0.03,4.04,0.472,0.295,0.059,47.489,47.194);
INSERT INTO `600084` VALUES('2017-01-04',45.95,46.16,46.28,45.70,3141422,1.44538E8,0.04,0.01,3.14,0.267,0.167,0.033,47.284,47.117);
INSERT INTO `600084` VALUES('2017-01-05',46.20,45.35,46.28,45.24,3272706,1.49759008E8,-1.75,0.02,3.27,0.000,0.000,0.000,46.987,46.986);
INSERT INTO `600084` VALUES('2017-01-06',45.09,43.43,45.32,43.30,5532046,2.44556992E8,-4.23,0.04,5.53,-0.454,-0.284,-0.057,46.439,46.723);
INSERT INTO `600084` VALUES('2017-01-09',43.10,42.98,43.26,42.41,3730258,1.59758E8,-1.04,0.02,3.73,-0.862,-0.538,-0.108,45.907,46.446);
INSERT INTO `600084` VALUES('2017-01-10',43.08,42.83,43.55,42.71,2666375,1.15009E8,-0.35,0.02,2.67,-1.190,-0.744,-0.149,45.434,46.178);
INSERT INTO `600084` VALUES('2017-01-11',42.89,41.24,42.89,41.22,3916714,1.64358E8,-3.71,0.04,3.92,-1.638,-1.023,-0.205,44.789,45.812);
INSERT INTO `600084` VALUES('2017-01-12',41.00,40.60,41.67,40.40,3529912,1.44716992E8,-1.55,0.03,3.53,-2.051,-1.282,-0.256,44.144,45.426);
INSERT INTO `600084` VALUES('2017-01-13',40.69,39.46,40.69,39.11,4457916,1.77226E8,-2.81,0.04,4.46,-2.497,-1.561,-0.312,43.424,44.984);
INSERT INTO `600084` VALUES('2017-01-16',39.28,38.18,39.28,36.25,5187093,1.97771008E8,-3.24,0.08,5.19,-2.981,-1.863,-0.373,42.617,44.480);
INSERT INTO `600084` VALUES('2017-01-17',38.00,40.39,40.75,37.55,5911834,2.32706E8,5.79,0.08,5.91,-3.045,-1.903,-0.381,42.274,44.177);
INSERT INTO `600084` VALUES('2017-01-18',40.20,38.80,40.20,38.79,3682043,1.45056992E8,-3.94,0.03,3.68,-3.262,-2.039,-0.408,41.740,43.779);
INSERT INTO `600084` VALUES('2017-01-19',38.28,39.21,40.10,37.76,4188665,1.63948E8,1.06,0.06,4.19,-3.344,-2.090,-0.418,41.351,43.440);
INSERT INTO `600084` VALUES('2017-01-20',39.21,40.17,40.49,38.82,4424572,1.76934E8,2.45,0.04,4.42,-3.247,-2.029,-0.406,41.169,43.198);
INSERT INTO `600084` VALUES('2017-01-23',40.18,40.44,40.91,40.00,3401014,1.37876992E8,0.67,0.02,3.40,-3.099,-1.937,-0.387,41.057,42.994);
INSERT INTO `600084` VALUES('2017-01-24',40.10,40.39,41.18,39.91,3577334,1.454E8,-0.12,0.03,3.58,-2.955,-1.847,-0.369,40.954,42.801);
INSERT INTO `600084` VALUES('2017-01-25',39.98,40.80,41.00,39.98,2515712,1.02383E8,1.02,0.03,2.52,-2.756,-1.722,-0.344,40.930,42.653);
INSERT INTO `600084` VALUES('2017-01-26',41.09,40.74,41.09,40.46,1923851,7.8273E7,-0.15,0.02,1.92,-2.576,-1.610,-0.322,40.901,42.511);
INSERT INTO `600084` VALUES('2017-02-03',40.65,40.06,40.84,39.89,1949239,7.8285296E7,-1.67,0.02,1.95,-2.492,-1.558,-0.312,40.772,42.329);
INSERT INTO `600084` VALUES('2017-02-06',40.21,41.47,41.55,40.20,4152283,1.70363008E8,3.52,0.03,4.15,-2.219,-1.387,-0.277,40.879,42.266);
INSERT INTO `600084` VALUES('2017-02-07',41.30,41.16,41.69,40.83,3504107,1.44498E8,-0.75,0.02,3.50,-2.018,-1.262,-0.252,40.922,42.184);
INSERT INTO `600084` VALUES('2017-02-08',40.92,41.98,42.17,40.70,4203762,1.7502E8,1.99,0.04,4.20,-1.734,-1.084,-0.217,41.085,42.169);
INSERT INTO `600084` VALUES('2017-02-09',42.15,43.11,43.43,41.82,5208535,2.23335008E8,2.69,0.04,5.21,-1.347,-0.842,-0.168,41.397,42.239);
INSERT INTO `600084` VALUES('2017-02-10',43.16,42.76,44.10,42.57,5691778,2.46362E8,-0.81,0.04,5.69,-1.073,-0.671,-0.134,41.606,42.277);
INSERT INTO `600084` VALUES('2017-02-13',42.88,44.39,44.60,42.76,5202203,2.29720992E8,3.81,0.04,5.20,-0.638,-0.399,-0.080,42.035,42.434);
INSERT INTO `600084` VALUES('2017-02-14',44.57,44.06,45.17,43.80,3853951,1.70666E8,-0.74,0.03,3.85,-0.333,-0.208,-0.042,42.346,42.554);
INSERT INTO `600084` VALUES('2017-02-15',44.06,43.52,44.53,43.44,4005398,1.76448E8,-1.23,0.02,4.01,-0.158,-0.099,-0.020,42.527,42.626);
INSERT INTO `600084` VALUES('2017-02-16',43.45,43.64,43.73,42.64,3799576,1.63819008E8,0.28,0.03,3.80,-0.004,-0.003,-0.001,42.698,42.701);
INSERT INTO `600084` VALUES('2017-02-17',43.80,43.34,44.67,43.15,4533968,1.9939E8,-0.69,0.03,4.53,0.078,0.049,0.010,42.797,42.748);
INSERT INTO `600084` VALUES('2017-02-20',43.03,42.63,43.30,42.02,3828391,1.62816992E8,-1.64,0.03,3.83,0.051,0.032,0.006,42.771,42.739);
INSERT INTO `600084` VALUES('2017-02-21',42.64,43.06,43.17,42.39,2222378,9.5412896E7,1.01,0.02,2.22,0.084,0.052,0.010,42.816,42.763);
INSERT INTO `600084` VALUES('2017-02-22',43.13,42.62,43.24,42.28,3120066,1.32994E8,-1.02,0.02,3.12,0.053,0.033,0.007,42.786,42.753);
INSERT INTO `600084` VALUES('2017-02-23',42.63,43.48,43.87,42.60,4113795,1.77999008E8,2.02,0.03,4.11,0.137,0.086,0.017,42.892,42.806);
INSERT INTO `600084` VALUES('2017-02-24',43.20,44.77,44.87,43.20,5999657,2.65088992E8,2.97,0.04,6.00,0.367,0.229,0.046,43.181,42.952);
INSERT INTO `600084` VALUES('2017-02-27',44.75,44.23,44.88,44.01,4031386,1.7899E8,-1.21,0.02,4.03,0.474,0.296,0.059,43.343,43.047);
INSERT INTO `600084` VALUES('2017-02-28',44.12,44.18,44.42,43.65,2989431,1.31375E8,-0.11,0.02,2.99,0.545,0.341,0.068,43.471,43.131);
INSERT INTO `600084` VALUES('2017-03-01',44.19,43.75,44.41,43.72,2977174,1.3099E8,-0.97,0.02,2.98,0.541,0.338,0.068,43.514,43.176);
INSERT INTO `600084` VALUES('2017-03-02',43.83,43.81,44.15,43.33,2943413,1.28811E8,0.14,0.02,2.94,0.538,0.336,0.067,43.560,43.223);
INSERT INTO `600084` VALUES('2017-03-03',43.93,43.55,43.93,43.20,2671424,1.16199E8,-0.59,0.02,2.67,0.497,0.311,0.062,43.558,43.248);
INSERT INTO `600084` VALUES('2017-03-06',43.40,44.89,45.00,43.40,4705379,2.08662E8,3.08,0.04,4.71,0.630,0.394,0.079,43.763,43.369);
INSERT INTO `600084` VALUES('2017-03-07',45.20,44.81,45.20,44.42,3822215,1.70926E8,-0.18,0.02,3.82,0.717,0.448,0.090,43.924,43.476);
INSERT INTO `600084` VALUES('2017-03-08',44.87,45.51,45.55,44.62,5497868,2.48916992E8,1.56,0.02,5.50,0.867,0.542,0.108,44.168,43.627);
INSERT INTO `600084` VALUES('2017-03-09',45.55,44.25,45.55,43.98,4861643,2.17106E8,-2.77,0.03,4.86,0.813,0.508,0.102,44.181,43.673);
INSERT INTO `600084` VALUES('2017-03-10',44.40,44.30,44.82,44.01,2941599,1.30662E8,0.11,0.02,2.94,0.768,0.480,0.096,44.199,43.719);
INSERT INTO `600084` VALUES('2017-03-13',44.10,44.47,44.50,43.30,3399116,1.49288E8,0.38,0.03,3.40,0.746,0.466,0.093,44.241,43.775);
INSERT INTO `600084` VALUES('2017-03-14',44.35,44.96,45.32,44.35,4374018,1.96402E8,1.10,0.02,4.37,0.782,0.489,0.098,44.351,43.863);
INSERT INTO `600084` VALUES('2017-03-15',44.64,44.33,44.80,44.14,2683371,1.19284E8,-1.40,0.01,2.68,0.721,0.451,0.090,44.348,43.897);
INSERT INTO `600084` VALUES('2017-03-16',44.50,46.20,46.27,44.50,7961386,3.62628E8,4.22,0.04,7.96,0.904,0.565,0.113,44.633,44.068);
INSERT INTO `600084` VALUES('2017-03-17',46.20,45.06,46.78,45.01,7199814,3.30916992E8,-2.47,0.04,7.20,0.892,0.557,0.111,44.699,44.141);
INSERT INTO `600084` VALUES('2017-03-20',44.94,45.96,45.98,44.80,3943637,1.79167008E8,2.00,0.03,3.94,0.987,0.617,0.123,44.893,44.276);
INSERT INTO `600084` VALUES('2017-03-21',45.94,45.98,46.29,45.52,3658977,1.67576E8,0.04,0.02,3.66,1.052,0.658,0.132,45.060,44.402);
INSERT INTO `600084` VALUES('2017-03-22',45.60,46.74,46.90,45.00,7235312,3.35712E8,1.65,0.04,7.24,1.189,0.743,0.149,45.318,44.575);
INSERT INTO `600084` VALUES('2017-03-23',47.80,49.26,50.66,47.80,14784045,7.2766298E8,5.39,0.06,14.78,1.604,1.002,0.200,45.925,44.922);
INSERT INTO `600084` VALUES('2017-03-24',48.65,49.94,50.69,48.20,10102395,5.00057984E8,1.38,0.05,10.10,1.998,1.248,0.250,46.543,45.294);
INSERT INTO `600084` VALUES('2017-03-27',49.80,50.88,51.90,49.80,9507854,4.85062016E8,1.88,0.04,9.51,2.403,1.502,0.300,47.210,45.708);
INSERT INTO `600084` VALUES('2017-03-28',50.88,49.43,51.18,49.00,6638146,3.30084992E8,-2.85,0.04,6.64,2.509,1.568,0.314,47.551,45.984);
INSERT INTO `600084` VALUES('2017-03-29',49.14,47.89,49.69,47.31,6806914,3.29574016E8,-3.12,0.05,6.81,2.366,1.479,0.296,47.604,46.125);
INSERT INTO `600084` VALUES('2017-03-30',47.78,48.41,49.62,47.52,7671961,3.74516E8,1.09,0.04,7.67,2.294,1.434,0.287,47.728,46.294);
INSERT INTO `600084` VALUES('2017-03-31',48.40,48.46,49.08,47.25,5040875,2.41738E8,0.10,0.04,5.04,2.217,1.386,0.277,47.840,46.455);
INSERT INTO `600084` VALUES('2017-04-05',48.25,49.36,49.38,47.48,4298717,2.09560992E8,1.86,0.04,4.30,2.247,1.404,0.281,48.074,46.670);
INSERT INTO `600084` VALUES('2017-04-06',49.37,48.60,50.58,48.51,6185050,3.0712E8,-1.54,0.04,6.19,2.148,1.342,0.268,48.155,46.813);
INSERT INTO `600084` VALUES('2017-04-07',48.25,48.03,48.49,47.28,4793225,2.28928992E8,-1.17,0.02,4.79,1.973,1.233,0.247,48.136,46.903);
INSERT INTO `600084` VALUES('2017-04-10',47.00,44.50,47.07,44.45,7258704,3.29943008E8,-7.35,0.05,7.26,1.362,0.852,0.170,47.576,46.725);
INSERT INTO `600084` VALUES('2017-04-11',44.40,44.92,45.28,43.58,4358532,1.94092992E8,0.94,0.04,4.36,0.922,0.577,0.115,47.168,46.591);
INSERT INTO `600084` VALUES('2017-04-12',44.95,43.98,45.00,43.91,2303896,1.02401E8,-2.09,0.02,2.30,0.447,0.280,0.056,46.677,46.398);
INSERT INTO `600084` VALUES('2017-04-13',44.20,44.08,44.68,44.02,2051530,9.0960304E7,0.23,0.02,2.05,0.083,0.052,0.010,46.278,46.226);
INSERT INTO `600084` VALUES('2017-04-14',43.99,42.71,43.99,42.25,3686559,1.583E8,-3.11,0.04,3.69,-0.379,-0.237,-0.047,45.729,45.966);
INSERT INTO `600084` VALUES('2017-04-17',42.02,42.11,42.55,41.01,2490768,1.04098E8,-1.40,0.04,2.49,-0.813,-0.508,-0.102,45.172,45.680);
INSERT INTO `600084` VALUES('2017-04-18',42.25,41.64,42.84,41.40,2196981,9.2860096E7,-1.12,0.03,2.20,-1.203,-0.752,-0.150,44.629,45.381);
INSERT INTO `600084` VALUES('2017-04-19',41.25,42.50,42.55,41.25,2398145,1.01152E8,2.07,0.03,2.40,-1.386,-0.866,-0.173,44.301,45.167);
INSERT INTO `600084` VALUES('2017-04-20',42.77,43.08,43.17,42.25,2518683,1.07921E8,1.36,0.02,2.52,-1.439,-0.899,-0.180,44.113,45.013);
INSERT INTO `600084` VALUES('2017-04-21',43.11,43.21,43.42,42.65,1663438,7.17836E7,0.30,0.02,1.66,-1.448,-0.905,-0.181,43.974,44.879);
INSERT INTO `600084` VALUES('2017-04-24',43.25,43.64,44.40,41.50,3141962,1.35628E8,1.00,0.07,3.14,-1.383,-0.865,-0.173,43.923,44.787);
INSERT INTO `600084` VALUES('2017-04-25',43.64,43.56,44.20,43.31,1774272,7.76968E7,-0.18,0.02,1.77,-1.327,-0.829,-0.166,43.867,44.697);
INSERT INTO `600084` VALUES('2017-04-26',43.43,43.89,44.14,43.38,1489063,6.52352E7,0.76,0.02,1.49,-1.226,-0.766,-0.153,43.871,44.637);
INSERT INTO `600084` VALUES('2017-04-27',43.89,44.25,44.48,43.00,2496351,1.09369E8,0.82,0.03,2.50,-1.087,-0.679,-0.136,43.929,44.608);
INSERT INTO `600084` VALUES('2017-04-28',44.25,44.80,45.11,44.16,2373183,1.06336E8,1.24,0.02,2.37,-0.895,-0.559,-0.112,44.063,44.622);
INSERT INTO `600084` VALUES('2017-05-02',44.80,45.22,45.52,44.65,2606594,1.17803E8,0.94,0.02,2.61,-0.681,-0.426,-0.085,44.241,44.667);
INSERT INTO `600084` VALUES('2017-05-03',44.97,45.01,45.50,44.50,2073500,9.3057904E7,-0.46,0.02,2.07,-0.532,-0.333,-0.067,44.359,44.692);
INSERT INTO `600084` VALUES('2017-05-04',44.96,44.90,45.44,44.62,1960600,8.8440496E7,-0.24,0.02,1.96,-0.424,-0.265,-0.053,44.442,44.707);
INSERT INTO `600084` VALUES('2017-05-05',44.90,44.24,45.20,44.16,1512390,6.77594E7,-1.47,0.02,1.51,-0.418,-0.261,-0.052,44.411,44.673);
INSERT INTO `600084` VALUES('2017-05-08',44.00,42.26,44.00,42.24,2404016,1.0361E8,-4.48,0.04,2.40,-0.662,-0.414,-0.083,44.080,44.494);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:30',44.00,0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:31',42.37,-3.71,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:32',42.43,0.14,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:33',42.38,-0.12,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:34',42.35,-0.05,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:35',42.29,-0.15,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:36',42.26,-0.08,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:37',42.27,0.02,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:38',42.26,-0.01,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:39',42.26,-0.02,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:40',42.28,0.05,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:41',42.31,0.08,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:42',42.30,-0.02,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:43',42.27,-0.07,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:44',42.26,-0.04,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:45',42.24,-0.04,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:46',42.24,0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:47',42.24,-0.01,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:48',42.24,0.00,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:49',42.24,0.00,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:50',42.24,0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:51',42.24,0.00,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:52',42.24,0.00,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:53',42.24,0.00,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:54',42.25,0.02,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:55',42.25,0.01,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:56',42.24,-0.02,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:57',42.26,0.04,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:58',42.26,0.01,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','09:59',42.28,0.05,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:00',42.29,0.03,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:01',42.29,-0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:02',42.30,0.02,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:03',42.32,0.03,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:04',42.32,0.01,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:05',42.35,0.06,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:06',42.36,0.02,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:07',42.37,0.03,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:08',42.39,0.06,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:09',42.42,0.05,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:10',42.41,-0.00,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:11',42.40,-0.04,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:12',42.40,-0.00,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:13',42.39,-0.02,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:14',42.39,0.00,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:15',42.43,0.09,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:16',42.47,0.10,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:17',42.49,0.05,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:18',42.49,-0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:19',42.48,-0.01,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:20',42.47,-0.02,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:21',42.46,-0.04,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:22',42.46,0.02,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:23',42.46,-0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:24',42.46,0.00,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:25',42.46,-0.01,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:26',42.46,0.01,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:27',42.45,-0.02,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:28',42.47,0.04,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:29',42.46,-0.02,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:30',42.47,0.02,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:31',42.46,-0.02,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:32',42.50,0.08,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:33',42.50,-0.00,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:34',42.50,0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:35',42.49,-0.02,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:36',42.49,0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:37',42.49,0.00,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:38',42.49,-0.02,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:39',42.48,-0.02,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:40',42.47,-0.03,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:41',42.45,-0.04,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:42',42.44,-0.02,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:43',42.43,-0.02,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:44',42.43,-0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:45',42.42,-0.01,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:46',42.43,0.01,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:47',42.43,0.00,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:48',42.43,-0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:49',42.43,0.02,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:50',42.42,-0.02,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:51',42.42,-0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:52',42.44,0.05,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:53',42.45,0.00,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:54',42.44,-0.00,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:55',42.44,-0.02,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:56',42.44,0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:57',42.44,-0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:58',42.44,0.01,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','10:59',42.44,0.00,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:00',42.46,0.04,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:01',42.46,-0.01,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:02',42.45,-0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:03',42.46,0.01,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:04',42.46,0.01,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:05',42.46,0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:06',42.49,0.05,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:07',42.50,0.03,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:08',42.51,0.02,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:09',42.50,-0.02,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:10',42.49,-0.01,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:11',42.48,-0.03,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:12',42.48,0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:13',42.48,0.00,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:14',42.48,-0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:15',42.47,-0.01,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:16',42.47,0.01,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:17',42.47,-0.01,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:18',42.47,0.00,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:19',42.48,0.03,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:20',42.49,0.02,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:21',42.50,0.02,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:22',42.50,0.00,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:23',42.50,0.01,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:24',42.50,-0.01,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:25',42.50,0.01,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:26',42.52,0.04,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:27',42.52,0.00,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:28',42.52,0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','11:29',42.52,-0.01,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:00',42.53,0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:01',42.53,0.02,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:02',42.53,0.00,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:03',42.52,-0.02,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:04',42.53,0.00,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:05',42.52,-0.01,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:06',42.51,-0.02,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:07',42.52,0.02,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:08',42.52,0.00,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:09',42.52,0.00,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:10',42.53,0.02,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:11',42.53,0.00,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:12',42.53,0.00,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:13',42.53,-0.01,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:14',42.52,-0.03,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:15',42.50,-0.03,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:16',42.50,0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:17',42.49,-0.03,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:18',42.48,-0.02,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:19',42.48,-0.01,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:20',42.47,-0.02,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:21',42.47,0.00,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:22',42.47,-0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:23',42.48,0.01,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:24',42.47,-0.00,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:25',42.47,-0.02,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:26',42.46,-0.03,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:27',42.45,-0.01,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:28',42.45,0.00,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:29',42.46,0.02,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:30',42.47,0.03,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:31',42.47,-0.00,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:32',42.48,0.01,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:33',42.48,-0.00,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:34',42.48,0.00,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:35',42.47,-0.01,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:36',42.47,0.01,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:37',42.47,-0.00,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:38',42.48,0.01,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:39',42.48,-0.00,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:40',42.48,0.01,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:41',42.47,-0.01,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:42',42.47,-0.01,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:43',42.46,-0.01,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:44',42.46,-0.01,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:45',42.45,-0.01,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:46',42.45,-0.00,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:47',42.46,0.00,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:48',42.46,0.00,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:49',42.45,-0.01,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:50',42.45,-0.01,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:51',42.46,0.03,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:52',42.46,0.01,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:53',42.47,0.00,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:54',42.47,0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:55',42.47,0.00,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:56',42.47,0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:57',42.47,0.01,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:58',42.47,0.00,109.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','13:59',42.48,0.01,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:00',42.48,0.01,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:01',42.48,0.01,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:02',42.49,0.00,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:03',42.48,-0.02,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:04',42.48,0.01,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:05',42.47,-0.03,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:06',42.47,0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:07',42.47,-0.01,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:08',42.47,0.01,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:09',42.46,-0.01,96.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:10',42.48,0.03,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:11',42.48,0.01,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:12',42.49,0.03,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:13',42.49,0.01,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:14',42.49,-0.02,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:15',42.49,0.00,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:16',42.49,0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:17',42.48,-0.01,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:18',42.49,0.01,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:19',42.48,-0.02,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:20',42.48,0.01,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:21',42.47,-0.03,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:22',42.47,0.00,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:23',42.46,-0.02,90.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:24',42.46,0.00,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:25',42.45,-0.01,91.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:26',42.45,-0.02,100.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:27',42.45,0.00,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:28',42.44,-0.02,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:29',42.43,-0.01,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:30',42.43,-0.00,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:31',42.44,0.00,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:32',42.44,0.00,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:33',42.44,0.01,93.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:34',42.44,0.00,104.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:35',42.43,-0.03,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:36',42.44,0.01,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:37',42.41,-0.07,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:38',42.40,-0.02,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:39',42.39,-0.02,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:40',42.39,0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:41',42.39,-0.01,92.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:42',42.38,-0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:43',42.39,0.01,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:44',42.39,-0.00,107.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:45',42.39,0.00,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:46',42.40,0.02,108.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:47',42.40,0.00,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:48',42.41,0.02,101.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:49',42.41,-0.01,95.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:50',42.42,0.03,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:51',42.42,-0.00,97.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:52',42.42,0.01,103.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:53',42.42,0.00,99.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:54',42.43,0.01,102.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:55',42.43,0.01,98.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:56',42.43,-0.00,106.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:57',42.43,0.00,94.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:58',42.44,0.02,105.00);
INSERT INTO `600084_RT` VALUES('2017-05-08','14:59',42.26,-0.42,212.00);