SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600000_RT`;
CREATE TABLE `600000_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600000`;
CREATE TABLE `600000` (
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

INSERT INTO `600000` VALUES('2016-12-06',7.69,9.23,9.23,7.69,336157,3090100.0,0.00,0.00,0.34,1.178,0.736,0.147,1.420,0.684);
INSERT INTO `600000` VALUES('2016-12-07',10.15,10.15,10.15,10.15,194218,1971310.0,9.97,0.00,0.19,2.205,1.378,0.276,2.763,1.385);
INSERT INTO `600000` VALUES('2016-12-08',11.17,11.17,11.17,11.17,406442,4539960.0,10.05,0.00,0.41,3.115,1.947,0.389,4.056,2.110);
INSERT INTO `600000` VALUES('2016-12-09',12.29,12.29,12.29,12.29,1040838,1.27919E7,10.03,0.00,1.04,3.935,2.459,0.492,5.323,2.864);
INSERT INTO `600000` VALUES('2016-12-12',13.52,13.52,13.52,13.52,4208226,5.68952E7,10.01,0.00,4.21,4.690,2.931,0.586,6.584,3.653);
INSERT INTO `600000` VALUES('2016-12-13',13.90,14.87,14.87,13.53,340600573,4.93613E9,9.99,0.10,340.60,5.400,3.375,0.675,7.859,4.484);
INSERT INTO `600000` VALUES('2016-12-14',15.01,14.00,15.01,13.87,300975366,4.31424E9,-5.85,0.08,300.98,5.784,3.615,0.723,8.804,5.189);
INSERT INTO `600000` VALUES('2016-12-15',13.74,14.98,15.39,13.65,306939182,4.5413801E9,7.00,0.12,306.94,6.144,3.840,0.768,9.754,5.914);
INSERT INTO `600000` VALUES('2016-12-16',14.61,14.71,14.96,14.33,181651038,2.65202995E9,-1.80,0.04,181.65,6.321,3.951,0.790,10.516,6.566);
INSERT INTO `600000` VALUES('2016-12-19',14.60,14.21,14.60,13.92,120576332,1.70627994E9,-3.40,0.05,120.58,6.324,3.953,0.791,11.085,7.132);
INSERT INTO `600000` VALUES('2016-12-20',14.15,14.43,14.82,14.14,143187108,2.07805005E9,1.55,0.05,143.19,6.283,3.927,0.785,11.599,7.673);
INSERT INTO `600000` VALUES('2016-12-21',14.60,14.53,14.88,14.16,137002666,1.98463002E9,0.69,0.05,137.00,6.191,3.870,0.774,12.050,8.181);
INSERT INTO `600000` VALUES('2016-12-22',14.42,14.13,14.44,14.00,100288189,1.4208E9,-2.75,0.03,100.29,5.998,3.749,0.750,12.370,8.621);
INSERT INTO `600000` VALUES('2016-12-23',13.92,13.03,14.02,13.01,165543071,2.2185001E9,-7.78,0.07,165.54,5.638,3.524,0.705,12.472,8.948);
INSERT INTO `600000` VALUES('2016-12-26',12.79,13.12,13.23,12.44,96462659,1.23863002E9,0.69,0.06,96.46,5.303,3.315,0.663,12.571,9.257);
INSERT INTO `600000` VALUES('2016-12-27',12.98,12.70,13.02,12.66,75189002,9.6231098E8,-3.20,0.03,75.19,4.927,3.079,0.616,12.591,9.512);
INSERT INTO `600000` VALUES('2016-12-28',12.71,12.56,12.88,12.42,58621630,7.4157197E8,-1.10,0.04,58.62,4.558,2.849,0.570,12.586,9.738);
INSERT INTO `600000` VALUES('2016-12-29',12.49,12.55,12.79,12.32,60926967,7.6771398E8,-0.08,0.04,60.93,4.216,2.635,0.527,12.581,9.946);
INSERT INTO `600000` VALUES('2016-12-30',12.51,12.55,12.68,12.42,48271294,6.0542202E8,0.00,0.02,48.27,3.899,2.437,0.487,12.576,10.139);
INSERT INTO `600000` VALUES('2017-01-03',12.64,12.63,12.77,12.55,45324931,5.7326099E8,0.64,0.02,45.32,3.617,2.261,0.452,12.584,10.323);
INSERT INTO `600000` VALUES('2017-01-04',12.69,12.52,12.69,12.36,71675182,8.9432397E8,-0.87,0.03,71.68,3.341,2.088,0.418,12.574,10.486);
INSERT INTO `600000` VALUES('2017-01-05',12.50,12.16,12.50,12.13,84056928,1.03444E9,-2.88,0.03,84.06,3.041,1.901,0.380,12.511,10.610);
INSERT INTO `600000` VALUES('2017-01-06',12.09,11.63,12.17,11.62,81979114,9.7126202E8,-4.36,0.05,81.98,2.703,1.690,0.338,12.375,10.686);
INSERT INTO `600000` VALUES('2017-01-09',11.64,11.59,11.71,11.54,47198869,5.48248E8,-0.34,0.01,47.20,2.403,1.502,0.300,12.254,10.753);
INSERT INTO `600000` VALUES('2017-01-10',11.54,11.34,11.55,11.27,68461652,7.7821498E8,-2.16,0.02,68.46,2.108,1.318,0.264,12.114,10.796);
INSERT INTO `600000` VALUES('2017-01-11',11.27,10.85,11.33,10.83,73206445,8.1043699E8,-4.32,0.04,73.21,1.791,1.119,0.224,11.919,10.800);
INSERT INTO `600000` VALUES('2017-01-12',10.74,10.96,11.29,10.70,75665731,8.3795597E8,1.01,0.05,75.67,1.536,0.960,0.192,11.772,10.812);
INSERT INTO `600000` VALUES('2017-01-13',10.86,10.84,11.08,10.72,53963597,5.8671098E8,-1.09,0.03,53.96,1.303,0.814,0.163,11.628,10.814);
INSERT INTO `600000` VALUES('2017-01-16',10.70,10.36,10.72,10.00,67867540,7.0595898E8,-4.43,0.07,67.87,1.044,0.653,0.131,11.433,10.780);
INSERT INTO `600000` VALUES('2017-01-17',10.25,10.45,10.55,9.99,55286385,5.6827501E8,0.87,0.05,55.29,0.842,0.526,0.105,11.282,10.756);
INSERT INTO `600000` VALUES('2017-01-18',10.35,10.23,10.42,10.22,32622332,3.36264992E8,-2.11,0.02,32.62,0.645,0.403,0.081,11.120,10.717);
INSERT INTO `600000` VALUES('2017-01-19',10.19,10.40,10.66,10.11,65356345,6.8326899E8,1.66,0.05,65.36,0.505,0.316,0.063,11.009,10.694);
INSERT INTO `600000` VALUES('2017-01-20',10.35,10.73,10.96,10.32,79541968,8.4703398E8,3.17,0.06,79.54,0.432,0.270,0.054,10.966,10.696);
INSERT INTO `600000` VALUES('2017-01-23',10.63,10.63,10.76,10.57,46638505,4.97088992E8,-0.93,0.02,46.64,0.357,0.223,0.045,10.915,10.691);
INSERT INTO `600000` VALUES('2017-01-24',10.64,10.45,10.64,10.42,26572137,2.79206016E8,-1.69,0.02,26.57,0.272,0.170,0.034,10.843,10.673);
INSERT INTO `600000` VALUES('2017-01-25',10.43,10.46,10.54,10.41,19044057,1.99599008E8,0.10,0.01,19.04,0.203,0.127,0.025,10.784,10.658);
INSERT INTO `600000` VALUES('2017-01-26',10.52,10.43,10.57,10.36,27271481,2.85243008E8,-0.29,0.02,27.27,0.142,0.089,0.018,10.730,10.641);
INSERT INTO `600000` VALUES('2017-02-03',10.41,10.39,10.45,10.33,15178774,1.57440992E8,-0.38,0.01,15.18,0.088,0.055,0.011,10.677,10.622);
INSERT INTO `600000` VALUES('2017-02-06',10.39,10.52,10.53,10.36,27256536,2.84808992E8,1.25,0.02,27.26,0.062,0.039,0.008,10.653,10.615);
INSERT INTO `600000` VALUES('2017-02-07',10.48,10.33,10.51,10.23,33021588,3.42359008E8,-1.81,0.03,33.02,0.016,0.010,0.002,10.603,10.594);
INSERT INTO `600000` VALUES('2017-02-08',10.31,11.11,11.28,10.21,114881236,1.2428E9,7.55,0.10,114.88,0.079,0.050,0.010,10.681,10.632);
INSERT INTO `600000` VALUES('2017-02-09',10.90,11.02,11.34,10.86,125533458,1.39193997E9,-0.81,0.04,125.53,0.117,0.073,0.015,10.734,10.661);
INSERT INTO `600000` VALUES('2017-02-10',10.97,11.29,11.53,10.91,126586473,1.42337997E9,2.45,0.06,126.59,0.179,0.112,0.022,10.819,10.707);
INSERT INTO `600000` VALUES('2017-02-13',11.18,11.32,11.55,11.13,97971701,1.11408998E9,0.27,0.04,97.97,0.230,0.144,0.029,10.896,10.753);
INSERT INTO `600000` VALUES('2017-02-14',11.30,11.49,11.88,11.21,107895338,1.24446003E9,1.50,0.06,107.90,0.289,0.180,0.036,10.988,10.807);
INSERT INTO `600000` VALUES('2017-02-15',11.38,11.42,11.92,11.25,118892811,1.37208E9,-0.61,0.06,118.89,0.322,0.201,0.040,11.054,10.853);
INSERT INTO `600000` VALUES('2017-02-16',11.29,12.43,12.53,11.28,223015334,2.68358989E9,8.84,0.11,223.02,0.474,0.296,0.059,11.266,10.969);
INSERT INTO `600000` VALUES('2017-02-17',12.21,12.39,13.67,12.13,328880197,4.29025997E9,-0.32,0.12,328.88,0.582,0.364,0.073,11.439,11.075);
INSERT INTO `600000` VALUES('2017-02-20',12.07,12.25,12.48,11.66,168739970,2.03084006E9,-1.13,0.07,168.74,0.643,0.402,0.080,11.564,11.162);
INSERT INTO `600000` VALUES('2017-02-21',12.20,12.00,12.45,11.87,125765696,1.5252E9,-2.04,0.05,125.77,0.651,0.407,0.081,11.631,11.224);
INSERT INTO `600000` VALUES('2017-02-22',11.91,11.79,11.94,11.65,88541790,1.04184E9,-1.75,0.02,88.54,0.623,0.389,0.078,11.655,11.266);
INSERT INTO `600000` VALUES('2017-02-23',11.76,11.80,11.93,11.61,69751969,8.2107398E8,0.08,0.03,69.75,0.595,0.372,0.074,11.677,11.305);
INSERT INTO `600000` VALUES('2017-02-24',11.74,11.76,11.82,11.60,52971262,6.1934298E8,-0.34,0.02,52.97,0.562,0.351,0.070,11.690,11.339);
INSERT INTO `600000` VALUES('2017-02-27',11.68,11.61,11.79,11.57,48812399,5.6981101E8,-1.28,0.02,48.81,0.510,0.319,0.064,11.678,11.359);
INSERT INTO `600000` VALUES('2017-02-28',11.58,11.92,12.09,11.58,91902260,1.09175002E9,2.67,0.04,91.90,0.503,0.314,0.063,11.715,11.401);
INSERT INTO `600000` VALUES('2017-03-01',11.89,11.89,12.05,11.81,73083188,8.7156499E8,-0.25,0.02,73.08,0.488,0.305,0.061,11.742,11.437);
INSERT INTO `600000` VALUES('2017-03-02',11.96,12.57,13.08,11.93,231019372,2.93867008E9,5.72,0.10,231.02,0.558,0.349,0.070,11.869,11.521);
INSERT INTO `600000` VALUES('2017-03-03',12.33,12.31,12.44,12.13,126470915,1.55212006E9,-2.07,0.02,126.47,0.573,0.358,0.072,11.937,11.579);
INSERT INTO `600000` VALUES('2017-03-06',12.27,12.43,12.57,12.19,99991402,1.23875994E9,0.97,0.03,99.99,0.593,0.371,0.074,12.013,11.642);
INSERT INTO `600000` VALUES('2017-03-07',12.42,12.45,12.48,12.14,82816125,1.02227002E9,0.16,0.03,82.82,0.605,0.378,0.076,12.080,11.702);
INSERT INTO `600000` VALUES('2017-03-08',12.39,12.25,12.44,12.20,61777207,7.6022099E8,-1.61,0.02,61.78,0.582,0.364,0.073,12.106,11.743);
INSERT INTO `600000` VALUES('2017-03-09',12.20,12.16,12.28,11.95,71544485,8.6745299E8,-0.73,0.03,71.54,0.546,0.341,0.068,12.115,11.774);
INSERT INTO `600000` VALUES('2017-03-10',12.10,11.79,12.30,11.75,70650498,8.5266502E8,-3.04,0.05,70.65,0.464,0.290,0.058,12.065,11.775);
INSERT INTO `600000` VALUES('2017-03-13',11.65,11.70,11.74,11.41,53039416,6.1511098E8,-0.76,0.03,53.04,0.383,0.239,0.048,12.009,11.769);
INSERT INTO `600000` VALUES('2017-03-14',11.69,11.61,11.87,11.58,42837020,5.01790016E8,-0.77,0.02,42.84,0.304,0.190,0.038,11.947,11.757);
INSERT INTO `600000` VALUES('2017-03-15',11.61,11.66,11.77,11.56,36669083,4.28209984E8,0.43,0.02,36.67,0.244,0.153,0.031,11.903,11.750);
INSERT INTO `600000` VALUES('2017-03-16',11.79,12.83,12.83,11.79,246894347,3.10047002E9,10.03,0.09,246.89,0.345,0.215,0.043,12.046,11.830);
INSERT INTO `600000` VALUES('2017-03-17',13.39,12.30,13.49,12.27,287302905,3.70004992E9,-4.13,0.10,287.30,0.352,0.220,0.044,12.085,11.865);
INSERT INTO `600000` VALUES('2017-03-20',12.25,12.18,12.34,12.01,107112987,1.30080998E9,-0.98,0.03,107.11,0.338,0.211,0.042,12.099,11.888);
INSERT INTO `600000` VALUES('2017-03-21',12.10,12.38,12.43,12.07,88652710,1.08966003E9,1.64,0.03,88.65,0.348,0.218,0.044,12.143,11.925);
INSERT INTO `600000` VALUES('2017-03-22',12.25,12.18,12.38,12.11,71389034,8.71664E8,-1.62,0.02,71.39,0.327,0.205,0.041,12.148,11.944);
INSERT INTO `600000` VALUES('2017-03-23',12.16,12.35,12.60,12.01,98098728,1.20981005E9,1.40,0.05,98.10,0.329,0.206,0.041,12.179,11.974);
INSERT INTO `600000` VALUES('2017-03-24',12.28,12.44,12.55,12.13,91224433,1.12471002E9,0.73,0.03,91.22,0.338,0.211,0.042,12.219,12.008);
INSERT INTO `600000` VALUES('2017-03-27',12.47,12.60,12.95,12.38,130367894,1.65474995E9,1.29,0.05,130.37,0.361,0.226,0.045,12.278,12.052);
INSERT INTO `600000` VALUES('2017-03-28',12.51,12.47,12.56,12.32,68996506,8.5905702E8,-1.03,0.02,69.00,0.359,0.224,0.045,12.308,12.083);
INSERT INTO `600000` VALUES('2017-03-29',12.39,11.62,12.43,11.33,117331241,1.40949005E9,-6.82,0.09,117.33,0.245,0.153,0.031,12.202,12.049);
INSERT INTO `600000` VALUES('2017-03-30',11.40,11.31,11.56,11.30,67652225,7.73872E8,-2.67,0.02,67.65,0.113,0.071,0.014,12.065,11.994);
INSERT INTO `600000` VALUES('2017-03-31',11.36,11.48,11.59,11.36,46053529,5.28695008E8,1.50,0.02,46.05,0.030,0.019,0.004,11.975,11.956);
INSERT INTO `600000` VALUES('2017-04-05',11.45,11.61,11.69,11.14,55401788,6.3641101E8,1.13,0.05,55.40,-0.019,-0.012,-0.002,11.919,11.930);
INSERT INTO `600000` VALUES('2017-04-06',11.61,11.71,11.73,11.53,49851344,5.7992998E8,0.86,0.02,49.85,-0.044,-0.028,-0.006,11.886,11.914);
INSERT INTO `600000` VALUES('2017-04-07',11.67,11.51,11.82,11.48,44712147,5.20827008E8,-1.71,0.03,44.71,-0.089,-0.056,-0.011,11.829,11.884);
INSERT INTO `600000` VALUES('2017-04-10',11.41,11.11,11.45,11.05,56626670,6.37112E8,-3.48,0.03,56.63,-0.174,-0.109,-0.022,11.718,11.827);
INSERT INTO `600000` VALUES('2017-04-11',11.13,11.36,11.46,11.06,52841035,5.9378803E8,2.25,0.04,52.84,-0.207,-0.129,-0.026,11.663,11.792);
INSERT INTO `600000` VALUES('2017-04-12',11.37,11.35,11.65,11.26,55234106,6.3229197E8,-0.09,0.03,55.23,-0.231,-0.145,-0.029,11.615,11.759);
INSERT INTO `600000` VALUES('2017-04-13',11.26,11.27,11.38,11.20,29833908,3.36608992E8,-0.70,0.02,29.83,-0.258,-0.161,-0.032,11.562,11.723);
INSERT INTO `600000` VALUES('2017-04-14',11.24,11.04,11.28,11.00,34940374,3.88297984E8,-2.04,0.02,34.94,-0.306,-0.191,-0.038,11.481,11.673);
INSERT INTO `600000` VALUES('2017-04-17',10.80,10.71,10.89,10.51,38065740,4.082E8,-2.99,0.03,38.07,-0.382,-0.238,-0.048,11.363,11.601);
INSERT INTO `600000` VALUES('2017-04-18',10.75,10.47,10.80,10.46,24910755,2.64602E8,-2.24,0.03,24.91,-0.467,-0.292,-0.058,11.225,11.517);
INSERT INTO `600000` VALUES('2017-04-19',10.40,10.58,10.66,10.36,29543235,3.11420992E8,1.05,0.03,29.54,-0.515,-0.322,-0.064,11.126,11.448);
INSERT INTO `600000` VALUES('2017-04-20',10.56,10.46,10.64,10.26,29459057,3.07772E8,-1.13,0.04,29.46,-0.562,-0.351,-0.070,11.024,11.375);
INSERT INTO `600000` VALUES('2017-04-21',10.49,10.31,10.54,10.22,21068070,2.1901E8,-1.43,0.03,21.07,-0.611,-0.382,-0.076,10.914,11.296);
INSERT INTO `600000` VALUES('2017-04-24',10.31,10.10,10.32,9.96,25545346,2.58536E8,-2.04,0.03,25.55,-0.670,-0.419,-0.084,10.789,11.207);
INSERT INTO `600000` VALUES('2017-04-25',10.17,10.17,10.28,10.12,17900599,1.82508992E8,0.69,0.02,17.90,-0.699,-0.437,-0.087,10.693,11.131);
INSERT INTO `600000` VALUES('2017-04-26',10.19,10.45,10.90,10.14,50015242,5.26007008E8,2.75,0.07,50.02,-0.679,-0.424,-0.085,10.656,11.080);
INSERT INTO `600000` VALUES('2017-04-27',10.35,10.55,10.65,10.19,42168403,4.40369984E8,0.96,0.04,42.17,-0.642,-0.401,-0.080,10.640,11.041);
INSERT INTO `600000` VALUES('2017-04-28',10.47,10.54,10.62,10.47,22501146,2.37060992E8,-0.09,0.01,22.50,-0.607,-0.379,-0.076,10.624,11.004);
INSERT INTO `600000` VALUES('2017-05-02',10.52,10.49,10.55,10.37,19495583,2.04032992E8,-0.47,0.02,19.50,-0.579,-0.362,-0.072,10.604,10.966);
INSERT INTO `600000` VALUES('2017-05-03',10.46,10.41,10.59,10.31,21151567,2.211E8,-0.76,0.03,21.15,-0.561,-0.351,-0.070,10.574,10.925);
INSERT INTO `600000` VALUES('2017-05-04',10.37,10.33,10.51,10.25,23889847,2.48022E8,-0.77,0.02,23.89,-0.551,-0.344,-0.069,10.536,10.880);
INSERT INTO `600000` VALUES('2017-05-05',10.31,10.43,10.84,10.22,56278355,5.9155597E8,0.97,0.06,56.28,-0.523,-0.327,-0.065,10.520,10.847);
INSERT INTO `600000` VALUES('2017-05-08',10.20,10.08,10.35,10.05,35853538,3.64688992E8,-3.36,0.03,35.85,-0.541,-0.338,-0.068,10.452,10.790);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:30',10.20,0.00,1549.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:31',10.18,-0.23,1401.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:32',10.24,0.60,1538.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:33',10.19,-0.51,1405.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:34',10.16,-0.22,1555.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:35',10.10,-0.61,1440.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:36',10.07,-0.32,1583.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:37',10.08,0.09,1492.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:38',10.07,-0.03,1499.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:39',10.07,-0.08,1429.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:40',10.09,0.21,1538.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:41',10.12,0.34,1483.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:42',10.11,-0.07,1499.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:43',10.08,-0.30,1463.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:44',10.07,-0.15,1572.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:45',10.05,-0.19,1443.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:46',10.05,0.04,1564.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:47',10.05,-0.04,1462.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:48',10.05,0.00,1554.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:49',10.05,0.00,1484.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:50',10.05,0.00,1568.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:51',10.05,0.00,1488.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:52',10.05,0.00,1588.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:53',10.05,0.00,1439.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:54',10.06,0.09,1568.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:55',10.06,0.04,1481.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:56',10.05,-0.09,1534.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:57',10.07,0.15,1486.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:58',10.07,0.06,1539.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','09:59',10.09,0.19,1468.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:00',10.10,0.11,1566.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:01',10.10,-0.01,1416.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:02',10.11,0.09,1522.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:03',10.13,0.14,1420.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:04',10.13,0.06,1497.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:05',10.16,0.24,1492.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:06',10.17,0.10,1544.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:07',10.18,0.13,1468.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:08',10.20,0.24,1530.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:09',10.23,0.21,1467.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:10',10.22,-0.02,1499.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:11',10.21,-0.15,1492.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:12',10.21,-0.02,1516.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:13',10.20,-0.07,1402.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:14',10.20,0.00,1572.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:15',10.24,0.36,1399.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:16',10.28,0.42,1538.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:17',10.30,0.20,1479.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:18',10.30,-0.02,1567.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:19',10.29,-0.05,1488.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:20',10.28,-0.10,1510.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:21',10.27,-0.15,1475.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:22',10.27,0.06,1506.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:23',10.27,-0.02,1427.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:24',10.27,0.01,1540.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:25',10.27,-0.05,1430.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:26',10.27,0.05,1494.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:27',10.26,-0.09,1410.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:28',10.28,0.17,1519.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:29',10.27,-0.08,1479.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:30',10.28,0.08,1571.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:31',10.27,-0.07,1434.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:32',10.31,0.32,1569.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:33',10.30,-0.01,1441.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:34',10.31,0.02,1513.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:35',10.30,-0.09,1465.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:36',10.30,0.05,1555.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:37',10.30,0.01,1457.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:38',10.30,-0.07,1552.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:39',10.29,-0.08,1420.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:40',10.28,-0.13,1536.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:41',10.26,-0.18,1493.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:42',10.25,-0.10,1512.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:43',10.24,-0.09,1431.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:44',10.24,-0.01,1558.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:45',10.23,-0.04,1449.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:46',10.24,0.06,1502.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:47',10.24,0.02,1477.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:48',10.24,-0.04,1498.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:49',10.24,0.07,1456.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:50',10.23,-0.08,1589.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:51',10.23,-0.01,1470.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:52',10.25,0.20,1586.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:53',10.26,0.02,1472.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:54',10.25,-0.01,1535.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:55',10.25,-0.07,1463.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:56',10.25,0.03,1524.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:57',10.25,-0.01,1482.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:58',10.25,0.03,1588.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','10:59',10.25,0.00,1458.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:00',10.27,0.19,1530.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:01',10.27,-0.05,1421.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:02',10.26,-0.04,1511.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:03',10.27,0.05,1468.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:04',10.27,0.05,1576.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:05',10.27,0.00,1462.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:06',10.30,0.22,1500.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:07',10.31,0.13,1456.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:08',10.32,0.08,1531.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:09',10.31,-0.09,1459.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:10',10.30,-0.05,1517.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:11',10.29,-0.13,1437.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:12',10.29,0.00,1572.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:13',10.29,0.00,1449.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:14',10.29,-0.04,1503.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:15',10.28,-0.06,1425.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:16',10.28,0.03,1534.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:17',10.28,-0.04,1412.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:18',10.28,0.01,1522.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:19',10.29,0.13,1405.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:20',10.30,0.06,1515.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:21',10.31,0.06,1401.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:22',10.31,0.01,1567.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:23',10.31,0.05,1485.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:24',10.31,-0.05,1519.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:25',10.31,0.05,1472.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:26',10.33,0.17,1566.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:27',10.33,0.00,1459.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:28',10.33,0.03,1590.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','11:29',10.33,-0.02,1486.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:00',10.34,0.05,1554.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:01',10.34,0.07,1449.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:02',10.34,0.02,1576.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:03',10.33,-0.09,1480.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:04',10.34,0.01,1592.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:05',10.33,-0.02,1417.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:06',10.32,-0.09,1573.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:07',10.33,0.08,1465.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:08',10.33,0.02,1588.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:09',10.33,0.00,1394.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:10',10.34,0.07,1526.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:11',10.34,0.01,1457.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:12',10.34,0.01,1541.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:13',10.34,-0.04,1404.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:14',10.33,-0.11,1590.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:15',10.31,-0.14,1438.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:16',10.31,0.02,1572.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:17',10.30,-0.11,1451.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:18',10.29,-0.07,1507.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:19',10.29,-0.05,1483.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:20',10.28,-0.07,1579.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:21',10.28,0.00,1461.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:22',10.28,-0.00,1539.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:23',10.29,0.03,1421.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:24',10.28,-0.01,1578.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:25',10.28,-0.07,1412.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:26',10.27,-0.11,1566.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:27',10.26,-0.02,1451.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:28',10.26,0.00,1506.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:29',10.27,0.10,1407.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:30',10.28,0.10,1553.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:31',10.28,-0.00,1483.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:32',10.29,0.03,1539.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:33',10.29,-0.01,1405.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:34',10.29,0.02,1536.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:35',10.28,-0.06,1448.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:36',10.28,0.02,1577.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:37',10.28,-0.00,1466.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:38',10.29,0.03,1558.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:39',10.29,-0.01,1472.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:40',10.29,0.03,1521.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:41',10.28,-0.05,1471.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:42',10.28,-0.06,1588.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:43',10.27,-0.04,1439.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:44',10.27,-0.05,1539.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:45',10.26,-0.04,1396.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:46',10.26,-0.00,1573.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:47',10.27,0.01,1404.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:48',10.27,0.02,1549.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:49',10.26,-0.03,1454.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:50',10.26,-0.04,1576.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:51',10.27,0.12,1463.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:52',10.27,0.02,1554.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:53',10.28,0.00,1399.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:54',10.28,0.01,1543.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:55',10.28,0.01,1488.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:56',10.28,0.02,1510.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:57',10.28,0.02,1474.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:58',10.28,0.00,1533.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','13:59',10.29,0.04,1439.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:00',10.29,0.04,1569.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:01',10.29,0.03,1414.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:02',10.30,0.01,1508.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:03',10.29,-0.07,1422.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:04',10.29,0.02,1578.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:05',10.28,-0.11,1457.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:06',10.28,0.01,1571.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:07',10.28,-0.03,1479.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:08',10.28,0.02,1554.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:09',10.27,-0.06,1485.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:10',10.29,0.12,1540.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:11',10.29,0.03,1472.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:12',10.30,0.11,1504.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:13',10.30,0.03,1447.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:14',10.30,-0.07,1494.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:15',10.30,0.02,1440.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:16',10.30,0.02,1508.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:17',10.29,-0.05,1485.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:18',10.30,0.02,1512.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:19',10.29,-0.10,1431.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:20',10.29,0.02,1494.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:21',10.28,-0.12,1400.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:22',10.28,0.00,1546.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:23',10.27,-0.07,1441.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:24',10.27,0.00,1516.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:25',10.26,-0.06,1437.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:26',10.26,-0.07,1577.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:27',10.26,0.01,1405.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:28',10.25,-0.08,1555.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:29',10.24,-0.05,1456.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:30',10.24,-0.00,1526.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:31',10.25,0.01,1469.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:32',10.25,0.02,1509.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:33',10.25,0.05,1447.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:34',10.25,0.01,1571.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:35',10.24,-0.11,1489.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:36',10.25,0.04,1570.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:37',10.22,-0.28,1437.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:38',10.21,-0.09,1552.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:39',10.20,-0.06,1414.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:40',10.20,0.01,1545.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:41',10.20,-0.03,1451.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:42',10.19,-0.06,1561.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:43',10.20,0.04,1419.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:44',10.20,-0.01,1566.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:45',10.20,0.02,1407.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:46',10.21,0.07,1570.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:47',10.21,0.02,1419.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:48',10.22,0.10,1523.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:49',10.22,-0.03,1440.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:50',10.23,0.11,1515.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:51',10.23,-0.00,1412.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:52',10.23,0.06,1545.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:53',10.23,0.01,1401.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:54',10.24,0.02,1521.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:55',10.24,0.03,1452.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:56',10.24,-0.00,1501.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:57',10.24,0.01,1411.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:58',10.25,0.09,1560.00);
INSERT INTO `600000_RT` VALUES('2017-05-08','14:59',10.08,-1.64,1126.00);