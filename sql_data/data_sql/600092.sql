SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600092_RT`;
CREATE TABLE `600092_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600092`;
CREATE TABLE `600092` (
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

INSERT INTO `600092` VALUES('2017-01-05',6.97,8.37,8.37,6.97,9944,83091.0,0.00,0.00,0.01,1.068,0.668,0.134,1.288,0.620);
INSERT INTO `600092` VALUES('2017-01-06',9.21,9.21,9.21,9.21,7200,66312.0,10.04,0.00,0.01,2.000,1.250,0.250,2.507,1.256);
INSERT INTO `600092` VALUES('2017-01-09',10.13,10.13,10.13,10.13,5208,52757.0,9.99,0.00,0.01,2.825,1.766,0.353,3.679,1.914);
INSERT INTO `600092` VALUES('2017-01-10',11.14,11.14,11.14,11.14,12300,137022.0,9.97,0.00,0.01,3.568,2.230,0.446,4.827,2.597);
INSERT INTO `600092` VALUES('2017-01-11',12.25,12.25,12.25,12.25,10628,130193.0,9.96,0.00,0.01,4.251,2.657,0.531,5.969,3.312);
INSERT INTO `600092` VALUES('2017-01-12',13.48,13.48,13.48,13.48,28735,387348.0,10.04,0.00,0.03,4.895,3.059,0.612,7.125,4.065);
INSERT INTO `600092` VALUES('2017-01-13',14.83,14.83,14.83,14.83,93132,1381150.0,10.01,0.00,0.09,5.516,3.447,0.689,8.310,4.863);
INSERT INTO `600092` VALUES('2017-01-16',16.31,16.31,16.31,16.31,462267,7539580.0,9.98,0.00,0.46,6.128,3.830,0.766,9.541,5.711);
INSERT INTO `600092` VALUES('2017-01-17',17.94,17.94,17.94,17.94,204009,3659920.0,9.99,0.00,0.20,6.746,4.217,0.843,10.833,6.616);
INSERT INTO `600092` VALUES('2017-01-18',19.73,19.73,19.73,19.73,65696,1296180.0,9.98,0.00,0.07,7.382,4.614,0.923,12.202,7.588);
INSERT INTO `600092` VALUES('2017-01-19',21.70,21.70,21.70,21.70,3105899,6.7398E7,9.98,0.00,3.11,8.048,5.030,1.006,13.663,8.633);
INSERT INTO `600092` VALUES('2017-01-20',23.87,23.87,23.87,23.87,3790416,9.04772E7,10.00,0.00,3.79,8.754,5.471,1.094,15.233,9.762);
INSERT INTO `600092` VALUES('2017-01-23',26.26,26.26,26.26,26.26,177333,4656760.0,10.01,0.00,0.18,9.513,5.946,1.189,16.930,10.984);
INSERT INTO `600092` VALUES('2017-01-24',27.62,25.69,28.00,25.13,22488707,5.9889498E8,-2.17,0.11,22.49,9.927,6.204,1.241,18.277,12.073);
INSERT INTO `600092` VALUES('2017-01-25',24.69,25.28,25.97,24.60,16914323,4.28564E8,-1.60,0.05,16.91,10.085,6.303,1.261,19.355,13.052);
INSERT INTO `600092` VALUES('2017-01-26',25.62,26.04,26.47,25.28,13960494,3.62031008E8,3.01,0.05,13.96,10.191,6.370,1.274,20.383,14.014);
INSERT INTO `600092` VALUES('2017-02-03',25.85,25.95,26.49,25.66,9302119,2.42531008E8,-0.35,0.03,9.30,10.147,6.342,1.268,21.240,14.898);
INSERT INTO `600092` VALUES('2017-02-06',26.30,27.39,27.88,26.29,10039041,2.71159008E8,5.55,0.06,10.04,10.180,6.363,1.273,22.186,15.823);
INSERT INTO `600092` VALUES('2017-02-07',27.08,27.53,29.23,27.05,9247134,2.58047008E8,0.51,0.08,9.25,10.108,6.318,1.264,23.008,16.690);
INSERT INTO `600092` VALUES('2017-02-08',27.11,28.74,29.39,26.71,7883089,2.23244992E8,4.40,0.10,7.88,10.091,6.307,1.261,23.890,17.583);
INSERT INTO `600092` VALUES('2017-02-09',28.42,28.83,29.52,28.42,6805939,1.96423008E8,0.31,0.04,6.81,9.974,6.234,1.247,24.650,18.416);
INSERT INTO `600092` VALUES('2017-02-10',28.88,29.06,30.79,28.69,7585403,2.23952992E8,0.80,0.07,7.59,9.798,6.124,1.225,25.328,19.204);
INSERT INTO `600092` VALUES('2017-02-13',28.72,30.08,30.88,28.22,7900558,2.34144E8,3.51,0.09,7.90,9.679,6.049,1.210,26.059,20.010);
INSERT INTO `600092` VALUES('2017-02-14',29.87,33.09,33.09,29.87,12968642,4.13670016E8,10.01,0.11,12.97,9.859,6.162,1.232,27.141,20.979);
INSERT INTO `600092` VALUES('2017-02-15',33.66,32.07,35.46,31.78,14506578,4.89988E8,-3.08,0.11,14.51,9.758,6.099,1.220,27.899,21.801);
INSERT INTO `600092` VALUES('2017-02-16',31.85,31.53,33.13,30.40,9659269,3.06411008E8,-1.68,0.09,9.66,9.499,5.937,1.187,28.458,22.521);
INSERT INTO `600092` VALUES('2017-02-17',30.28,29.60,31.30,29.50,7328121,2.21734E8,-6.12,0.06,7.33,8.941,5.588,1.118,28.634,23.046);
INSERT INTO `600092` VALUES('2017-02-20',29.60,29.59,30.11,28.36,4648698,1.35742E8,-0.03,0.06,4.65,8.401,5.250,1.050,28.781,23.530);
INSERT INTO `600092` VALUES('2017-02-21',29.59,30.09,30.40,29.20,3720559,1.11682E8,1.69,0.04,3.72,7.945,4.966,0.993,28.982,24.016);
INSERT INTO `600092` VALUES('2017-02-22',29.96,30.10,30.58,29.50,3543105,1.06306E8,0.03,0.04,3.54,7.500,4.687,0.937,29.154,24.467);
INSERT INTO `600092` VALUES('2017-02-23',30.20,31.57,31.89,30.20,4954296,1.53551008E8,4.88,0.06,4.95,7.252,4.533,0.907,29.526,24.993);
INSERT INTO `600092` VALUES('2017-02-24',31.40,32.14,33.42,31.26,4919646,1.59808992E8,1.81,0.07,4.92,7.049,4.406,0.881,29.928,25.522);
INSERT INTO `600092` VALUES('2017-02-27',31.85,35.35,35.35,31.72,12132620,4.15996E8,9.99,0.11,12.13,7.219,4.512,0.902,30.762,26.250);
INSERT INTO `600092` VALUES('2017-02-28',35.00,34.32,35.50,33.60,11763365,4.10123008E8,-2.91,0.05,11.76,7.138,4.461,0.892,31.310,26.848);
INSERT INTO `600092` VALUES('2017-03-01',34.13,32.52,34.94,32.10,7961880,2.67112E8,-5.24,0.08,7.96,6.764,4.227,0.845,31.496,27.268);
INSERT INTO `600092` VALUES('2017-03-02',32.24,33.75,35.00,32.24,8709698,2.93920992E8,3.78,0.08,8.71,6.551,4.094,0.819,31.843,27.748);
INSERT INTO `600092` VALUES('2017-03-03',32.72,32.49,34.29,32.23,10022715,3.36559008E8,-3.73,0.06,10.02,6.148,3.843,0.769,31.942,28.100);
INSERT INTO `600092` VALUES('2017-03-06',32.51,33.52,33.56,31.71,5132006,1.68304992E8,3.17,0.06,5.13,5.894,3.684,0.737,32.185,28.501);
INSERT INTO `600092` VALUES('2017-03-07',33.52,36.87,36.87,33.36,14390856,5.12604992E8,9.99,0.10,14.39,6.055,3.785,0.757,32.906,29.121);
INSERT INTO `600092` VALUES('2017-03-08',36.50,38.06,39.60,35.72,15232209,5.7573901E8,3.23,0.11,15.23,6.265,3.915,0.783,33.699,29.783);
INSERT INTO `600092` VALUES('2017-03-09',37.99,34.25,37.99,34.25,12078079,4.22659008E8,-10.01,0.10,12.08,5.871,3.669,0.734,33.783,30.114);
INSERT INTO `600092` VALUES('2017-03-10',33.12,33.32,34.30,33.12,6988144,2.3498E8,-2.72,0.03,6.99,5.377,3.361,0.672,33.712,30.352);
INSERT INTO `600092` VALUES('2017-03-13',33.28,34.32,34.61,32.70,5053314,1.70346E8,3.00,0.06,5.05,5.056,3.160,0.632,33.806,30.646);
INSERT INTO `600092` VALUES('2017-03-14',34.22,34.59,35.58,34.04,5055291,1.76164E8,0.79,0.04,5.06,4.782,2.989,0.598,33.926,30.938);
INSERT INTO `600092` VALUES('2017-03-15',34.91,34.41,34.91,33.88,3537593,1.21705E8,-0.52,0.03,3.54,4.489,2.806,0.561,34.001,31.195);
INSERT INTO `600092` VALUES('2017-03-16',34.26,35.88,36.08,34.26,6032090,2.13740992E8,4.27,0.05,6.03,4.397,2.748,0.550,34.290,31.542);
INSERT INTO `600092` VALUES('2017-03-17',35.88,35.61,36.76,35.10,6535601,2.34635008E8,-0.75,0.05,6.54,4.239,2.650,0.530,34.493,31.843);
INSERT INTO `600092` VALUES('2017-03-20',34.98,36.61,36.64,34.61,5515478,1.98204E8,2.81,0.06,5.52,4.196,2.622,0.524,34.819,32.196);
INSERT INTO `600092` VALUES('2017-03-21',36.59,36.98,37.30,36.10,5343556,1.95823008E8,1.01,0.03,5.34,4.161,2.600,0.520,35.151,32.551);
INSERT INTO `600092` VALUES('2017-03-22',36.89,37.79,38.08,36.45,6526732,2.44276992E8,2.19,0.04,6.53,4.189,2.618,0.524,35.557,32.939);
INSERT INTO `600092` VALUES('2017-03-23',37.79,36.59,38.15,35.78,5614848,2.07248992E8,-3.18,0.06,5.61,4.011,2.507,0.501,35.716,33.209);
INSERT INTO `600092` VALUES('2017-03-24',36.51,37.94,38.64,36.30,6727233,2.53899008E8,3.69,0.06,6.73,3.998,2.498,0.500,36.058,33.560);
INSERT INTO `600092` VALUES('2017-03-27',38.48,37.26,38.49,36.60,4139260,1.54808992E8,-1.79,0.05,4.14,3.855,2.409,0.482,36.243,33.834);
INSERT INTO `600092` VALUES('2017-03-28',37.02,36.08,37.50,35.90,3375091,1.24008E8,-3.17,0.04,3.38,3.548,2.218,0.444,36.218,34.000);
INSERT INTO `600092` VALUES('2017-03-29',35.80,35.59,36.30,34.32,4814920,1.70762E8,-1.36,0.05,4.81,3.205,2.003,0.401,36.121,34.118);
INSERT INTO `600092` VALUES('2017-03-30',34.63,34.61,35.58,34.00,3225275,1.11675E8,-2.75,0.04,3.23,2.775,1.734,0.347,35.889,34.154);
INSERT INTO `600092` VALUES('2017-03-31',34.52,34.47,34.91,33.42,3824787,1.30042E8,-0.40,0.04,3.82,2.388,1.493,0.299,35.671,34.178);
INSERT INTO `600092` VALUES('2017-04-05',33.72,35.06,35.28,33.68,2269530,7.8741296E7,1.71,0.05,2.27,2.134,1.334,0.267,35.577,34.243);
INSERT INTO `600092` VALUES('2017-04-06',35.10,35.78,35.95,34.85,2415165,8.62756E7,2.05,0.03,2.42,2.002,1.251,0.250,35.608,34.357);
INSERT INTO `600092` VALUES('2017-04-07',35.60,34.76,36.07,34.60,2453131,8.6555E7,-2.85,0.04,2.45,1.745,1.091,0.218,35.477,34.387);
INSERT INTO `600092` VALUES('2017-04-10',34.55,34.51,35.26,33.60,2804978,9.6215504E7,-0.72,0.05,2.80,1.492,0.933,0.187,35.329,34.396);
INSERT INTO `600092` VALUES('2017-04-11',34.00,35.84,35.90,34.00,2824780,9.90766E7,3.85,0.06,2.82,1.447,0.904,0.181,35.407,34.503);
INSERT INTO `600092` VALUES('2017-04-12',35.82,35.82,36.07,35.01,1853291,6.61496E7,-0.06,0.03,1.85,1.393,0.870,0.174,35.471,34.600);
INSERT INTO `600092` VALUES('2017-04-13',35.86,36.52,37.20,35.52,2922028,1.06818E8,1.95,0.05,2.92,1.423,0.890,0.178,35.632,34.743);
INSERT INTO `600092` VALUES('2017-04-14',36.11,37.05,37.12,35.50,2668399,9.7840096E7,1.45,0.04,2.67,1.499,0.937,0.187,35.850,34.914);
INSERT INTO `600092` VALUES('2017-04-17',33.35,34.93,36.03,33.35,4025800,1.4068E8,-5.72,0.07,4.03,1.270,0.794,0.159,35.709,34.915);
INSERT INTO `600092` VALUES('2017-04-18',35.39,35.81,36.40,34.88,3558955,1.26852E8,2.52,0.04,3.56,1.189,0.743,0.149,35.724,34.981);
INSERT INTO `600092` VALUES('2017-04-19',35.81,35.69,35.81,34.00,2322079,8.19794E7,-0.34,0.05,2.32,1.097,0.685,0.137,35.719,35.034);
INSERT INTO `600092` VALUES('2017-04-20',35.78,35.37,36.10,34.70,1755013,6.19243E7,-0.90,0.04,1.76,0.971,0.607,0.121,35.665,35.059);
INSERT INTO `600092` VALUES('2017-04-21',35.64,35.82,36.00,34.70,1116837,3.97582E7,1.27,0.04,1.12,0.919,0.574,0.115,35.689,35.115);
INSERT INTO `600092` VALUES('2017-04-24',35.82,35.44,35.83,32.24,5253271,1.74228992E8,-1.06,0.10,5.25,0.819,0.512,0.102,35.651,35.139);
INSERT INTO `600092` VALUES('2017-04-25',35.00,35.77,35.89,34.30,2136919,7.5266704E7,0.93,0.04,2.14,0.773,0.483,0.097,35.669,35.186);
INSERT INTO `600092` VALUES('2017-04-26',35.77,36.28,36.49,35.77,1806228,6.54684E7,1.43,0.02,1.81,0.794,0.496,0.099,35.763,35.267);
INSERT INTO `600092` VALUES('2017-04-27',36.28,36.92,36.97,36.00,1881656,6.8738E7,1.76,0.03,1.88,0.883,0.552,0.110,35.941,35.389);
INSERT INTO `600092` VALUES('2017-04-28',36.95,36.92,37.20,36.00,2472148,9.05376E7,0.00,0.03,2.47,0.942,0.589,0.118,36.092,35.503);
INSERT INTO `600092` VALUES('2017-05-02',36.92,37.31,37.38,36.75,1256393,4.66955E7,1.06,0.02,1.26,1.028,0.643,0.129,36.279,35.637);
INSERT INTO `600092` VALUES('2017-05-03',37.31,38.26,40.26,37.01,2307013,8.7874704E7,2.55,0.09,2.31,1.205,0.753,0.151,36.584,35.831);
INSERT INTO `600092` VALUES('2017-05-04',38.23,38.95,39.26,37.25,2442267,9.4354496E7,1.80,0.05,2.44,1.418,0.886,0.177,36.948,36.062);
INSERT INTO `600092` VALUES('2017-05-05',38.90,38.82,39.55,38.31,1164586,4.52454E7,-0.33,0.03,1.16,1.552,0.970,0.194,37.236,36.266);
INSERT INTO `600092` VALUES('2017-05-08',38.90,38.76,38.98,38.30,842400,3.25409E7,-0.15,0.02,0.84,1.631,1.019,0.204,37.470,36.451);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:30',38.90,0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:31',38.43,-1.22,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:32',38.49,0.16,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:33',38.44,-0.14,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:34',38.41,-0.06,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:35',38.35,-0.16,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:36',38.32,-0.09,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:37',38.33,0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:38',38.32,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:39',38.32,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:40',38.34,0.06,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:41',38.37,0.09,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:42',38.36,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:43',38.33,-0.08,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:44',38.32,-0.04,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:45',38.30,-0.05,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:46',38.30,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:47',38.30,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:48',38.30,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:49',38.30,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:50',38.30,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:51',38.30,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:52',38.30,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:53',38.30,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:54',38.31,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:55',38.31,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:56',38.30,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:57',38.32,0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:58',38.32,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','09:59',38.34,0.05,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:00',38.35,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:01',38.35,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:02',38.36,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:03',38.38,0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:04',38.38,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:05',38.41,0.06,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:06',38.42,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:07',38.43,0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:08',38.45,0.06,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:09',38.48,0.06,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:10',38.47,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:11',38.46,-0.04,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:12',38.46,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:13',38.45,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:14',38.45,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:15',38.49,0.10,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:16',38.53,0.11,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:17',38.55,0.05,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:18',38.55,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:19',38.54,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:20',38.53,-0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:21',38.52,-0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:22',38.52,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:23',38.52,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:24',38.52,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:25',38.52,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:26',38.52,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:27',38.51,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:28',38.53,0.05,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:29',38.52,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:30',38.53,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:31',38.52,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:32',38.56,0.09,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:33',38.56,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:34',38.56,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:35',38.55,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:36',38.55,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:37',38.55,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:38',38.55,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:39',38.54,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:40',38.53,-0.03,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:41',38.51,-0.05,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:42',38.50,-0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:43',38.49,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:44',38.49,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:45',38.48,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:46',38.49,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:47',38.49,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:48',38.49,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:49',38.49,0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:50',38.48,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:51',38.48,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:52',38.50,0.05,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:53',38.51,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:54',38.50,-0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:55',38.50,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:56',38.50,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:57',38.50,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:58',38.50,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','10:59',38.50,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:00',38.52,0.05,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:01',38.52,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:02',38.51,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:03',38.52,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:04',38.52,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:05',38.52,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:06',38.55,0.06,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:07',38.56,0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:08',38.57,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:09',38.56,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:10',38.55,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:11',38.54,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:12',38.54,0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:13',38.54,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:14',38.54,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:15',38.53,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:16',38.53,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:17',38.53,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:18',38.53,0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:19',38.54,0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:20',38.55,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:21',38.56,0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:22',38.56,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:23',38.56,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:24',38.56,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:25',38.56,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:26',38.58,0.04,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:27',38.58,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:28',38.58,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','11:29',38.58,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:00',38.59,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:01',38.59,0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:02',38.59,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:03',38.58,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:04',38.58,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:05',38.58,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:06',38.57,-0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:07',38.58,0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:08',38.58,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:09',38.58,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:10',38.59,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:11',38.59,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:12',38.59,0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:13',38.59,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:14',38.58,-0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:15',38.56,-0.04,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:16',38.56,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:17',38.55,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:18',38.54,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:19',38.54,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:20',38.53,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:21',38.53,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:22',38.53,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:23',38.54,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:24',38.53,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:25',38.53,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:26',38.52,-0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:27',38.51,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:28',38.51,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:29',38.52,0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:30',38.53,0.03,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:31',38.53,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:32',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:33',38.54,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:34',38.54,0.00,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:35',38.53,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:36',38.53,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:37',38.53,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:38',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:39',38.54,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:40',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:41',38.53,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:42',38.53,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:43',38.52,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:44',38.52,-0.01,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:45',38.51,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:46',38.51,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:47',38.52,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:48',38.52,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:49',38.51,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:50',38.51,-0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:51',38.52,0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:52',38.52,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:53',38.53,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:54',38.53,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:55',38.53,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:56',38.53,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:57',38.53,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:58',38.53,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','13:59',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:00',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:01',38.54,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:02',38.55,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:03',38.54,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:04',38.54,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:05',38.53,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:06',38.53,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:07',38.53,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:08',38.53,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:09',38.52,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:10',38.54,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:11',38.54,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:12',38.55,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:13',38.55,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:14',38.55,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:15',38.55,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:16',38.55,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:17',38.54,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:18',38.55,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:19',38.54,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:20',38.54,0.01,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:21',38.53,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:22',38.53,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:23',38.52,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:24',38.52,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:25',38.51,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:26',38.51,-0.02,36.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:27',38.51,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:28',38.50,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:29',38.49,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:30',38.49,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:31',38.50,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:32',38.50,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:33',38.50,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:34',38.50,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:35',38.49,-0.03,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:36',38.50,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:37',38.47,-0.07,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:38',38.46,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:39',38.45,-0.02,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:40',38.45,0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:41',38.45,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:42',38.44,-0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:43',38.45,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:44',38.45,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:45',38.45,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:46',38.46,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:47',38.46,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:48',38.47,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:49',38.47,-0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:50',38.48,0.03,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:51',38.48,-0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:52',38.48,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:53',38.48,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:54',38.49,0.01,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:55',38.49,0.01,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:56',38.49,-0.00,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:57',38.49,0.00,34.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:58',38.50,0.02,35.00);
INSERT INTO `600092_RT` VALUES('2017-05-08','14:59',38.76,0.68,158.00);