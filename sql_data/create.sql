SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `trans_id` int(10) NOT NULL AUTO_INCREMENT,
  `stock_id` int(10) NOT NULL DEFAULT '0' COMMENT '股票id',
  `buy_id` int(10) NOT NULL COMMENT '买请求id',
  `sell_id` int(10) NOT NULL COMMENT '卖请求id',
  `date` date NOT NULL COMMENT '交易成功日期',
  `time` time NOT NULL COMMENT '交易成功时间',
  `price` float(8,2) NOT NULL DEFAULT '0' COMMENT '股票单价',
  `number` int(10) NOT NULL DEFAULT '0'  COMMENT '交易股票数',
  PRIMARY KEY (`trans_id`), 
  FOREIGN KEY(`buy_id`) REFERENCES offer_buy(`buy_id`),
  FOREIGN KEY(`sell_id`) REFERENCES offer_sell(`sell_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `offer_buy`;·
CREATE TABLE `offer_buy` (
  `buy_id` int(10) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(10) NOT NULL DEFAULT '0' COMMENT '买方id',
  `stock_id` int(10) NOT NULL DEFAULT '0' COMMENT '股票id',
  `price` float(8,2) NOT NULL DEFAULT '0' COMMENT '股票单价',
  `total` varchar(255) NOT NULL DEFAULT '0'  COMMENT '总请求数量',
  `rest` varchar(255) NOT NULL DEFAULT '0'  COMMENT '未完成数量',
  PRIMARY KEY (`buy_id`),
  FOREIGN KEY(`buyer_id`) REFERENCES account(`account_id`),
  FOREIGN KEY(`stock_id`) REFERENCES stock(`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES utf8;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `offer_sell`;
CREATE TABLE `offer_sell` (
  `sell_id` int(10) NOT NULL AUTO_INCREMENT,
  `seller_id` int(10) NOT NULL DEFAULT '0' COMMENT '卖方id',
  `stock_id` int(10) NOT NULL DEFAULT '0' COMMENT '股票id',
  `price` float(8,2) NOT NULL DEFAULT '0' COMMENT '股票单价',
  `total` varchar(255) NOT NULL DEFAULT '0'  COMMENT '总请求数量',
  `rest` varchar(255) NOT NULL DEFAULT '0'  COMMENT '未完成数量',
  PRIMARY KEY (`sell_id`),
  FOREIGN KEY(`seller_id`) REFERENCES account(`account_id`),
  FOREIGN KEY(`stock_id`) REFERENCES stock(`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000000 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;


