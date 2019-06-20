SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `600097_RT`;
CREATE TABLE `600097_RT` (
  `date` date NOT NULL COMMENT '交易日日期',
  `time` char(5) NOT NULL COMMENT '交易时间(开盘到收盘的每一分钟)  格式为  hh:mm',
  `price` float(8,2) NOT NULL COMMENT '股票单价(该分钟的最后一笔交易的股票单价)',
  `change_percent` float(8,2) NOT NULL COMMENT '涨跌幅(该分钟的股票单价较上一分钟的单价的涨跌幅)',
  `amount` float(8,2) NOT NULL COMMENT '成交量(该分钟的成交股票数/100，也就是成交一手代表成交100股)',
  PRIMARY KEY (`date`, `time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `600097`;
CREATE TABLE `600097` (
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

INSERT INTO `600097` VALUES('2017-03-24',19.58,23.50,23.50,19.58,18532,435463.0,0.00,0.00,0.02,2.999,1.875,0.375,3.615,1.741);
INSERT INTO `600097` VALUES('2017-03-27',25.85,25.85,25.85,25.85,11305,292234.0,10.00,0.00,0.01,5.615,3.509,0.702,7.036,3.527);
INSERT INTO `600097` VALUES('2017-03-28',28.44,28.44,28.44,28.44,12100,344124.0,10.02,0.00,0.01,7.931,4.957,0.991,10.329,5.372);
INSERT INTO `600097` VALUES('2017-03-29',31.28,31.28,31.28,31.28,10900,340952.0,9.99,0.00,0.01,10.018,6.261,1.252,13.552,7.291);
INSERT INTO `600097` VALUES('2017-03-30',34.41,34.41,34.41,34.41,39421,1356480.0,10.01,0.00,0.04,11.938,7.461,1.492,16.761,9.300);
INSERT INTO `600097` VALUES('2017-03-31',37.85,37.85,37.85,37.85,82115,3108050.0,10.00,0.00,0.08,13.745,8.591,1.718,20.006,11.415);
INSERT INTO `600097` VALUES('2017-04-05',41.64,40.70,41.64,38.80,22064747,8.9254298E8,7.53,0.08,22.06,15.368,9.605,1.921,23.189,13.584);
INSERT INTO `600097` VALUES('2017-04-06',39.50,44.41,44.68,38.38,22461285,9.5204301E8,9.12,0.15,22.46,16.939,10.587,2.117,26.454,15.867);
INSERT INTO `600097` VALUES('2017-04-07',42.45,40.61,43.73,40.44,17551385,7.3724602E8,-8.56,0.07,17.55,17.491,10.932,2.186,28.632,17.700);
INSERT INTO `600097` VALUES('2017-04-10',39.01,36.56,39.67,36.55,13685668,5.14799008E8,-9.97,0.08,13.69,17.207,10.754,2.151,29.852,19.097);
INSERT INTO `600097` VALUES('2017-04-11',36.00,38.06,38.50,35.60,10654072,3.97895008E8,4.10,0.08,10.65,16.980,10.613,2.123,31.114,20.502);
INSERT INTO `600097` VALUES('2017-04-12',37.31,36.16,38.37,36.06,7769915,2.88139008E8,-4.99,0.06,7.77,16.366,10.229,2.046,31.891,21.662);
INSERT INTO `600097` VALUES('2017-04-13',36.20,35.38,36.70,35.00,6977290,2.49176E8,-2.16,0.05,6.98,15.599,9.750,1.950,32.427,22.678);
INSERT INTO `600097` VALUES('2017-04-14',35.00,33.80,35.00,33.80,6085700,2.08452E8,-4.47,0.03,6.09,14.619,9.137,1.827,32.639,23.502);
INSERT INTO `600097` VALUES('2017-04-17',32.09,30.89,32.76,30.56,6156241,1.94048992E8,-8.61,0.07,6.16,13.313,8.321,1.664,32.370,24.049);
INSERT INTO `600097` VALUES('2017-04-18',30.99,31.15,31.70,30.77,4284946,1.33863E8,0.84,0.03,4.28,12.171,7.607,1.521,32.182,24.575);
INSERT INTO `600097` VALUES('2017-04-19',31.17,32.96,32.99,31.12,6234363,1.99835008E8,5.81,0.06,6.23,11.369,7.106,1.421,32.302,25.196);
INSERT INTO `600097` VALUES('2017-04-20',32.59,31.91,32.90,31.33,5045013,1.62028992E8,-3.19,0.05,5.05,10.477,6.548,1.310,32.241,25.693);
INSERT INTO `600097` VALUES('2017-04-21',31.85,31.30,32.41,31.26,3125891,9.9133104E7,-1.91,0.04,3.13,9.580,5.988,1.198,32.097,26.109);
INSERT INTO `600097` VALUES('2017-04-24',30.73,29.86,31.06,29.00,3532888,1.06075E8,-4.60,0.07,3.53,8.585,5.366,1.073,31.752,26.387);
INSERT INTO `600097` VALUES('2017-04-25',30.35,30.45,30.83,30.07,3330777,1.01369E8,1.98,0.03,3.33,7.783,4.864,0.973,31.552,26.688);
INSERT INTO `600097` VALUES('2017-04-26',30.45,30.52,30.97,30.11,3531882,1.08161E8,0.23,0.03,3.53,7.075,4.422,0.884,31.393,26.972);
INSERT INTO `600097` VALUES('2017-04-27',30.40,31.77,32.32,29.00,6998630,2.16944992E8,4.10,0.11,7.00,6.599,4.124,0.825,31.451,27.327);
INSERT INTO `600097` VALUES('2017-04-28',31.56,31.84,32.09,31.20,4408086,1.39495008E8,0.22,0.03,4.41,6.160,3.850,0.770,31.511,27.661);
INSERT INTO `600097` VALUES('2017-05-02',31.87,31.01,31.89,30.80,3656454,1.14622E8,-2.61,0.03,3.66,5.639,3.525,0.705,31.434,27.909);
INSERT INTO `600097` VALUES('2017-05-03',30.68,31.77,31.89,30.63,4489504,1.40203008E8,2.45,0.04,4.49,5.265,3.290,0.658,31.486,28.195);
INSERT INTO `600097` VALUES('2017-05-04',31.40,31.11,31.77,30.90,3401735,1.06266E8,-2.08,0.03,3.40,4.827,3.017,0.603,31.428,28.411);
INSERT INTO `600097` VALUES('2017-05-05',30.70,29.80,30.95,29.75,3335674,1.01625E8,-4.21,0.04,3.34,4.261,2.663,0.533,31.177,28.514);
INSERT INTO `600097` VALUES('2017-05-08',29.45,29.07,30.16,29.01,2430468,7.18436E7,-2.45,0.04,2.43,3.677,2.298,0.460,30.853,28.555);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:30',29.45,0.00,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:31',29.14,-1.06,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:32',29.20,0.21,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:33',29.15,-0.18,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:34',29.12,-0.08,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:35',29.06,-0.21,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:36',29.03,-0.11,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:37',29.04,0.03,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:38',29.03,-0.01,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:39',29.03,-0.03,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:40',29.05,0.07,111.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:41',29.08,0.12,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:42',29.07,-0.02,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:43',29.04,-0.10,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:44',29.03,-0.05,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:45',29.01,-0.06,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:46',29.01,0.02,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:47',29.01,-0.02,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:48',29.01,0.00,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:49',29.01,0.00,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:50',29.01,0.00,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:51',29.01,0.00,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:52',29.01,0.00,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:53',29.01,0.00,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:54',29.02,0.03,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:55',29.02,0.01,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:56',29.01,-0.03,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:57',29.03,0.05,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:58',29.03,0.02,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','09:59',29.05,0.07,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:00',29.06,0.04,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:01',29.06,-0.01,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:02',29.07,0.03,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:03',29.09,0.05,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:04',29.09,0.02,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:05',29.12,0.08,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:06',29.13,0.03,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:07',29.14,0.04,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:08',29.16,0.08,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:09',29.19,0.08,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:10',29.18,-0.01,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:11',29.17,-0.05,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:12',29.17,-0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:13',29.16,-0.03,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:14',29.16,0.00,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:15',29.20,0.13,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:16',29.24,0.15,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:17',29.26,0.07,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:18',29.26,-0.01,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:19',29.25,-0.02,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:20',29.24,-0.03,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:21',29.23,-0.05,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:22',29.23,0.02,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:23',29.23,-0.01,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:24',29.23,0.00,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:25',29.23,-0.02,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:26',29.23,0.02,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:27',29.22,-0.03,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:28',29.24,0.06,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:29',29.23,-0.03,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:30',29.24,0.03,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:31',29.23,-0.03,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:32',29.27,0.11,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:33',29.26,-0.01,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:34',29.27,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:35',29.26,-0.03,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:36',29.26,0.02,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:37',29.26,0.00,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:38',29.26,-0.02,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:39',29.25,-0.03,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:40',29.24,-0.04,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:41',29.22,-0.06,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:42',29.21,-0.03,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:43',29.20,-0.03,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:44',29.20,-0.00,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:45',29.19,-0.01,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:46',29.20,0.02,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:47',29.20,0.01,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:48',29.20,-0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:49',29.20,0.02,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:50',29.19,-0.03,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:51',29.19,-0.00,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:52',29.21,0.07,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:53',29.22,0.01,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:54',29.21,-0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:55',29.21,-0.02,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:56',29.21,0.01,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:57',29.21,-0.00,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:58',29.21,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','10:59',29.21,0.00,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:00',29.23,0.07,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:01',29.23,-0.02,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:02',29.22,-0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:03',29.23,0.02,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:04',29.23,0.02,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:05',29.23,0.00,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:06',29.26,0.08,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:07',29.27,0.05,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:08',29.28,0.03,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:09',29.27,-0.03,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:10',29.26,-0.02,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:11',29.25,-0.04,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:12',29.25,0.00,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:13',29.25,0.00,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:14',29.25,-0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:15',29.24,-0.02,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:16',29.24,0.01,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:17',29.24,-0.01,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:18',29.24,0.00,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:19',29.25,0.05,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:20',29.26,0.02,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:21',29.27,0.02,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:22',29.27,0.00,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:23',29.27,0.02,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:24',29.27,-0.02,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:25',29.27,0.02,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:26',29.29,0.06,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:27',29.29,0.00,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:28',29.29,0.01,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','11:29',29.29,-0.01,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:00',29.30,0.02,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:01',29.30,0.02,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:02',29.30,0.01,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:03',29.29,-0.03,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:04',29.30,0.00,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:05',29.29,-0.01,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:06',29.28,-0.03,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:07',29.29,0.03,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:08',29.29,0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:09',29.29,0.00,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:10',29.30,0.02,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:11',29.30,0.00,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:12',29.30,0.00,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:13',29.30,-0.01,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:14',29.29,-0.04,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:15',29.27,-0.05,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:16',29.27,0.01,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:17',29.26,-0.04,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:18',29.25,-0.03,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:19',29.25,-0.02,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:20',29.24,-0.03,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:21',29.24,0.00,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:22',29.24,-0.00,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:23',29.25,0.01,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:24',29.24,-0.00,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:25',29.24,-0.03,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:26',29.23,-0.04,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:27',29.22,-0.01,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:28',29.22,0.00,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:29',29.23,0.04,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:30',29.24,0.04,111.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:31',29.24,-0.00,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:32',29.25,0.01,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:33',29.25,-0.00,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:34',29.25,0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:35',29.24,-0.02,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:36',29.24,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:37',29.24,-0.00,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:38',29.25,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:39',29.25,-0.00,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:40',29.25,0.01,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:41',29.24,-0.02,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:42',29.24,-0.02,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:43',29.23,-0.01,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:44',29.23,-0.02,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:45',29.22,-0.01,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:46',29.22,-0.00,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:47',29.23,0.00,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:48',29.23,0.01,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:49',29.22,-0.01,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:50',29.22,-0.01,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:51',29.23,0.04,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:52',29.23,0.01,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:53',29.24,0.00,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:54',29.24,0.00,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:55',29.24,0.00,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:56',29.24,0.01,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:57',29.24,0.01,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:58',29.24,0.00,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','13:59',29.25,0.02,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:00',29.25,0.02,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:01',29.25,0.01,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:02',29.26,0.00,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:03',29.25,-0.02,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:04',29.25,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:05',29.24,-0.04,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:06',29.24,0.00,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:07',29.24,-0.01,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:08',29.24,0.01,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:09',29.23,-0.02,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:10',29.25,0.04,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:11',29.25,0.01,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:12',29.26,0.04,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:13',29.26,0.01,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:14',29.26,-0.02,111.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:15',29.26,0.01,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:16',29.26,0.01,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:17',29.25,-0.02,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:18',29.26,0.01,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:19',29.25,-0.04,91.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:20',29.25,0.01,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:21',29.24,-0.04,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:22',29.24,0.00,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:23',29.23,-0.02,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:24',29.23,0.00,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:25',29.22,-0.02,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:26',29.22,-0.03,107.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:27',29.22,0.00,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:28',29.21,-0.03,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:29',29.20,-0.02,99.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:30',29.20,-0.00,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:31',29.21,0.00,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:32',29.21,0.01,109.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:33',29.21,0.02,100.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:34',29.21,0.00,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:35',29.20,-0.04,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:36',29.21,0.02,103.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:37',29.18,-0.10,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:38',29.17,-0.03,101.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:39',29.16,-0.02,95.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:40',29.16,0.00,102.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:41',29.16,-0.01,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:42',29.15,-0.02,106.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:43',29.16,0.01,93.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:44',29.16,-0.00,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:45',29.16,0.01,96.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:46',29.17,0.02,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:47',29.17,0.01,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:48',29.18,0.03,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:49',29.18,-0.01,98.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:50',29.19,0.04,110.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:51',29.19,-0.00,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:52',29.19,0.02,104.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:53',29.19,0.00,97.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:54',29.20,0.01,108.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:55',29.20,0.01,94.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:56',29.20,-0.00,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:57',29.20,0.00,92.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:58',29.21,0.03,105.00);
INSERT INTO `600097_RT` VALUES('2017-05-08','14:59',29.07,-0.47,288.00);
