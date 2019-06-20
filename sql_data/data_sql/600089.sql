SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600089_RT`;
CREATE TABLE `600089_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600089`;
CREATE TABLE `600089` (
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

INSERT INTO `600089` VALUES('2016-12-28',34.42,34.42,34.42,34.42,32440,1116580.0,0.00,0.00,0.03,4.393,2.746,0.549,5.295,2.550);
INSERT INTO `600089` VALUES('2016-12-29',37.86,37.86,37.86,37.86,15800,598188.0,9.99,0.00,0.02,8.224,5.140,1.028,10.305,5.165);
INSERT INTO `600089` VALUES('2016-12-30',41.65,41.65,41.65,41.65,29716,1237670.0,10.01,0.00,0.03,11.616,7.260,1.452,15.128,7.868);
INSERT INTO `600089` VALUES('2017-01-03',45.82,45.82,45.82,45.82,84171,3856720.0,10.01,0.00,0.08,14.673,9.170,1.834,19.849,10.679);
INSERT INTO `600089` VALUES('2017-01-04',49.99,50.40,50.40,48.06,16581495,8.2101197E8,10.00,0.05,16.58,17.485,10.928,2.186,24.550,13.621);
INSERT INTO `600089` VALUES('2017-01-05',50.00,47.70,50.45,46.12,17460681,8.4390003E8,-5.36,0.09,17.46,19.145,11.965,2.393,28.111,16.146);
INSERT INTO `600089` VALUES('2017-01-06',46.60,43.91,46.99,43.56,11537412,5.17988992E8,-7.95,0.07,11.54,19.743,12.339,2.468,30.542,18.202);
INSERT INTO `600089` VALUES('2017-01-09',43.13,43.27,44.56,42.50,6781272,2.95320992E8,-1.46,0.05,6.78,19.905,12.441,2.488,32.500,20.059);
INSERT INTO `600089` VALUES('2017-01-10',43.27,41.98,43.89,41.81,6614600,2.83342016E8,-2.98,0.05,6.61,19.641,12.275,2.455,33.958,21.683);
INSERT INTO `600089` VALUES('2017-01-11',41.70,40.42,41.73,40.02,6980691,2.83676E8,-3.72,0.04,6.98,19.011,11.882,2.376,34.953,23.071);
INSERT INTO `600089` VALUES('2017-01-12',40.06,39.20,40.98,38.81,6513774,2.59262E8,-3.02,0.05,6.51,18.145,11.340,2.268,35.606,24.266);
INSERT INTO `600089` VALUES('2017-01-13',39.00,40.22,42.08,38.15,8481236,3.36822016E8,2.60,0.10,8.48,17.389,10.868,2.174,36.316,25.447);
INSERT INTO `600089` VALUES('2017-01-16',39.50,40.41,41.18,38.50,8527509,3.40919008E8,0.47,0.07,8.53,16.624,10.390,2.078,36.946,26.556);
INSERT INTO `600089` VALUES('2017-01-17',39.92,41.64,42.38,39.09,10587460,4.33696E8,3.04,0.08,10.59,15.992,9.995,1.999,37.668,27.673);
INSERT INTO `600089` VALUES('2017-01-18',40.98,39.24,41.25,39.20,6459647,2.60128E8,-5.76,0.05,6.46,15.008,9.380,1.876,37.910,28.530);
INSERT INTO `600089` VALUES('2017-01-19',38.12,38.50,39.98,38.02,4761719,1.85315008E8,-1.89,0.05,4.76,13.971,8.732,1.746,38.001,29.268);
INSERT INTO `600089` VALUES('2017-01-20',38.47,38.93,39.48,38.47,4024962,1.5709E8,1.12,0.03,4.02,13.055,8.159,1.632,38.144,29.984);
INSERT INTO `600089` VALUES('2017-01-23',38.91,38.74,39.40,38.53,3548478,1.38264992E8,-0.49,0.02,3.55,12.164,7.603,1.521,38.235,30.633);
INSERT INTO `600089` VALUES('2017-01-24',38.66,37.86,38.79,37.65,3706403,1.40904E8,-2.27,0.03,3.71,11.215,7.010,1.402,38.178,31.168);
INSERT INTO `600089` VALUES('2017-01-25',38.00,38.24,38.45,37.90,2917380,1.11378E8,1.00,0.01,2.92,10.392,6.495,1.299,38.187,31.692);
INSERT INTO `600089` VALUES('2017-01-26',38.50,38.10,38.50,37.82,2121368,8.08328E7,-0.37,0.02,2.12,9.611,6.007,1.201,38.174,32.167);
INSERT INTO `600089` VALUES('2017-02-03',38.05,38.67,39.06,37.93,2800255,1.07899E8,1.50,0.03,2.80,8.963,5.602,1.120,38.250,32.648);
INSERT INTO `600089` VALUES('2017-02-06',38.95,40.05,40.18,38.70,5512733,2.18448E8,3.57,0.04,5.51,8.529,5.330,1.066,38.527,33.197);
INSERT INTO `600089` VALUES('2017-02-07',39.73,39.51,39.79,39.01,4523266,1.78406E8,-1.35,0.02,4.52,8.022,5.014,1.003,38.678,33.664);
INSERT INTO `600089` VALUES('2017-02-08',39.30,39.85,40.18,39.16,4218448,1.6735E8,0.86,0.03,4.22,7.578,4.736,0.947,38.859,34.122);
INSERT INTO `600089` VALUES('2017-02-09',39.75,39.54,40.08,39.42,3856996,1.53044992E8,-0.78,0.02,3.86,7.103,4.440,0.888,38.963,34.524);
INSERT INTO `600089` VALUES('2017-02-10',39.49,38.54,39.61,38.52,3989392,1.5555E8,-2.53,0.03,3.99,6.523,4.077,0.815,38.898,34.821);
INSERT INTO `600089` VALUES('2017-02-13',38.00,39.36,39.50,38.00,4564576,1.7835E8,2.13,0.04,4.56,6.099,3.812,0.762,38.969,35.157);
INSERT INTO `600089` VALUES('2017-02-14',39.19,40.13,40.86,39.16,7641200,3.06008E8,1.96,0.04,7.64,5.795,3.622,0.724,39.148,35.526);
INSERT INTO `600089` VALUES('2017-02-15',39.78,40.76,42.16,39.77,10399648,4.26175008E8,1.57,0.06,10.40,5.572,3.482,0.696,39.396,35.914);
INSERT INTO `600089` VALUES('2017-02-16',40.70,42.13,42.47,39.88,9459975,3.8944E8,3.36,0.06,9.46,5.508,3.443,0.689,39.817,36.374);
INSERT INTO `600089` VALUES('2017-02-17',42.13,41.90,43.80,41.41,9070837,3.85422016E8,-0.55,0.06,9.07,5.366,3.354,0.671,40.137,36.783);
INSERT INTO `600089` VALUES('2017-02-20',41.32,43.38,43.70,40.69,7229345,3.02249984E8,3.53,0.07,7.23,5.382,3.364,0.673,40.636,37.272);
INSERT INTO `600089` VALUES('2017-02-21',43.00,46.50,47.65,42.42,11482138,5.08364992E8,7.19,0.12,11.48,5.732,3.583,0.717,41.538,37.956);
INSERT INTO `600089` VALUES('2017-02-22',45.85,49.94,50.01,45.20,14100514,6.7328698E8,7.40,0.10,14.10,6.380,3.987,0.797,42.831,38.843);
INSERT INTO `600089` VALUES('2017-02-23',49.89,54.65,54.90,48.86,21250462,1.08495002E9,9.43,0.12,21.25,7.416,4.635,0.927,44.649,40.014);
INSERT INTO `600089` VALUES('2017-02-24',53.90,56.47,58.90,53.20,17322602,9.7050202E8,3.33,0.10,17.32,8.375,5.235,1.047,46.468,41.233);
INSERT INTO `600089` VALUES('2017-02-27',56.46,53.62,59.28,52.45,10840602,6.0007302E8,-5.05,0.12,10.84,8.668,5.417,1.083,47.568,42.151);
INSERT INTO `600089` VALUES('2017-02-28',53.62,53.77,54.50,52.37,7684218,4.08270016E8,0.28,0.04,7.68,8.817,5.511,1.102,48.522,43.011);
INSERT INTO `600089` VALUES('2017-03-01',56.25,59.15,59.15,56.23,4353243,2.54372992E8,10.01,0.05,4.35,9.521,5.950,1.190,50.157,44.207);
INSERT INTO `600089` VALUES('2017-03-02',65.07,65.07,65.07,65.07,2177068,1.41662E8,10.01,0.00,2.18,10.719,6.699,1.340,52.452,45.752);
INSERT INTO `600089` VALUES('2017-03-03',65.07,58.56,65.07,58.56,27301394,1.61351002E9,-10.00,0.10,27.30,10.705,6.690,1.338,53.391,46.701);
INSERT INTO `600089` VALUES('2017-03-06',52.70,52.77,55.00,52.70,22789939,1.20995994E9,-9.89,0.04,22.79,9.832,6.145,1.229,53.296,47.151);
INSERT INTO `600089` VALUES('2017-03-07',51.50,52.27,52.90,51.11,12626529,6.5636602E8,-0.95,0.03,12.63,8.973,5.608,1.122,53.138,47.530);
INSERT INTO `600089` VALUES('2017-03-08',52.50,51.41,52.87,51.10,10263171,5.30216992E8,-1.65,0.03,10.26,8.088,5.055,1.011,52.872,47.817);
INSERT INTO `600089` VALUES('2017-03-09',51.26,49.36,51.26,49.20,8653392,4.32271008E8,-3.99,0.04,8.65,7.040,4.400,0.880,52.332,47.931);
INSERT INTO `600089` VALUES('2017-03-10',49.36,49.50,50.30,49.01,7110798,3.53004E8,0.28,0.03,7.11,6.158,3.848,0.770,51.896,48.048);
INSERT INTO `600089` VALUES('2017-03-13',49.50,49.01,49.70,48.20,6063441,2.96160992E8,-0.99,0.03,6.06,5.333,3.333,0.667,51.452,48.119);
INSERT INTO `600089` VALUES('2017-03-14',49.01,49.50,50.49,48.71,7383188,3.67748E8,1.00,0.04,7.38,4.689,2.931,0.586,51.152,48.221);
INSERT INTO `600089` VALUES('2017-03-15',49.30,48.39,49.30,48.30,5634941,2.74391008E8,-2.24,0.02,5.63,3.989,2.493,0.499,50.727,48.234);
INSERT INTO `600089` VALUES('2017-03-16',48.65,49.75,50.28,48.20,8031118,3.97424E8,2.81,0.04,8.03,3.569,2.231,0.446,50.577,48.346);
INSERT INTO `600089` VALUES('2017-03-17',49.41,51.47,53.80,49.40,14676656,7.6152998E8,3.46,0.09,14.68,3.419,2.137,0.427,50.714,48.577);
INSERT INTO `600089` VALUES('2017-03-20',51.53,52.49,52.50,50.51,10301248,5.33004992E8,1.98,0.04,10.30,3.392,2.120,0.424,50.987,48.867);
INSERT INTO `600089` VALUES('2017-03-21',52.10,55.96,57.57,52.00,17577668,9.6643398E8,6.61,0.11,17.58,3.775,2.360,0.472,51.752,49.393);
INSERT INTO `600089` VALUES('2017-03-22',55.00,55.72,57.50,54.01,13756635,7.66992E8,-0.43,0.06,13.76,4.002,2.501,0.500,52.363,49.861);
INSERT INTO `600089` VALUES('2017-03-23',55.00,52.96,56.50,51.51,11389784,6.1409101E8,-4.95,0.09,11.39,3.782,2.364,0.473,52.455,50.091);
INSERT INTO `600089` VALUES('2017-03-24',53.20,53.71,53.95,52.58,6886203,3.67636992E8,1.42,0.03,6.89,3.662,2.289,0.458,52.648,50.359);
INSERT INTO `600089` VALUES('2017-03-27',53.70,51.73,53.70,51.20,6936994,3.61204E8,-3.69,0.05,6.94,3.274,2.046,0.409,52.507,50.461);
INSERT INTO `600089` VALUES('2017-03-28',51.26,49.34,51.70,49.28,5994343,3.01312992E8,-4.62,0.05,5.99,2.627,1.642,0.328,52.019,50.378);
INSERT INTO `600089` VALUES('2017-03-29',49.11,46.50,49.68,46.00,6736552,3.19536E8,-5.76,0.07,6.74,1.728,1.080,0.216,51.170,50.090);
INSERT INTO `600089` VALUES('2017-03-30',46.14,48.46,49.83,44.40,9164009,4.32316E8,4.22,0.12,9.16,1.254,0.784,0.157,50.753,49.970);
INSERT INTO `600089` VALUES('2017-03-31',47.93,47.48,49.98,47.02,6271910,3.04878016E8,-2.02,0.06,6.27,0.743,0.465,0.093,50.250,49.785);
INSERT INTO `600089` VALUES('2017-04-05',46.22,48.45,48.74,45.00,5736943,2.72028E8,2.04,0.08,5.74,0.459,0.287,0.057,49.973,49.686);
INSERT INTO `600089` VALUES('2017-04-06',48.12,49.76,49.88,47.66,6696424,3.29128992E8,2.70,0.05,6.70,0.397,0.248,0.050,49.940,49.692);
INSERT INTO `600089` VALUES('2017-04-07',49.50,47.78,49.50,47.70,4796707,2.33827008E8,-3.98,0.04,4.80,0.092,0.058,0.012,49.608,49.550);
INSERT INTO `600089` VALUES('2017-04-10',46.90,44.00,47.22,43.51,5743753,2.6244E8,-7.91,0.08,5.74,-0.630,-0.394,-0.079,48.745,49.139);
INSERT INTO `600089` VALUES('2017-04-11',43.89,45.29,45.46,43.70,4392240,1.96578E8,2.93,0.04,4.39,-1.025,-0.640,-0.128,48.213,48.854);
INSERT INTO `600089` VALUES('2017-04-12',45.10,43.34,45.10,43.20,3964644,1.74751008E8,-4.31,0.04,3.96,-1.571,-0.982,-0.196,47.464,48.445);
INSERT INTO `600089` VALUES('2017-04-13',43.31,43.01,44.35,42.60,2887978,1.25301E8,-0.76,0.04,2.89,-2.023,-1.264,-0.253,46.779,48.043);
INSERT INTO `600089` VALUES('2017-04-14',42.71,41.91,42.99,41.70,2718912,1.14509E8,-2.56,0.03,2.72,-2.494,-1.559,-0.312,46.030,47.589);
INSERT INTO `600089` VALUES('2017-04-17',40.75,41.40,42.36,39.60,3627305,1.4824E8,-1.22,0.07,3.63,-2.901,-1.813,-0.363,45.317,47.130);
INSERT INTO `600089` VALUES('2017-04-18',41.18,40.98,42.30,40.80,2593700,1.0766E8,-1.01,0.04,2.59,-3.239,-2.025,-0.405,44.650,46.675);
INSERT INTO `600089` VALUES('2017-04-19',40.38,43.09,43.35,40.38,5674065,2.40000992E8,5.15,0.07,5.67,-3.198,-1.999,-0.400,44.410,46.409);
INSERT INTO `600089` VALUES('2017-04-20',42.80,42.98,43.46,42.18,4293388,1.83840992E8,-0.26,0.03,4.29,-3.144,-1.965,-0.393,44.190,46.155);
INSERT INTO `600089` VALUES('2017-04-21',42.99,42.77,43.67,42.55,2671723,1.14927E8,-0.49,0.03,2.67,-3.092,-1.933,-0.387,43.972,45.904);
INSERT INTO `600089` VALUES('2017-04-24',42.90,40.57,42.90,40.01,2556140,1.05466E8,-5.14,0.07,2.56,-3.297,-2.061,-0.412,43.448,45.509);
INSERT INTO `600089` VALUES('2017-04-25',40.75,40.97,41.68,40.70,2321160,9.54766E7,0.99,0.02,2.32,-3.370,-2.106,-0.421,43.067,45.173);
INSERT INTO `600089` VALUES('2017-04-26',40.79,41.54,41.96,40.60,2749488,1.14047E8,1.39,0.03,2.75,-3.315,-2.072,-0.414,42.832,44.904);
INSERT INTO `600089` VALUES('2017-04-27',41.12,42.94,42.96,40.21,5134957,2.15008E8,3.37,0.07,5.13,-3.056,-1.910,-0.382,42.849,44.758);
INSERT INTO `600089` VALUES('2017-04-28',42.67,43.29,43.50,42.46,4058036,1.75138E8,0.82,0.02,4.06,-2.773,-1.733,-0.347,42.917,44.650);
INSERT INTO `600089` VALUES('2017-05-02',43.31,42.65,43.50,42.50,2628431,1.12778E8,-1.48,0.02,2.63,-2.601,-1.626,-0.325,42.876,44.501);
INSERT INTO `600089` VALUES('2017-05-03',42.55,43.10,43.19,41.90,3259218,1.39044992E8,1.06,0.03,3.26,-2.380,-1.488,-0.298,42.910,44.398);
INSERT INTO `600089` VALUES('2017-05-04',43.00,44.46,44.90,42.39,5961260,2.61668E8,3.16,0.06,5.96,-2.006,-1.254,-0.251,43.149,44.402);
INSERT INTO `600089` VALUES('2017-05-05',44.00,43.04,44.99,43.00,4575901,2.02259008E8,-3.19,0.04,4.58,-1.871,-1.170,-0.234,43.132,44.301);
INSERT INTO `600089` VALUES('2017-05-08',42.50,40.23,42.50,40.02,3489089,1.44324E8,-6.53,0.06,3.49,-2.103,-1.314,-0.263,42.685,44.000);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:30',42.50,0.00,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:31',40.15,-5.54,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:32',40.21,0.15,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:33',40.16,-0.13,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:34',40.13,-0.06,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:35',40.07,-0.15,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:36',40.04,-0.08,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:37',40.05,0.02,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:38',40.04,-0.01,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:39',40.04,-0.02,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:40',40.06,0.05,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:41',40.09,0.08,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:42',40.08,-0.02,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:43',40.05,-0.08,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:44',40.04,-0.04,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:45',40.02,-0.05,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:46',40.02,0.01,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:47',40.02,-0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:48',40.02,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:49',40.02,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:50',40.02,0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:51',40.02,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:52',40.02,0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:53',40.02,0.00,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:54',40.03,0.02,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:55',40.03,0.01,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:56',40.02,-0.02,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:57',40.04,0.04,135.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:58',40.04,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','09:59',40.06,0.05,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:00',40.07,0.03,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:01',40.07,-0.00,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:02',40.08,0.02,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:03',40.10,0.04,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:04',40.10,0.01,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:05',40.13,0.06,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:06',40.14,0.03,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:07',40.15,0.03,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:08',40.17,0.06,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:09',40.20,0.05,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:10',40.19,-0.00,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:11',40.18,-0.04,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:12',40.18,-0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:13',40.17,-0.02,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:14',40.17,0.00,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:15',40.21,0.09,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:16',40.25,0.11,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:17',40.27,0.05,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:18',40.27,-0.01,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:19',40.26,-0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:20',40.25,-0.03,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:21',40.24,-0.04,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:22',40.24,0.02,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:23',40.24,-0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:24',40.24,0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:25',40.24,-0.01,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:26',40.24,0.01,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:27',40.23,-0.02,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:28',40.25,0.04,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:29',40.24,-0.02,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:30',40.25,0.02,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:31',40.24,-0.02,135.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:32',40.28,0.08,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:33',40.28,-0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:34',40.28,0.00,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:35',40.27,-0.02,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:36',40.27,0.01,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:37',40.27,0.00,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:38',40.27,-0.02,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:39',40.26,-0.02,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:40',40.25,-0.03,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:41',40.23,-0.05,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:42',40.22,-0.02,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:43',40.21,-0.02,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:44',40.21,-0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:45',40.20,-0.01,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:46',40.21,0.01,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:47',40.21,0.00,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:48',40.21,-0.01,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:49',40.21,0.02,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:50',40.20,-0.02,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:51',40.20,-0.00,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:52',40.22,0.05,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:53',40.23,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:54',40.22,-0.00,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:55',40.22,-0.02,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:56',40.22,0.01,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:57',40.22,-0.00,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:58',40.22,0.01,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','10:59',40.22,0.00,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:00',40.24,0.05,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:01',40.24,-0.01,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:02',40.23,-0.01,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:03',40.24,0.01,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:04',40.24,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:05',40.24,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:06',40.27,0.06,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:07',40.28,0.03,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:08',40.29,0.02,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:09',40.28,-0.02,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:10',40.27,-0.01,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:11',40.26,-0.03,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:12',40.26,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:13',40.26,0.00,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:14',40.26,-0.01,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:15',40.25,-0.01,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:16',40.25,0.01,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:17',40.25,-0.01,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:18',40.25,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:19',40.26,0.03,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:20',40.27,0.02,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:21',40.28,0.02,136.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:22',40.28,0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:23',40.28,0.01,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:24',40.28,-0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:25',40.28,0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:26',40.30,0.04,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:27',40.30,0.00,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:28',40.30,0.01,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','11:29',40.30,-0.01,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:00',40.31,0.01,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:01',40.31,0.02,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:02',40.31,0.01,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:03',40.30,-0.02,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:04',40.31,0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:05',40.30,-0.01,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:06',40.29,-0.02,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:07',40.30,0.02,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:08',40.30,0.00,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:09',40.30,0.00,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:10',40.31,0.02,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:11',40.31,0.00,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:12',40.31,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:13',40.31,-0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:14',40.30,-0.03,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:15',40.28,-0.04,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:16',40.28,0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:17',40.27,-0.03,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:18',40.26,-0.02,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:19',40.26,-0.01,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:20',40.25,-0.02,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:21',40.25,0.00,136.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:22',40.25,-0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:23',40.26,0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:24',40.25,-0.00,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:25',40.25,-0.02,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:26',40.24,-0.03,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:27',40.23,-0.01,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:28',40.23,0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:29',40.24,0.03,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:30',40.25,0.03,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:31',40.25,-0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:32',40.26,0.01,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:33',40.26,-0.00,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:34',40.26,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:35',40.25,-0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:36',40.25,0.01,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:37',40.25,-0.00,136.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:38',40.26,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:39',40.26,-0.00,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:40',40.26,0.01,155.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:41',40.25,-0.01,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:42',40.25,-0.02,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:43',40.24,-0.01,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:44',40.24,-0.01,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:45',40.23,-0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:46',40.23,-0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:47',40.24,0.00,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:48',40.24,0.00,149.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:49',40.23,-0.01,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:50',40.23,-0.01,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:51',40.24,0.03,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:52',40.24,0.01,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:53',40.25,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:54',40.25,0.00,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:55',40.25,0.00,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:56',40.25,0.01,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:57',40.25,0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:58',40.25,0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','13:59',40.26,0.01,136.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:00',40.26,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:01',40.26,0.01,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:02',40.27,0.00,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:03',40.26,-0.02,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:04',40.26,0.01,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:05',40.25,-0.03,139.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:06',40.25,0.00,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:07',40.25,-0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:08',40.25,0.01,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:09',40.24,-0.01,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:10',40.26,0.03,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:11',40.26,0.01,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:12',40.27,0.03,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:13',40.27,0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:14',40.27,-0.02,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:15',40.27,0.01,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:16',40.27,0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:17',40.26,-0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:18',40.27,0.01,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:19',40.26,-0.03,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:20',40.26,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:21',40.25,-0.03,144.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:22',40.25,0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:23',40.24,-0.02,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:24',40.24,0.00,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:25',40.23,-0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:26',40.23,-0.02,152.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:27',40.23,0.00,137.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:28',40.22,-0.02,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:29',40.21,-0.01,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:30',40.21,-0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:31',40.22,0.00,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:32',40.22,0.00,148.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:33',40.22,0.01,141.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:34',40.22,0.00,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:35',40.21,-0.03,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:36',40.22,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:37',40.19,-0.07,142.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:38',40.18,-0.02,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:39',40.17,-0.02,136.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:40',40.17,0.00,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:41',40.17,-0.01,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:42',40.16,-0.02,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:43',40.17,0.01,138.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:44',40.17,-0.00,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:45',40.17,0.00,135.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:46',40.18,0.02,153.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:47',40.18,0.00,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:48',40.19,0.03,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:49',40.19,-0.01,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:50',40.20,0.03,154.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:51',40.20,-0.00,145.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:52',40.20,0.01,146.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:53',40.20,0.00,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:54',40.21,0.01,150.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:55',40.21,0.01,143.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:56',40.21,-0.00,147.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:57',40.21,0.00,140.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:58',40.22,0.02,151.00);
INSERT INTO `600089_RT` VALUES('2017-05-08','14:59',40.23,0.03,145.00);