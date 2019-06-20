SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600026_RT`;
CREATE TABLE `600026_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600026`;
CREATE TABLE `600026` (
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

INSERT INTO `600026` VALUES('2017-03-17',16.81,20.17,20.17,16.81,15735,313679.0,0.00,0.00,0.02,2.574,1.609,0.322,3.103,1.494);
INSERT INTO `600026` VALUES('2017-03-20',22.19,22.19,22.19,22.19,6000,133140.0,10.01,0.00,0.01,4.820,3.012,0.602,6.040,3.027);
INSERT INTO `600026` VALUES('2017-03-21',24.41,24.41,24.41,24.41,2263,55240.0,10.00,0.00,0.00,6.808,4.255,0.851,8.866,4.611);
INSERT INTO `600026` VALUES('2017-03-22',26.85,26.85,26.85,26.85,5200,139620.0,10.00,0.00,0.01,8.599,5.374,1.075,11.633,6.258);
INSERT INTO `600026` VALUES('2017-03-23',29.54,29.54,29.54,29.54,17558,518663.0,10.02,0.00,0.02,10.247,6.405,1.281,14.388,7.983);
INSERT INTO `600026` VALUES('2017-03-24',32.49,32.49,32.49,32.49,25996,844610.0,9.99,0.00,0.03,11.799,7.374,1.475,17.173,9.798);
INSERT INTO `600026` VALUES('2017-03-27',35.74,35.74,35.74,35.74,29995,1072020.0,10.00,0.00,0.03,13.295,8.309,1.662,20.029,11.720);
INSERT INTO `600026` VALUES('2017-03-28',39.31,39.31,39.31,39.31,51104,2008900.0,9.99,0.00,0.05,14.771,9.232,1.846,22.995,13.764);
INSERT INTO `600026` VALUES('2017-03-29',43.24,43.24,43.24,43.24,109153,4719780.0,10.00,0.00,0.11,16.261,10.163,2.033,26.110,15.947);
INSERT INTO `600026` VALUES('2017-03-30',47.56,47.56,47.56,45.33,19976764,9.3626598E8,9.99,0.05,19.98,17.794,11.121,2.224,29.410,18.289);
INSERT INTO `600026` VALUES('2017-03-31',47.00,47.84,50.97,46.02,20933295,1.02316E9,0.59,0.10,20.93,18.828,11.768,2.354,32.245,20.478);
INSERT INTO `600026` VALUES('2017-04-05',44.10,44.50,45.40,43.06,14882327,6.5585498E8,-6.98,0.05,14.88,18.998,11.874,2.375,34.131,22.257);
INSERT INTO `600026` VALUES('2017-04-06',44.48,48.95,48.95,44.01,10352286,4.88782016E8,10.00,0.11,10.35,19.482,12.176,2.435,36.411,24.234);
INSERT INTO `600026` VALUES('2017-04-07',49.67,47.96,51.18,47.41,13858669,6.8030502E8,-2.02,0.08,13.86,19.513,12.196,2.439,38.187,25.992);
INSERT INTO `600026` VALUES('2017-04-10',46.49,49.07,49.99,44.80,12302559,5.8184198E8,2.31,0.11,12.30,19.457,12.160,2.432,39.862,27.701);
INSERT INTO `600026` VALUES('2017-04-11',47.02,48.79,49.69,46.28,10701371,5.15908992E8,-0.57,0.07,10.70,19.155,11.972,2.394,41.235,29.263);
INSERT INTO `600026` VALUES('2017-04-12',48.03,46.79,52.95,46.50,14232396,7.1374003E8,-4.10,0.13,14.23,18.445,11.528,2.306,42.090,30.562);
INSERT INTO `600026` VALUES('2017-04-13',44.00,46.08,46.75,43.00,9974310,4.48544992E8,-1.52,0.08,9.97,17.588,10.992,2.198,42.704,31.711);
INSERT INTO `600026` VALUES('2017-04-14',45.40,41.48,45.88,41.47,8752989,3.80944992E8,-9.98,0.10,8.75,16.129,10.081,2.016,42.515,32.435);
INSERT INTO `600026` VALUES('2017-04-17',39.00,38.57,39.74,37.70,7106599,2.76644992E8,-7.02,0.05,7.11,14.431,9.019,1.804,41.908,32.889);
INSERT INTO `600026` VALUES('2017-04-18',39.10,40.47,41.83,39.10,6775534,2.75839008E8,4.93,0.07,6.78,13.178,8.236,1.647,41.687,33.451);
INSERT INTO `600026` VALUES('2017-04-19',40.50,42.06,42.35,39.80,4620329,1.91332E8,3.93,0.06,4.62,12.250,7.656,1.531,41.745,34.089);
INSERT INTO `600026` VALUES('2017-04-20',41.85,42.46,43.89,41.85,4452000,1.91652E8,0.95,0.05,4.45,11.433,7.146,1.429,41.855,34.709);
INSERT INTO `600026` VALUES('2017-04-21',42.90,43.91,44.58,42.37,4362900,1.9137E8,3.41,0.05,4.36,10.849,6.781,1.356,42.171,35.390);
INSERT INTO `600026` VALUES('2017-04-24',43.88,43.57,44.80,42.01,4069250,1.77071008E8,-0.77,0.06,4.07,10.224,6.390,1.278,42.386,35.996);
INSERT INTO `600026` VALUES('2017-04-25',43.20,43.13,44.69,42.51,4250962,1.85234E8,-1.01,0.05,4.25,9.561,5.976,1.195,42.501,36.525);
INSERT INTO `600026` VALUES('2017-04-26',42.20,43.14,44.15,42.20,3524510,1.52292992E8,0.02,0.05,3.52,8.935,5.584,1.117,42.599,37.015);
INSERT INTO `600026` VALUES('2017-04-27',42.83,46.03,46.90,42.70,5091488,2.28847008E8,6.70,0.10,5.09,8.711,5.444,1.089,43.127,37.682);
INSERT INTO `600026` VALUES('2017-04-28',47.00,46.80,48.98,46.04,5907339,2.77641984E8,1.67,0.06,5.91,8.535,5.334,1.067,43.692,38.358);
INSERT INTO `600026` VALUES('2017-05-02',46.52,46.52,47.18,45.50,3423668,1.58976E8,-0.60,0.04,3.42,8.263,5.165,1.033,44.127,38.962);
INSERT INTO `600026` VALUES('2017-05-03',46.52,47.78,47.96,45.70,4295903,2.01532992E8,2.71,0.05,4.30,8.117,5.073,1.015,44.689,39.616);
INSERT INTO `600026` VALUES('2017-05-04',46.90,46.13,47.50,45.80,3415822,1.59379008E8,-3.45,0.04,3.42,7.700,4.813,0.963,44.911,40.098);
INSERT INTO `600026` VALUES('2017-05-05',45.53,44.92,46.05,44.89,3349549,1.51664992E8,-2.62,0.03,3.35,7.131,4.457,0.891,44.912,40.455);
INSERT INTO `600026` VALUES('2017-05-08',44.60,44.55,45.88,44.21,1606666,7.2617504E7,-0.82,0.04,1.61,6.556,4.098,0.820,44.856,40.759);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:30',44.60,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:31',44.34,-0.59,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:32',44.40,0.14,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:33',44.35,-0.12,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:34',44.32,-0.05,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:35',44.26,-0.14,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:36',44.23,-0.07,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:37',44.24,0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:38',44.23,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:39',44.23,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:40',44.25,0.05,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:41',44.28,0.08,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:42',44.27,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:43',44.24,-0.07,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:44',44.23,-0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:45',44.21,-0.04,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:46',44.21,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:47',44.21,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:48',44.21,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:49',44.21,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:50',44.21,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:51',44.21,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:52',44.21,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:53',44.21,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:54',44.22,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:55',44.22,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:56',44.21,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:57',44.23,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:58',44.23,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','09:59',44.25,0.04,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:00',44.26,0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:01',44.26,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:02',44.27,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:03',44.29,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:04',44.29,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:05',44.32,0.05,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:06',44.33,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:07',44.34,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:08',44.36,0.05,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:09',44.39,0.05,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:10',44.38,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:11',44.37,-0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:12',44.37,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:13',44.36,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:14',44.36,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:15',44.40,0.08,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:16',44.44,0.10,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:17',44.46,0.05,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:18',44.46,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:19',44.45,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:20',44.44,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:21',44.43,-0.04,65.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:22',44.43,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:23',44.43,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:24',44.43,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:25',44.43,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:26',44.43,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:27',44.42,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:28',44.44,0.04,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:29',44.43,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:30',44.44,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:31',44.43,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:32',44.47,0.07,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:33',44.47,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:34',44.47,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:35',44.46,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:36',44.46,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:37',44.46,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:38',44.46,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:39',44.45,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:40',44.44,-0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:41',44.42,-0.04,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:42',44.41,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:43',44.40,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:44',44.40,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:45',44.39,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:46',44.40,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:47',44.40,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:48',44.40,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:49',44.40,0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:50',44.39,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:51',44.39,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:52',44.41,0.05,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:53',44.42,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:54',44.41,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:55',44.41,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:56',44.41,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:57',44.41,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:58',44.41,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','10:59',44.41,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:00',44.43,0.04,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:01',44.43,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:02',44.42,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:03',44.43,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:04',44.43,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:05',44.43,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:06',44.46,0.05,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:07',44.47,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:08',44.48,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:09',44.47,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:10',44.46,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:11',44.45,-0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:12',44.45,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:13',44.45,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:14',44.45,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:15',44.44,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:16',44.44,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:17',44.44,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:18',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:19',44.45,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:20',44.46,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:21',44.47,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:22',44.47,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:23',44.47,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:24',44.47,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:25',44.47,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:26',44.49,0.04,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:27',44.49,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:28',44.49,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','11:29',44.49,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:00',44.50,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:01',44.50,0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:02',44.50,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:03',44.49,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:04',44.49,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:05',44.49,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:06',44.48,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:07',44.49,0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:08',44.49,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:09',44.49,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:10',44.50,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:11',44.50,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:12',44.50,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:13',44.50,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:14',44.49,-0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:15',44.47,-0.03,65.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:16',44.47,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:17',44.46,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:18',44.45,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:19',44.45,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:20',44.44,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:21',44.44,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:22',44.44,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:23',44.45,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:24',44.44,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:25',44.44,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:26',44.43,-0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:27',44.42,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:28',44.42,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:29',44.43,0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:30',44.44,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:31',44.44,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:32',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:33',44.45,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:34',44.45,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:35',44.44,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:36',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:37',44.44,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:38',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:39',44.45,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:40',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:41',44.44,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:42',44.44,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:43',44.43,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:44',44.43,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:45',44.42,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:46',44.42,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:47',44.43,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:48',44.43,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:49',44.42,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:50',44.42,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:51',44.43,0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:52',44.43,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:53',44.44,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:54',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:55',44.44,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:56',44.44,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:57',44.44,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:58',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','13:59',44.45,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:00',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:01',44.45,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:02',44.46,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:03',44.45,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:04',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:05',44.44,-0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:06',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:07',44.44,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:08',44.44,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:09',44.43,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:10',44.45,0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:11',44.45,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:12',44.46,0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:13',44.46,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:14',44.46,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:15',44.46,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:16',44.46,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:17',44.45,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:18',44.46,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:19',44.45,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:20',44.45,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:21',44.44,-0.03,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:22',44.44,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:23',44.43,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:24',44.43,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:25',44.42,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:26',44.42,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:27',44.42,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:28',44.41,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:29',44.40,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:30',44.40,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:31',44.41,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:32',44.41,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:33',44.41,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:34',44.41,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:35',44.40,-0.02,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:36',44.41,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:37',44.38,-0.06,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:38',44.37,-0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:39',44.36,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:40',44.36,0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:41',44.36,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:42',44.35,-0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:43',44.36,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:44',44.36,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:45',44.36,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:46',44.37,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:47',44.37,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:48',44.38,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:49',44.38,-0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:50',44.39,0.03,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:51',44.39,-0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:52',44.39,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:53',44.39,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:54',44.40,0.01,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:55',44.40,0.01,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:56',44.40,-0.00,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:57',44.40,0.00,66.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:58',44.41,0.02,67.00);
INSERT INTO `600026_RT` VALUES('2017-05-08','14:59',44.55,0.32,179.00);