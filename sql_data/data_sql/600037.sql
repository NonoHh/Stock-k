SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600037_RT`;
CREATE TABLE `600037_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600037`;
CREATE TABLE `600037` (
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

INSERT INTO `600037` VALUES('2016-10-11',16.82,20.19,20.19,16.82,18665,374824.0,0.00,0.00,0.02,2.577,1.611,0.322,3.106,1.496);
INSERT INTO `600037` VALUES('2016-10-12',22.21,22.21,22.21,22.21,6700,148807.0,10.00,0.00,0.01,4.824,3.015,0.603,6.045,3.030);
INSERT INTO `600037` VALUES('2016-10-13',24.43,24.43,24.43,24.43,5800,141694.0,10.00,0.00,0.01,6.814,4.258,0.852,8.874,4.615);
INSERT INTO `600037` VALUES('2016-10-14',26.87,26.87,26.87,26.87,10400,279448.0,9.99,0.00,0.01,8.606,5.379,1.076,11.642,6.264);
INSERT INTO `600037` VALUES('2016-10-17',29.56,29.56,29.56,29.56,12802,378427.0,10.01,0.00,0.01,10.255,6.410,1.282,14.399,7.989);
INSERT INTO `600037` VALUES('2016-10-18',32.52,32.52,32.52,32.52,22601,734985.0,10.01,0.00,0.02,11.809,7.380,1.476,17.187,9.806);
INSERT INTO `600037` VALUES('2016-10-19',35.77,35.77,35.77,35.77,65300,2335780.0,9.99,0.00,0.07,13.306,8.316,1.663,20.046,11.730);
INSERT INTO `600037` VALUES('2016-10-20',39.35,39.35,39.35,39.35,67400,2652190.0,10.01,0.00,0.07,14.784,9.240,1.848,23.016,13.776);
INSERT INTO `600037` VALUES('2016-10-21',43.29,43.29,43.29,43.29,239926,1.03864E7,10.01,0.00,0.24,16.277,10.173,2.035,26.135,15.962);
INSERT INTO `600037` VALUES('2016-10-24',43.29,41.66,43.29,40.21,20726165,8.5946202E8,-3.77,0.07,20.73,17.053,10.658,2.132,28.523,17.865);
INSERT INTO `600037` VALUES('2016-10-25',41.15,45.83,45.83,40.80,18424111,8.0955501E8,10.01,0.12,18.42,17.998,11.249,2.250,31.186,19.937);
INSERT INTO `600037` VALUES('2016-10-26',45.30,44.05,45.62,43.60,16528897,7.3589101E8,-3.88,0.04,16.53,18.307,11.442,2.288,33.165,21.723);
INSERT INTO `600037` VALUES('2016-10-27',45.10,45.81,47.54,44.69,15832079,7.2853197E8,4.00,0.06,15.83,18.565,11.603,2.321,35.110,23.507);
INSERT INTO `600037` VALUES('2016-10-28',45.50,49.71,50.39,45.11,21242097,1.04190003E9,8.51,0.12,21.24,19.053,11.908,2.382,37.356,25.448);
INSERT INTO `600037` VALUES('2016-10-31',47.97,47.98,48.47,46.50,13321070,6.3179898E8,-3.48,0.04,13.32,18.998,11.874,2.375,38.991,27.117);
INSERT INTO `600037` VALUES('2016-11-01',47.36,48.79,50.40,47.13,13486216,6.6188198E8,1.69,0.07,13.49,18.841,11.776,2.355,40.498,28.723);
INSERT INTO `600037` VALUES('2016-11-02',47.85,50.24,52.77,47.15,15483153,7.6923501E8,2.97,0.12,15.48,18.689,11.681,2.336,41.997,30.316);
INSERT INTO `600037` VALUES('2016-11-03',49.69,48.96,52.44,48.68,14642025,7.4157702E8,-2.55,0.07,14.64,18.193,11.371,2.274,43.068,31.697);
INSERT INTO `600037` VALUES('2016-11-04',48.13,49.98,50.12,48.11,10135342,4.98103008E8,2.08,0.04,10.14,17.728,11.080,2.216,44.132,33.052);
INSERT INTO `600037` VALUES('2016-11-07',50.36,50.91,51.87,49.20,9700491,4.91793984E8,1.86,0.05,9.70,17.280,10.800,2.160,45.174,34.375);
INSERT INTO `600037` VALUES('2016-11-08',50.85,50.48,51.14,49.80,7186491,3.62759008E8,-0.84,0.03,7.19,16.677,10.423,2.085,45.991,35.568);
INSERT INTO `600037` VALUES('2016-11-09',50.28,51.41,52.55,49.07,12791177,6.5315501E8,1.84,0.07,12.79,16.133,10.083,2.017,46.824,36.741);
INSERT INTO `600037` VALUES('2016-11-10',51.80,56.55,56.55,51.46,12306126,6.7325798E8,10.00,0.10,12.31,16.180,10.112,2.022,48.321,38.208);
INSERT INTO `600037` VALUES('2016-11-11',58.30,59.94,62.21,57.70,20918861,1.26721997E9,5.99,0.08,20.92,16.464,10.290,2.058,50.108,39.818);
INSERT INTO `600037` VALUES('2016-11-14',58.09,57.76,59.50,55.55,11794069,6.8078099E8,-3.64,0.07,11.79,16.221,10.138,2.028,51.285,41.147);
INSERT INTO `600037` VALUES('2016-11-15',57.40,56.14,58.50,56.00,7177143,4.07481984E8,-2.80,0.04,7.18,15.639,9.775,1.955,52.032,42.258);
INSERT INTO `600037` VALUES('2016-11-16',56.25,52.38,56.40,52.00,10189510,5.47544E8,-6.70,0.08,10.19,14.525,9.078,1.816,52.086,43.008);
INSERT INTO `600037` VALUES('2016-11-17',51.93,53.09,53.90,51.93,6061393,3.22088E8,1.36,0.04,6.06,13.577,8.486,1.697,52.240,43.754);
INSERT INTO `600037` VALUES('2016-11-18',53.00,53.25,54.97,52.90,5636504,3.03489984E8,0.30,0.04,5.64,12.701,7.938,1.588,52.396,44.458);
INSERT INTO `600037` VALUES('2016-11-21',53.26,53.84,53.99,51.34,6775622,3.55950016E8,1.11,0.05,6.78,11.944,7.465,1.493,52.618,45.153);
INSERT INTO `600037` VALUES('2016-11-22',53.86,54.52,55.15,53.50,7113870,3.86363008E8,1.26,0.03,7.11,11.302,7.064,1.413,52.910,45.847);
INSERT INTO `600037` VALUES('2016-11-23',54.50,52.43,55.08,52.10,5554249,2.97196E8,-3.83,0.05,5.55,10.404,6.502,1.300,52.837,46.334);
INSERT INTO `600037` VALUES('2016-11-24',52.05,50.62,52.80,50.05,5487023,2.81510016E8,-3.45,0.05,5.49,9.350,5.844,1.169,52.496,46.652);
INSERT INTO `600037` VALUES('2016-11-25',50.50,51.03,51.36,48.40,4276470,2.13643008E8,0.81,0.06,4.28,8.470,5.294,1.059,52.270,46.976);
INSERT INTO `600037` VALUES('2016-11-28',50.83,49.60,50.83,49.50,2493395,1.24631E8,-2.80,0.03,2.49,7.502,4.689,0.938,51.859,47.170);
INSERT INTO `600037` VALUES('2016-11-29',49.50,47.45,49.98,47.30,3314873,1.61568992E8,-4.33,0.05,3.31,6.384,3.990,0.798,51.181,47.191);
INSERT INTO `600037` VALUES('2016-11-30',47.40,47.20,47.69,46.35,2635739,1.2385E8,-0.53,0.03,2.64,5.403,3.377,0.675,50.568,47.192);
INSERT INTO `600037` VALUES('2016-12-01',47.26,48.79,49.50,47.26,4107960,1.98804992E8,3.37,0.05,4.11,4.776,2.985,0.597,50.295,47.310);
INSERT INTO `600037` VALUES('2016-12-02',48.50,47.89,49.72,47.80,4209876,2.06112992E8,-1.84,0.04,4.21,4.115,2.572,0.514,49.925,47.353);
INSERT INTO `600037` VALUES('2016-12-05',46.60,46.55,47.74,46.31,2473012,1.15964E8,-2.80,0.03,2.47,3.379,2.112,0.422,49.406,47.294);
INSERT INTO `600037` VALUES('2016-12-06',46.98,47.25,47.97,46.80,2178726,1.03269E8,1.50,0.03,2.18,2.854,1.784,0.357,49.074,47.290);
INSERT INTO `600037` VALUES('2016-12-07',47.31,48.65,48.67,46.70,2914377,1.39203008E8,2.96,0.04,2.91,2.588,1.618,0.324,49.009,47.391);
INSERT INTO `600037` VALUES('2016-12-08',48.31,47.12,48.85,47.05,2648612,1.27184E8,-3.14,0.04,2.65,2.155,1.347,0.269,48.718,47.371);
INSERT INTO `600037` VALUES('2016-12-09',46.90,45.94,47.28,45.51,3079246,1.42508E8,-2.50,0.04,3.08,1.641,1.026,0.205,48.291,47.265);
INSERT INTO `600037` VALUES('2016-12-12',45.80,42.33,45.80,41.86,3719422,1.61363008E8,-7.86,0.09,3.72,0.759,0.474,0.095,47.374,46.899);
INSERT INTO `600037` VALUES('2016-12-13',42.02,42.58,43.23,41.23,2252948,9.5171104E7,0.59,0.05,2.25,0.091,0.057,0.011,46.636,46.580);
INSERT INTO `600037` VALUES('2016-12-14',42.20,41.50,42.56,41.40,1792829,7.51686E7,-2.54,0.03,1.79,-0.572,-0.357,-0.071,45.846,46.203);
INSERT INTO `600037` VALUES('2016-12-15',41.50,41.98,42.79,41.15,2007857,8.46228E7,1.16,0.04,2.01,-1.023,-0.639,-0.128,45.251,45.890);
INSERT INTO `600037` VALUES('2016-12-16',42.20,42.76,43.15,41.80,2055806,8.7244896E7,1.86,0.03,2.06,-1.265,-0.791,-0.158,44.868,45.659);
INSERT INTO `600037` VALUES('2016-12-19',42.67,42.07,42.70,41.88,1387586,5.84397E7,-1.61,0.02,1.39,-1.528,-0.955,-0.191,44.438,45.393);
INSERT INTO `600037` VALUES('2016-12-20',41.89,42.38,42.55,41.30,1357168,5.73053E7,0.74,0.03,1.36,-1.678,-1.049,-0.210,44.121,45.170);
INSERT INTO `600037` VALUES('2016-12-21',42.37,42.77,42.80,42.00,1788434,7.5964304E7,0.92,0.02,1.79,-1.726,-1.079,-0.216,43.913,44.992);
INSERT INTO `600037` VALUES('2016-12-22',42.85,43.19,43.24,42.25,2556738,1.09116E8,0.98,0.02,2.56,-1.690,-1.056,-0.211,43.802,44.858);
INSERT INTO `600037` VALUES('2016-12-23',43.00,41.23,43.15,41.20,2299011,9.67528E7,-4.54,0.05,2.30,-1.893,-1.183,-0.237,43.406,44.590);
INSERT INTO `600037` VALUES('2016-12-26',40.50,41.00,41.38,39.35,2020120,8.1128096E7,-0.56,0.05,2.02,-2.060,-1.288,-0.258,43.036,44.324);
INSERT INTO `600037` VALUES('2016-12-27',40.78,40.77,41.38,40.51,1396874,5.71595E7,-0.56,0.02,1.40,-2.197,-1.373,-0.275,42.687,44.060);
INSERT INTO `600037` VALUES('2016-12-28',40.65,40.51,41.00,40.45,1255270,5.1137E7,-0.64,0.01,1.26,-2.312,-1.445,-0.289,42.352,43.797);
INSERT INTO `600037` VALUES('2016-12-29',40.65,40.48,40.98,40.31,959613,3.90062E7,-0.07,0.02,0.96,-2.380,-1.487,-0.297,42.064,43.552);
INSERT INTO `600037` VALUES('2016-12-30',40.50,40.33,40.75,40.16,982992,3.97345E7,-0.37,0.01,0.98,-2.425,-1.516,-0.303,41.798,43.313);
INSERT INTO `600037` VALUES('2017-01-03',40.60,41.16,41.34,40.14,2019663,8.25476E7,2.06,0.03,2.02,-2.327,-1.454,-0.291,41.699,43.154);
INSERT INTO `600037` VALUES('2017-01-04',41.16,41.26,41.38,40.68,1695117,6.9614704E7,0.24,0.02,1.70,-2.210,-1.381,-0.276,41.632,43.013);
INSERT INTO `600037` VALUES('2017-01-05',41.20,40.36,41.29,40.33,1672306,6.81752E7,-2.18,0.02,1.67,-2.209,-1.381,-0.276,41.436,42.817);
INSERT INTO `600037` VALUES('2017-01-06',40.38,38.34,40.38,38.32,2889745,1.1282E8,-5.00,0.05,2.89,-2.441,-1.525,-0.305,40.960,42.485);
INSERT INTO `600037` VALUES('2017-01-09',38.20,37.65,38.37,37.04,2042481,7.65898E7,-1.80,0.03,2.04,-2.682,-1.676,-0.335,40.451,42.127);
INSERT INTO `600037` VALUES('2017-01-10',37.60,36.98,37.93,36.93,1413546,5.29425E7,-1.78,0.03,1.41,-2.926,-1.829,-0.366,39.917,41.746);
INSERT INTO `600037` VALUES('2017-01-11',36.80,35.68,36.90,35.66,2380235,8.6049696E7,-3.52,0.03,2.38,-3.250,-2.032,-0.406,39.265,41.296);
INSERT INTO `600037` VALUES('2017-01-12',35.52,35.38,36.15,35.20,1337657,4.77267E7,-0.84,0.03,1.34,-3.506,-2.191,-0.438,38.667,40.858);
INSERT INTO `600037` VALUES('2017-01-13',35.36,34.43,35.65,34.00,1944436,6.70857E7,-2.69,0.05,1.94,-3.787,-2.367,-0.473,38.015,40.382);
INSERT INTO `600037` VALUES('2017-01-16',34.37,32.69,34.39,31.23,2275708,7.5215504E7,-5.05,0.09,2.28,-4.186,-2.616,-0.523,37.196,39.812);
INSERT INTO `600037` VALUES('2017-01-17',32.69,34.45,34.60,31.71,3043399,1.01692E8,5.38,0.09,3.04,-4.226,-2.641,-0.528,36.774,39.415);
INSERT INTO `600037` VALUES('2017-01-18',34.02,32.89,34.34,32.82,1848591,6.18548E7,-4.53,0.04,1.85,-4.409,-2.756,-0.551,36.176,38.932);
INSERT INTO `600037` VALUES('2017-01-19',32.50,33.23,33.80,32.02,2030858,6.74694E7,1.03,0.05,2.03,-4.458,-2.786,-0.557,35.723,38.509);
INSERT INTO `600037` VALUES('2017-01-20',33.24,34.08,34.48,33.01,2078612,7.0789104E7,2.56,0.04,2.08,-4.338,-2.711,-0.542,35.470,38.181);
INSERT INTO `600037` VALUES('2017-01-23',34.38,34.13,34.70,33.96,1787281,6.13107E7,0.15,0.02,1.79,-4.188,-2.617,-0.523,35.264,37.881);
INSERT INTO `600037` VALUES('2017-01-24',34.13,33.28,34.20,33.02,1302841,4.38739E7,-2.49,0.03,1.30,-4.131,-2.582,-0.516,34.959,37.540);
INSERT INTO `600037` VALUES('2017-01-25',33.28,34.17,34.24,33.15,1534987,5.19032E7,2.67,0.03,1.53,-3.925,-2.453,-0.491,34.837,37.291);
INSERT INTO `600037` VALUES('2017-01-26',34.07,34.28,34.50,33.80,1309896,4.46676E7,0.32,0.02,1.31,-3.706,-2.316,-0.463,34.752,37.068);
INSERT INTO `600037` VALUES('2017-02-03',34.26,33.84,34.27,33.55,878500,2.97003E7,-1.28,0.02,0.88,-3.548,-2.217,-0.443,34.611,36.829);
INSERT INTO `600037` VALUES('2017-02-06',33.99,35.06,35.25,33.84,2323047,8.0658E7,3.61,0.04,2.32,-3.227,-2.017,-0.403,34.680,36.698);
INSERT INTO `600037` VALUES('2017-02-07',35.00,35.16,35.37,34.60,2249907,7.89158E7,0.29,0.02,2.25,-2.927,-1.830,-0.366,34.754,36.584);
INSERT INTO `600037` VALUES('2017-02-08',35.14,35.68,35.85,34.75,2024551,7.1759904E7,1.48,0.03,2.02,-2.592,-1.620,-0.324,34.897,36.517);
INSERT INTO `600037` VALUES('2017-02-09',35.50,35.84,36.33,35.40,2106181,7.57792E7,0.45,0.03,2.11,-2.280,-1.425,-0.285,35.042,36.467);
INSERT INTO `600037` VALUES('2017-02-10',35.61,34.90,35.85,34.87,1752835,6.18645E7,-2.62,0.03,1.75,-2.129,-1.331,-0.266,35.020,36.351);
INSERT INTO `600037` VALUES('2017-02-13',34.88,36.52,36.60,34.88,2653540,9.5827104E7,4.64,0.05,2.65,-1.780,-1.112,-0.222,35.251,36.363);
INSERT INTO `600037` VALUES('2017-02-14',36.80,36.56,36.85,36.10,2204076,8.0295296E7,0.11,0.02,2.20,-1.481,-0.926,-0.185,35.452,36.378);
INSERT INTO `600037` VALUES('2017-02-15',36.26,36.73,37.50,36.25,3002857,1.1117E8,0.46,0.03,3.00,-1.208,-0.755,-0.151,35.649,36.404);
INSERT INTO `600037` VALUES('2017-02-16',36.45,36.66,36.73,36.21,1539384,5.60965E7,-0.19,0.01,1.54,-0.990,-0.618,-0.124,35.804,36.423);
INSERT INTO `600037` VALUES('2017-02-17',36.74,36.24,37.49,36.17,1867665,6.8711E7,-1.15,0.04,1.87,-0.861,-0.538,-0.108,35.871,36.409);
INSERT INTO `600037` VALUES('2017-02-20',35.31,35.64,35.97,35.00,1603187,5.67647E7,-1.66,0.03,1.60,-0.826,-0.517,-0.103,35.836,36.352);
INSERT INTO `600037` VALUES('2017-02-21',35.49,35.96,36.13,35.49,1090080,3.91192E7,0.90,0.02,1.09,-0.749,-0.468,-0.094,35.855,36.323);
INSERT INTO `600037` VALUES('2017-02-22',36.00,36.31,37.30,35.92,1804700,6.59809E7,0.97,0.04,1.80,-0.636,-0.397,-0.079,35.925,36.322);
INSERT INTO `600037` VALUES('2017-02-23',36.23,36.63,36.86,35.96,1528900,5.56429E7,0.88,0.02,1.53,-0.499,-0.312,-0.062,36.033,36.345);
INSERT INTO `600037` VALUES('2017-02-24',36.75,37.91,37.97,36.52,3671806,1.37526E8,3.49,0.04,3.67,-0.222,-0.139,-0.028,36.322,36.461);
INSERT INTO `600037` VALUES('2017-02-27',37.84,37.21,38.50,37.05,2833067,1.07175E8,-1.85,0.04,2.83,-0.092,-0.058,-0.012,36.459,36.516);
INSERT INTO `600037` VALUES('2017-02-28',37.22,37.65,37.69,36.66,1700926,6.34211E7,1.18,0.03,1.70,0.067,0.042,0.008,36.642,36.600);
INSERT INTO `600037` VALUES('2017-03-01',37.50,37.44,38.18,37.40,1560666,5.88312E7,-0.56,0.02,1.56,0.163,0.102,0.020,36.765,36.663);
INSERT INTO `600037` VALUES('2017-03-02',37.42,36.91,37.71,36.90,1422209,5.28509E7,-1.42,0.02,1.42,0.170,0.106,0.021,36.787,36.681);
INSERT INTO `600037` VALUES('2017-03-03',36.72,36.92,37.12,36.48,1075152,3.96562E7,0.03,0.02,1.08,0.174,0.109,0.022,36.808,36.699);
INSERT INTO `600037` VALUES('2017-03-06',36.92,38.02,38.04,36.73,1917143,7.2218304E7,2.98,0.04,1.92,0.316,0.198,0.040,36.994,36.797);
INSERT INTO `600037` VALUES('2017-03-07',38.08,38.57,38.58,37.63,3287983,1.25467E8,1.45,0.02,3.29,0.494,0.309,0.062,37.237,36.928);
INSERT INTO `600037` VALUES('2017-03-08',38.21,38.70,39.08,38.21,3170518,1.22784E8,0.34,0.02,3.17,0.644,0.403,0.081,37.462,37.059);
INSERT INTO `600037` VALUES('2017-03-09',38.75,39.33,39.49,38.15,4154685,1.61527008E8,1.63,0.03,4.15,0.835,0.522,0.104,37.749,37.227);
INSERT INTO `600037` VALUES('2017-03-10',39.20,39.10,39.66,38.79,3348329,1.31308E8,-0.58,0.02,3.35,0.945,0.591,0.118,37.957,37.366);
INSERT INTO `600037` VALUES('2017-03-13',38.91,39.14,39.16,38.12,2657209,1.02579E8,0.10,0.03,2.66,1.026,0.641,0.128,38.139,37.497);
INSERT INTO `600037` VALUES('2017-03-14',38.91,38.46,39.20,38.30,2184753,8.4691696E7,-1.74,0.02,2.18,0.991,0.620,0.124,38.188,37.569);
INSERT INTO `600037` VALUES('2017-03-15',38.48,38.76,39.04,38.30,2263602,8.745E7,0.78,0.02,2.26,0.991,0.619,0.124,38.276,37.657);
INSERT INTO `600037` VALUES('2017-03-16',38.81,39.57,39.87,38.70,4030289,1.5864E8,2.09,0.03,4.03,1.083,0.677,0.135,38.475,37.799);
INSERT INTO `600037` VALUES('2017-03-17',39.42,38.02,39.80,37.95,4507787,1.75427008E8,-3.92,0.05,4.51,0.944,0.590,0.118,38.405,37.815);
INSERT INTO `600037` VALUES('2017-03-20',37.95,38.37,38.40,37.40,2345681,8.8771296E7,0.92,0.03,2.35,0.870,0.544,0.109,38.400,37.856);
INSERT INTO `600037` VALUES('2017-03-21',38.37,38.97,38.98,38.20,2496477,9.62424E7,1.56,0.02,2.50,0.878,0.549,0.110,38.488,37.939);
INSERT INTO `600037` VALUES('2017-03-22',38.63,38.89,39.16,38.12,2657369,1.02825E8,-0.21,0.03,2.66,0.864,0.540,0.108,38.549,38.009);
INSERT INTO `600037` VALUES('2017-03-23',38.82,39.89,40.00,38.30,5447121,2.1437E8,2.57,0.04,5.45,0.972,0.607,0.121,38.756,38.148);
INSERT INTO `600037` VALUES('2017-03-24',39.88,39.49,40.06,39.22,3151359,1.24849E8,-1.00,0.02,3.15,0.993,0.621,0.124,38.869,38.248);
INSERT INTO `600037` VALUES('2017-03-27',39.32,38.89,39.60,38.76,1981082,7.7337104E7,-1.52,0.02,1.98,0.922,0.577,0.115,38.872,38.295);
INSERT INTO `600037` VALUES('2017-03-28',38.71,38.13,39.20,38.11,1858914,7.17488E7,-1.95,0.03,1.86,0.759,0.475,0.095,38.758,38.283);
INSERT INTO `600037` VALUES('2017-03-29',38.00,35.21,38.35,35.16,4271824,1.55507008E8,-7.66,0.08,4.27,0.250,0.156,0.031,38.212,38.056);
INSERT INTO `600037` VALUES('2017-03-30',35.24,33.83,35.30,33.58,2627354,8.94738E7,-3.92,0.05,2.63,-0.327,-0.205,-0.041,37.538,37.743);
INSERT INTO `600037` VALUES('2017-03-31',33.78,34.05,34.25,33.60,1211056,4.116E7,0.65,0.02,1.21,-0.748,-0.468,-0.094,37.001,37.469);
INSERT INTO `600037` VALUES('2017-04-05',34.06,34.61,34.80,33.87,1192618,4.1081E7,1.64,0.03,1.19,-0.998,-0.624,-0.125,36.633,37.257);
INSERT INTO `600037` VALUES('2017-04-06',34.70,34.68,35.06,34.60,1116221,3.88556E7,0.20,0.01,1.12,-1.174,-0.733,-0.147,36.333,37.066);
INSERT INTO `600037` VALUES('2017-04-07',34.61,34.10,34.85,34.01,1141801,3.91591E7,-1.67,0.02,1.14,-1.372,-0.857,-0.171,35.989,36.847);
INSERT INTO `600037` VALUES('2017-04-10',33.91,31.91,33.95,31.86,2559888,8.37448E7,-6.42,0.06,2.56,-1.791,-1.119,-0.224,35.362,36.481);
INSERT INTO `600037` VALUES('2017-04-11',31.81,32.81,32.97,31.70,1356624,4.38079E7,2.82,0.04,1.36,-1.984,-1.240,-0.248,34.969,36.209);
INSERT INTO `600037` VALUES('2017-04-12',32.79,32.18,32.88,32.02,966780,3.14765E7,-1.92,0.03,0.97,-2.193,-1.370,-0.274,34.540,35.911);
INSERT INTO `600037` VALUES('2017-04-13',32.18,32.61,32.89,32.18,680640,2.21964E7,1.34,0.02,0.68,-2.277,-1.423,-0.285,34.243,35.666);
INSERT INTO `600037` VALUES('2017-04-14',32.62,32.00,32.62,31.94,726116,2.33174E7,-1.87,0.02,0.73,-2.394,-1.496,-0.299,33.898,35.395);
INSERT INTO `600037` VALUES('2017-04-17',31.60,30.76,31.60,30.53,1180764,3.6376E7,-3.87,0.03,1.18,-2.618,-1.636,-0.327,33.415,35.051);
INSERT INTO `600037` VALUES('2017-04-18',30.70,30.26,31.34,30.25,819592,2.5241E7,-1.63,0.04,0.82,-2.826,-1.766,-0.353,32.930,34.696);
INSERT INTO `600037` VALUES('2017-04-19',30.28,31.16,31.25,30.02,1052787,3.23338E7,2.97,0.04,1.05,-2.843,-1.777,-0.355,32.658,34.434);
INSERT INTO `600037` VALUES('2017-04-20',31.16,31.01,31.25,30.53,856332,2.64945E7,-0.48,0.02,0.86,-2.843,-1.777,-0.355,32.404,34.181);
INSERT INTO `600037` VALUES('2017-04-21',31.00,31.01,31.15,30.87,578445,1.79197E7,0.00,0.01,0.58,-2.810,-1.756,-0.351,32.190,33.946);
INSERT INTO `600037` VALUES('2017-04-24',31.34,30.35,31.34,30.15,708409,2.16988E7,-2.13,0.04,0.71,-2.837,-1.773,-0.355,31.907,33.679);
INSERT INTO `600037` VALUES('2017-04-25',30.66,30.92,31.10,30.54,665226,2.05622E7,1.88,0.02,0.67,-2.752,-1.720,-0.344,31.755,33.475);
INSERT INTO `600037` VALUES('2017-04-26',30.92,31.36,31.57,30.80,932886,2.92115E7,1.42,0.02,0.93,-2.599,-1.624,-0.325,31.694,33.318);
INSERT INTO `600037` VALUES('2017-04-27',31.36,32.17,32.29,30.86,1739245,5.50617E7,2.58,0.05,1.74,-2.346,-1.466,-0.293,31.767,33.233);
INSERT INTO `600037` VALUES('2017-04-28',32.05,32.11,32.34,31.77,1099112,3.51921E7,-0.19,0.02,1.10,-2.128,-1.330,-0.266,31.820,33.150);
INSERT INTO `600037` VALUES('2017-05-02',32.30,31.97,32.35,31.89,695241,2.22568E7,-0.44,0.01,0.70,-1.951,-1.220,-0.244,31.843,33.063);
INSERT INTO `600037` VALUES('2017-05-03',31.97,32.30,32.31,31.70,1015496,3.2633E7,1.03,0.02,1.02,-1.749,-1.093,-0.219,31.913,33.006);
INSERT INTO `600037` VALUES('2017-05-04',32.16,31.84,32.32,31.80,950500,3.045E7,-1.42,0.02,0.95,-1.628,-1.018,-0.204,31.902,32.920);
INSERT INTO `600037` VALUES('2017-05-05',31.70,31.00,31.73,30.90,958081,2.99881E7,-2.64,0.03,0.96,-1.623,-1.014,-0.203,31.763,32.778);
INSERT INTO `600037` VALUES('2017-05-08',30.92,30.18,31.19,30.15,599900,1.83479E7,-2.65,0.03,0.60,-1.705,-1.065,-0.213,31.520,32.585);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:30',30.92,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:31',30.28,-2.08,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:32',30.34,0.20,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:33',30.29,-0.17,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:34',30.26,-0.07,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:35',30.20,-0.20,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:36',30.17,-0.11,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:37',30.18,0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:38',30.17,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:39',30.17,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:40',30.19,0.07,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:41',30.22,0.11,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:42',30.21,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:43',30.18,-0.10,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:44',30.17,-0.05,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:45',30.15,-0.06,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:46',30.15,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:47',30.15,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:48',30.15,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:49',30.15,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:50',30.15,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:51',30.15,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:52',30.15,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:53',30.15,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:54',30.16,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:55',30.16,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:56',30.15,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:57',30.17,0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:58',30.17,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','09:59',30.19,0.06,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:00',30.20,0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:01',30.20,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:02',30.21,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:03',30.23,0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:04',30.23,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:05',30.26,0.08,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:06',30.27,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:07',30.28,0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:08',30.30,0.08,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:09',30.33,0.07,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:10',30.32,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:11',30.31,-0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:12',30.31,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:13',30.30,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:14',30.30,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:15',30.34,0.12,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:16',30.38,0.14,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:17',30.40,0.07,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:18',30.40,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:19',30.39,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:20',30.38,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:21',30.37,-0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:22',30.37,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:23',30.37,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:24',30.37,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:25',30.37,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:26',30.37,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:27',30.36,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:28',30.38,0.06,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:29',30.37,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:30',30.38,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:31',30.37,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:32',30.41,0.11,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:33',30.40,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:34',30.41,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:35',30.40,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:36',30.40,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:37',30.40,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:38',30.40,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:39',30.39,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:40',30.38,-0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:41',30.36,-0.06,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:42',30.35,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:43',30.34,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:44',30.34,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:45',30.33,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:46',30.34,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:47',30.34,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:48',30.34,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:49',30.34,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:50',30.33,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:51',30.33,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:52',30.35,0.07,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:53',30.36,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:54',30.35,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:55',30.35,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:56',30.35,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:57',30.35,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:58',30.35,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','10:59',30.35,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:00',30.37,0.06,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:01',30.37,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:02',30.36,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:03',30.37,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:04',30.37,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:05',30.37,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:06',30.40,0.07,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:07',30.41,0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:08',30.42,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:09',30.41,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:10',30.40,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:11',30.39,-0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:12',30.39,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:13',30.39,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:14',30.39,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:15',30.38,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:16',30.38,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:17',30.38,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:18',30.38,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:19',30.39,0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:20',30.40,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:21',30.41,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:22',30.41,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:23',30.41,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:24',30.41,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:25',30.41,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:26',30.43,0.06,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:27',30.43,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:28',30.43,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','11:29',30.43,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:00',30.44,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:01',30.44,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:02',30.44,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:03',30.43,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:04',30.43,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:05',30.43,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:06',30.42,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:07',30.43,0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:08',30.43,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:09',30.43,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:10',30.44,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:11',30.44,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:12',30.44,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:13',30.44,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:14',30.43,-0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:15',30.41,-0.05,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:16',30.41,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:17',30.40,-0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:18',30.39,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:19',30.39,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:20',30.38,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:21',30.38,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:22',30.38,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:23',30.39,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:24',30.38,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:25',30.38,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:26',30.37,-0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:27',30.36,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:28',30.36,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:29',30.37,0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:30',30.38,0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:31',30.38,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:32',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:33',30.39,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:34',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:35',30.38,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:36',30.38,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:37',30.38,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:38',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:39',30.39,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:40',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:41',30.38,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:42',30.38,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:43',30.37,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:44',30.37,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:45',30.36,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:46',30.36,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:47',30.37,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:48',30.37,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:49',30.36,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:50',30.36,-0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:51',30.37,0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:52',30.37,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:53',30.38,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:54',30.38,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:55',30.38,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:56',30.38,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:57',30.38,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:58',30.38,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','13:59',30.39,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:00',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:01',30.39,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:02',30.40,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:03',30.39,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:04',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:05',30.38,-0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:06',30.38,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:07',30.38,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:08',30.38,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:09',30.37,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:10',30.39,0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:11',30.39,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:12',30.40,0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:13',30.40,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:14',30.40,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:15',30.40,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:16',30.40,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:17',30.39,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:18',30.40,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:19',30.39,-0.03,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:20',30.39,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:21',30.38,-0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:22',30.38,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:23',30.37,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:24',30.37,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:25',30.36,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:26',30.36,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:27',30.36,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:28',30.35,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:29',30.34,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:30',30.34,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:31',30.35,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:32',30.35,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:33',30.35,0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:34',30.35,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:35',30.34,-0.04,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:36',30.35,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:37',30.32,-0.09,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:38',30.31,-0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:39',30.30,-0.02,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:40',30.30,0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:41',30.30,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:42',30.29,-0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:43',30.30,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:44',30.30,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:45',30.30,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:46',30.31,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:47',30.31,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:48',30.32,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:49',30.32,-0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:50',30.33,0.04,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:51',30.33,-0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:52',30.33,0.02,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:53',30.33,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:54',30.34,0.01,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:55',30.34,0.01,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:56',30.34,-0.00,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:57',30.34,0.00,24.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:58',30.35,0.03,25.00);
INSERT INTO `600037_RT` VALUES('2017-05-08','14:59',30.18,-0.55,144.00);