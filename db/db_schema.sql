
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `__output_cache` (
  `GenID` int(11) NOT NULL AUTO_INCREMENT,
  `PageID` varchar(64) DEFAULT NULL,
  `Language` char(2) DEFAULT NULL,
  `UserID` varchar(32) DEFAULT NULL,
  `Dependencies` text,
  `LastModified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Expires` datetime DEFAULT NULL,
  `Data` longtext,
  `Data_gz` longblob,
  `Headers` text,
  PRIMARY KEY (`GenID`),
  KEY `LookupIndex` (`Language`,`UserID`,`PageID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_account_defaults` (
  `default_id` int(11) NOT NULL AUTO_INCREMENT,
  `accounts_payable` int(11) DEFAULT NULL,
  `accounts_receivable` int(10) NOT NULL,
  `ar_account_labor` int(10) NOT NULL,
  `ar_account_materials` int(10) NOT NULL,
  `ar_account_fuel` int(10) NOT NULL,
  `ar_account_tax` int(10) NOT NULL,
  `ar_account_pm` int(10) NOT NULL,
  PRIMARY KEY (`default_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_departments` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_company_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(3) NOT NULL,
  `zip` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `county` varchar(100) NOT NULL,
  `web_address` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_period` varchar(10) NOT NULL,
  `week_start` varchar(10) NOT NULL,
  `expense_wage_type` int(10) NOT NULL,
  `expense_overtime_type` int(10) NOT NULL,
  `vacation_hours_type` int(10) DEFAULT NULL,
  `vacation_hours_method` varchar(15) NOT NULL,
  `sick_hours_type` int(10) DEFAULT NULL,
  `sick_hours_method` varchar(15) NOT NULL,
  `holiday_hours_type` int(10) NOT NULL,
  `fica_deduction_type` int(10) NOT NULL,
  `fica_contribution_type` int(10) NOT NULL,
  `fica_percent` decimal(5,4) NOT NULL,
  `fica_annual_wage_limit` decimal(12,2) NOT NULL,
  `medicare_deduction_type` int(10) NOT NULL,
  `medicare_contribution_type` int(10) NOT NULL,
  `medicare_percent` decimal(5,4) NOT NULL,
  `medicare_extra_after` decimal(12,2) NOT NULL,
  `medicare_extra_percent` decimal(4,3) NOT NULL,
  `federal_type` int(10) NOT NULL,
  `state_type` int(10) NOT NULL,
  `401k_deduction_type` int(10) NOT NULL,
  `401k_contribution_type` int(10) NOT NULL,
  `wages_payable` int(10) NOT NULL,
  `close_date_option` varchar(15) NOT NULL,
  `ytd_date_option` varchar(15) NOT NULL,
  `expense_tm_type` int(10) NOT NULL,
  `expense_qu_type` int(10) NOT NULL,
  `expense_sw_type` int(10) NOT NULL,
  `expense_nc_type` int(10) NOT NULL,
  `expense_pm_type` int(10) NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_holiday` (
  `holiday_config_id` int(10) NOT NULL AUTO_INCREMENT,
  `holiday_date` date NOT NULL,
  `holiday_hours` decimal(3,1) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`holiday_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_sick` (
  `sick_config_id` int(10) NOT NULL AUTO_INCREMENT,
  `after_time` decimal(3,1) NOT NULL,
  `hours` int(4) NOT NULL,
  PRIMARY KEY (`sick_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_tax_exemptions` (
  `tax_exemption_id` int(11) NOT NULL AUTO_INCREMENT,
  `state` varchar(3) DEFAULT NULL,
  `weekly` decimal(7,2) NOT NULL,
  `2weeks` decimal(7,2) NOT NULL,
  PRIMARY KEY (`tax_exemption_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_tax_tables` (
  `tax_config_id` int(10) NOT NULL AUTO_INCREMENT,
  `state` varchar(3) DEFAULT NULL,
  `percent` decimal(4,3) NOT NULL,
  `single_weekly` decimal(9,2) DEFAULT NULL,
  `married_weekly` decimal(9,2) DEFAULT NULL,
  `single_2weeks` decimal(9,2) DEFAULT NULL,
  `married_2weeks` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`tax_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_uta` (
  `uta_config_id` int(10) NOT NULL AUTO_INCREMENT,
  `type_id` int(10) NOT NULL,
  `state` varchar(3) DEFAULT NULL,
  `percent` decimal(5,4) NOT NULL,
  `max_annual` decimal(10,2) NOT NULL,
  PRIMARY KEY (`uta_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_payroll_config_vacation` (
  `vacation_config_id` int(10) NOT NULL AUTO_INCREMENT,
  `after_time` decimal(4,2) NOT NULL,
  `hours` int(4) NOT NULL,
  PRIMARY KEY (`vacation_config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_record_versioning` (
  `record_id` varchar(255) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_record_versioning__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `record_id` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`record_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=401 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_system_users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` enum('NO ACCESS','USER','SYSTEM','ADMIN') NOT NULL DEFAULT 'NO ACCESS',
  `view_service_menu` varchar(10) DEFAULT NULL,
  `view_accounting_menu` varchar(10) DEFAULT NULL,
  `view_admin_menu` varchar(10) DEFAULT NULL,
  `inventory` varchar(10) DEFAULT NULL,
  `payroll` varchar(10) DEFAULT NULL,
  `purchase_order_service` varchar(10) DEFAULT NULL,
  `purchase_order_inventory` varchar(10) DEFAULT NULL,
  `purchase_order_tool` varchar(10) DEFAULT NULL,
  `purchase_order_vehicle` varchar(10) DEFAULT NULL,
  `general_ledger` varchar(10) DEFAULT NULL,
  `chart_of_accounts` varchar(10) DEFAULT NULL,
  `accounts_payable` varchar(10) DEFAULT NULL,
  `accounts_receivable` varchar(10) DEFAULT NULL,
  `employees` varchar(10) DEFAULT NULL,
  `customers` varchar(10) DEFAULT NULL,
  `call_slips` varchar(10) DEFAULT NULL,
  `time_logs` varchar(10) DEFAULT NULL,
  `contracts` varchar(10) DEFAULT NULL,
  `vendors` varchar(10) DEFAULT NULL,
  `dispatch` varchar(10) DEFAULT NULL,
  `vehicles` varchar(10) DEFAULT NULL,
  `rates` varchar(10) DEFAULT NULL,
  `markup` varchar(10) DEFAULT NULL,
  `county_tax` varchar(10) DEFAULT NULL,
  `payroll_config` varchar(10) DEFAULT NULL,
  `print_checks` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UserName` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `_system_users__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `username` varchar(32) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `role` enum('NO ACCESS','USER','SYSTEM','ADMIN') DEFAULT NULL,
  `view_service_menu` varchar(10) DEFAULT NULL,
  `view_accounting_menu` varchar(10) DEFAULT NULL,
  `view_admin_menu` varchar(10) DEFAULT NULL,
  `inventory` varchar(10) DEFAULT NULL,
  `payroll` varchar(10) DEFAULT NULL,
  `purchase_order_service` varchar(10) DEFAULT NULL,
  `purchase_order_inventory` varchar(10) DEFAULT NULL,
  `purchase_order_tool` varchar(10) DEFAULT NULL,
  `purchase_order_vehicle` varchar(10) DEFAULT NULL,
  `general_ledger` varchar(10) DEFAULT NULL,
  `chart_of_accounts` varchar(10) DEFAULT NULL,
  `accounts_payable` varchar(10) DEFAULT NULL,
  `accounts_receivable` varchar(10) DEFAULT NULL,
  `employees` varchar(10) DEFAULT NULL,
  `customers` varchar(10) DEFAULT NULL,
  `call_slips` varchar(10) DEFAULT NULL,
  `time_logs` varchar(10) DEFAULT NULL,
  `contracts` varchar(10) DEFAULT NULL,
  `vendors` varchar(10) DEFAULT NULL,
  `dispatch` varchar(10) DEFAULT NULL,
  `vehicles` varchar(10) DEFAULT NULL,
  `rates` varchar(10) DEFAULT NULL,
  `markup` varchar(10) DEFAULT NULL,
  `county_tax` varchar(10) DEFAULT NULL,
  `payroll_config` varchar(10) DEFAULT NULL,
  `print_checks` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`user_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_payable` (
  `voucher_id` int(10) NOT NULL AUTO_INCREMENT,
  `voucher_date` date DEFAULT NULL,
  `invoice_id` int(20) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `post_status` varchar(10) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `vendor_id` int(10) DEFAULT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `site_id` int(10) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `description` text,
  `batch_id` int(10) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `print_status` varchar(10) DEFAULT NULL,
  `print_date` date DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT NULL,
  `apply_discount` int(3) DEFAULT NULL,
  `modify_discount` decimal(11,2) DEFAULT NULL,
  `check_number` varchar(20) DEFAULT NULL,
  `account_credit` int(11) DEFAULT NULL,
  `account_debit` int(11) DEFAULT NULL,
  `credit` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`voucher_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_payable_batch` (
  `batch_id` int(10) NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(50) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  PRIMARY KEY (`batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_payable_batch_vouchers` (
  `apbv_id` int(10) NOT NULL AUTO_INCREMENT,
  `batch_id` int(10) NOT NULL,
  `voucher_id` int(10) NOT NULL,
  PRIMARY KEY (`apbv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `accounts_payable_unassigned_purchase_orders` (
  `purchase_order_id` tinyint NOT NULL,
  `assigned_voucher_id` tinyint NOT NULL,
  `vendor_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable` (
  `voucher_id` int(10) NOT NULL AUTO_INCREMENT,
  `batch_id` int(10) DEFAULT NULL,
  `invoice_id` int(10) DEFAULT NULL,
  `voucher_date` date NOT NULL,
  `customer_id` int(10) NOT NULL,
  `customer_po` varchar(30) DEFAULT NULL,
  `credit_invoice_id` int(10) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `account` int(10) NOT NULL,
  `description` text,
  `post_status` varchar(10) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  PRIMARY KEY (`voucher_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `voucher_id` int(10) DEFAULT NULL,
  `batch_id` int(10) DEFAULT NULL,
  `voucher_date` date DEFAULT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `invoice_id` int(10) DEFAULT NULL,
  `post_status` varchar(10) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `credit_invoice_id` int(10) DEFAULT NULL,
  `account` int(10) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `customer_po` varchar(30) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`voucher_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable_batch` (
  `batch_id` int(10) NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(50) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  PRIMARY KEY (`batch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable_batch__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `batch_id` int(10) DEFAULT NULL,
  `batch_name` varchar(50) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`batch_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable_batch_vouchers` (
  `arbv_id` int(10) NOT NULL AUTO_INCREMENT,
  `batch_id` int(10) NOT NULL,
  `voucher_id` int(10) NOT NULL,
  PRIMARY KEY (`arbv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable_voucher_accounts` (
  `arva_id` int(10) NOT NULL AUTO_INCREMENT,
  `voucher_id` int(10) NOT NULL,
  `account_id` int(10) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`arva_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_receivable_voucher_accounts__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `arva_id` int(10) DEFAULT NULL,
  `voucher_id` int(10) DEFAULT NULL,
  `account_id` int(10) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`arva_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_county_tax` (
  `county_id` int(10) NOT NULL DEFAULT '0',
  `county` varchar(99) DEFAULT NULL,
  `tax_rate` decimal(3,3) DEFAULT NULL,
  PRIMARY KEY (`county_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing` (
  `billing_id` int(11) NOT NULL AUTO_INCREMENT,
  `billing_date` date NOT NULL,
  `customer_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `tech_id` int(11) NOT NULL,
  `hours` decimal(6,2) NOT NULL,
  `notes` text NOT NULL,
  PRIMARY KEY (`billing_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slip_additional_materials` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `call_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` int(10) NOT NULL,
  `sale_price` decimal(11,2) NOT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slip_admin` (
  `call_slip_admin_id` int(10) NOT NULL AUTO_INCREMENT,
  `charge_consumables_default` decimal(11,2) DEFAULT NULL,
  `charge_fuel_default` decimal(11,2) DEFAULT NULL,
  `footer` text,
  PRIMARY KEY (`call_slip_admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slip_inventory` (
  `csi_id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_id` int(11) NOT NULL,
  `call_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  `sale_price` decimal(11,2) DEFAULT NULL,
  `location` varchar(10) NOT NULL,
  PRIMARY KEY (`csi_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slip_inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `csi_id` int(11) DEFAULT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `call_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  `sale_price` decimal(11,2) DEFAULT NULL,
  `location` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`csi_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `call_slip_purchase_orders` (
  `list_id` tinyint NOT NULL,
  `purchase_id` tinyint NOT NULL,
  `item_name` tinyint NOT NULL,
  `quantity` tinyint NOT NULL,
  `quantity_used` tinyint NOT NULL,
  `sale_price` tinyint NOT NULL,
  `purchase_price` tinyint NOT NULL,
  `callslip_id` tinyint NOT NULL,
  `post_status` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slip_purchase_orders__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_used` decimal(15,4) DEFAULT NULL,
  `sale_price` decimal(11,2) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  `callslip_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`list_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slips` (
  `call_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `post_status` varchar(10) DEFAULT NULL,
  `quoted_cost` decimal(12,2) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `work_order_number` int(20) DEFAULT NULL,
  `po_number` varchar(30) DEFAULT NULL,
  `customer_po` varchar(30) DEFAULT NULL,
  `problem` varchar(300) DEFAULT NULL,
  `call_instructions` text,
  `call_datetime` datetime DEFAULT NULL,
  `site_instructions` text,
  `technician` int(11) DEFAULT NULL,
  `scheduled_datetime` datetime DEFAULT NULL,
  `desc_of_work` text,
  `completion_date` date DEFAULT NULL,
  `charge_consumables` decimal(11,2) DEFAULT NULL,
  `charge_fuel` decimal(11,2) DEFAULT NULL,
  `tax` decimal(11,2) DEFAULT NULL,
  `total_charge` decimal(11,2) NOT NULL,
  `credit` varchar(30) DEFAULT NULL,
  `ar_billing_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`call_id`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `call_slips__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `call_id` int(11) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `call_datetime` datetime DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `site_id` int(11) DEFAULT NULL,
  `contract_id` int(11) DEFAULT NULL,
  `problem` varchar(300) DEFAULT NULL,
  `call_instructions` text,
  `site_instructions` text,
  `desc_of_work` text,
  `quoted_cost` decimal(8,2) DEFAULT NULL,
  `work_order_number` int(20) DEFAULT NULL,
  `po_number` int(20) DEFAULT NULL,
  `technician` int(11) DEFAULT NULL,
  `scheduled_datetime` datetime DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `post_status` varchar(10) DEFAULT NULL,
  `credit` varchar(30) DEFAULT NULL,
  `customer_po` varchar(30) DEFAULT NULL,
  `charge_consumables` decimal(11,2) DEFAULT NULL,
  `charge_fuel` decimal(11,2) DEFAULT NULL,
  `ar_billing_id` int(10) DEFAULT NULL,
  `total_charge` decimal(11,2) DEFAULT NULL,
  `tax` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`call_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=239 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chart_of_accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` varchar(12) DEFAULT NULL,
  `account_name` varchar(100) NOT NULL,
  `account_balance` decimal(17,2) NOT NULL DEFAULT '0.00',
  `account_type` varchar(3) NOT NULL,
  `account_category` int(3) NOT NULL,
  `account_status` varchar(10) DEFAULT NULL,
  `account_description` text,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chart_of_accounts_categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(99) NOT NULL,
  `category_number` varchar(3) NOT NULL,
  `account_type` varchar(3) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contracts` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `contract_type` varchar(30) DEFAULT NULL,
  `contract_amount` decimal(11,2) DEFAULT NULL,
  `billed_to_date` decimal(11,2) DEFAULT NULL,
  `total_due` decimal(11,2) DEFAULT NULL,
  `auto_renew` varchar(1) DEFAULT NULL,
  `next_year_amount` decimal(11,2) DEFAULT NULL,
  `next_year_escalate` decimal(11,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `billing_cycle` varchar(120) DEFAULT NULL,
  `instructions` text,
  PRIMARY KEY (`contract_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `contact_name` varchar(200) NOT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(200) DEFAULT NULL,
  `contact_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_markup` (
  `markup_id` int(11) NOT NULL AUTO_INCREMENT,
  `markup_label` varchar(100) NOT NULL,
  PRIMARY KEY (`markup_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_markup_rates` (
  `markup_rate_id` int(11) NOT NULL AUTO_INCREMENT,
  `markup_id` int(11) NOT NULL,
  `from` decimal(11,2) NOT NULL,
  `to` decimal(11,2) DEFAULT NULL,
  `markup_percent` decimal(6,5) NOT NULL,
  PRIMARY KEY (`markup_rate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_site_contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `contact_name` varchar(200) NOT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(200) DEFAULT NULL,
  `contact_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_sites` (
  `site_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `customer_site_id` varchar(30) DEFAULT NULL,
  `site_address` varchar(200) NOT NULL,
  `site_city` varchar(30) NOT NULL,
  `site_state` varchar(3) NOT NULL,
  `site_zip` varchar(10) NOT NULL,
  `site_phone` varchar(20) DEFAULT NULL,
  `site_fax` varchar(20) DEFAULT NULL,
  `site_instructions` text,
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_sites__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `site_id` int(10) DEFAULT NULL,
  `customer_site_id` varchar(30) DEFAULT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `site_address` varchar(200) DEFAULT NULL,
  `site_city` varchar(30) DEFAULT NULL,
  `site_state` varchar(3) DEFAULT NULL,
  `site_zip` varchar(10) DEFAULT NULL,
  `site_phone` varchar(20) DEFAULT NULL,
  `site_fax` varchar(20) DEFAULT NULL,
  `site_instructions` text,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`site_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `customer_id` int(10) NOT NULL AUTO_INCREMENT,
  `customer` varchar(99) NOT NULL,
  `billing_address` varchar(200) NOT NULL,
  `billing_city` varchar(30) NOT NULL,
  `billing_state` varchar(3) NOT NULL,
  `billing_zip` varchar(10) NOT NULL,
  `cust_phone` varchar(20) DEFAULT NULL,
  `cust_fax` varchar(20) DEFAULT NULL,
  `web_address` varchar(200) DEFAULT NULL,
  `billing_county` varchar(99) NOT NULL,
  `rate` int(11) NOT NULL,
  `markup` int(11) NOT NULL,
  `balance` decimal(20,2) NOT NULL DEFAULT '0.00',
  `details` text,
  PRIMARY KEY (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=620 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `customer_id` int(10) DEFAULT NULL,
  `customer` varchar(99) DEFAULT NULL,
  `cust_phone` varchar(20) DEFAULT NULL,
  `cust_fax` varchar(20) DEFAULT NULL,
  `web_address` varchar(200) DEFAULT NULL,
  `details` text,
  `billing_address` varchar(200) DEFAULT NULL,
  `billing_city` varchar(30) DEFAULT NULL,
  `billing_state` varchar(3) DEFAULT NULL,
  `billing_zip` varchar(10) DEFAULT NULL,
  `billing_county` varchar(99) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `markup` int(11) DEFAULT NULL,
  `balance` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`customer_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard` (
  `dashboard_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`dashboard_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__datagrids` (
  `gridID` int(11) NOT NULL AUTO_INCREMENT,
  `gridName` varchar(64) NOT NULL,
  `gridData` text,
  `tableName` varchar(64) NOT NULL,
  PRIMARY KEY (`gridID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__failed_logins` (
  `attempt_id` int(11) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `time_of_attempt` int(11) NOT NULL,
  PRIMARY KEY (`attempt_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__htmlreports_reports` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `actiontool_name` varchar(255) DEFAULT NULL,
  `actiontool_category` varchar(255) DEFAULT NULL,
  `actiontool_label` varchar(255) DEFAULT NULL,
  `actiontool_permission` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `tablename` varchar(255) NOT NULL,
  `template_css` text,
  `template_html` longtext NOT NULL,
  `default_view` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `private` tinyint(1) DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__modules` (
  `module_name` varchar(255) NOT NULL,
  `module_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`module_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__mtimes` (
  `name` varchar(255) NOT NULL,
  `mtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__preferences` (
  `pref_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `table` varchar(128) NOT NULL,
  `record_id` varchar(255) NOT NULL,
  `key` varchar(128) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`pref_id`),
  KEY `username` (`username`),
  KEY `table` (`table`),
  KEY `record_id` (`record_id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__record_mtimes` (
  `recordhash` varchar(32) NOT NULL,
  `recordid` varchar(255) NOT NULL,
  `mtime` int(11) NOT NULL,
  PRIMARY KEY (`recordhash`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataface__version` (
  `version` int(5) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `dataface__view_a61fbcecd9051777794f538b7978fbac` (
  `inventory_id` tinyint NOT NULL,
  `item_name` tinyint NOT NULL,
  `item_description` tinyint NOT NULL,
  `item_unit` tinyint NOT NULL,
  `last_purchase` tinyint NOT NULL,
  `average_purchase` tinyint NOT NULL,
  `sale_method` tinyint NOT NULL,
  `sale_overide` tinyint NOT NULL,
  `quantity` tinyint NOT NULL,
  `category` tinyint NOT NULL,
  `vehicle_quantity` tinyint NOT NULL,
  `stock_quantity` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `dataface__view_b8f350bcba1ab951a2db277006c85bfd` (
  `call_id` tinyint NOT NULL,
  `customer_id` tinyint NOT NULL,
  `site_id` tinyint NOT NULL,
  `status` tinyint NOT NULL,
  `post_status` tinyint NOT NULL,
  `quoted_cost` tinyint NOT NULL,
  `contract_id` tinyint NOT NULL,
  `type` tinyint NOT NULL,
  `work_order_number` tinyint NOT NULL,
  `po_number` tinyint NOT NULL,
  `customer_po` tinyint NOT NULL,
  `problem` tinyint NOT NULL,
  `call_instructions` tinyint NOT NULL,
  `call_datetime` tinyint NOT NULL,
  `site_instructions` tinyint NOT NULL,
  `technician` tinyint NOT NULL,
  `scheduled_datetime` tinyint NOT NULL,
  `desc_of_work` tinyint NOT NULL,
  `completion_date` tinyint NOT NULL,
  `charge_consumables` tinyint NOT NULL,
  `charge_fuel` tinyint NOT NULL,
  `tax` tinyint NOT NULL,
  `total_charge` tinyint NOT NULL,
  `credit` tinyint NOT NULL,
  `ar_billing_id` tinyint NOT NULL,
  `search_field` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_work_history` (
  `employee_work_history_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `job_call_id` int(10) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`employee_work_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `employee_id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(99) NOT NULL,
  `last_name` varchar(99) NOT NULL,
  `ssn` varchar(11) DEFAULT NULL COMMENT 'Social Security Number',
  `title` varchar(99) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `date_of_hire` date DEFAULT NULL,
  `date_of_termination` date DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(3) NOT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `phone1` varchar(15) DEFAULT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `email` varchar(99) DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `workers_comp_code` varchar(10) DEFAULT NULL,
  `exemptions_federal` varchar(2) DEFAULT NULL,
  `exemptions_state` varchar(2) DEFAULT NULL,
  `exemptions_city` varchar(2) DEFAULT NULL,
  `employee_type` varchar(10) NOT NULL,
  `pay_rate` decimal(8,4) DEFAULT NULL,
  `full_part` varchar(2) DEFAULT NULL,
  `pay_period` varchar(2) DEFAULT NULL,
  `hours_remain_vacation` decimal(7,3) NOT NULL DEFAULT '0.000',
  `hours_remain_sick` decimal(7,3) NOT NULL DEFAULT '0.000',
  `direct_deposit` varchar(2) DEFAULT NULL,
  `direct_deposit_bank` varchar(20) DEFAULT NULL,
  `direct_deposit_routing` varchar(20) DEFAULT NULL,
  `marital_status` varchar(2) NOT NULL,
  `notes` text,
  `tech` varchar(3) NOT NULL,
  `active` varchar(3) NOT NULL,
  `timeclock_pw` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `last_name` varchar(99) DEFAULT NULL,
  `first_name` varchar(99) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `ssn` varchar(11) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `sex` varchar(3) DEFAULT NULL,
  `marital_status` varchar(2) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(3) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `phone1` varchar(15) DEFAULT NULL,
  `phone2` varchar(15) DEFAULT NULL,
  `email` varchar(99) DEFAULT NULL,
  `title` varchar(99) DEFAULT NULL,
  `department` varchar(30) DEFAULT NULL,
  `active` varchar(3) DEFAULT NULL,
  `date_of_hire` date DEFAULT NULL,
  `date_of_termination` date DEFAULT NULL,
  `workers_comp_code` varchar(10) DEFAULT NULL,
  `notes` text,
  `full_part` varchar(2) DEFAULT NULL,
  `employee_type` varchar(10) DEFAULT NULL,
  `pay_rate` decimal(8,4) DEFAULT NULL,
  `pay_period` varchar(2) DEFAULT NULL,
  `hours_remain_vacation` decimal(7,3) DEFAULT NULL,
  `hours_remain_sick` decimal(7,3) DEFAULT NULL,
  `direct_deposit` varchar(2) DEFAULT NULL,
  `direct_deposit_bank` varchar(20) DEFAULT NULL,
  `direct_deposit_routing` varchar(20) DEFAULT NULL,
  `exemptions_federal` varchar(2) DEFAULT NULL,
  `exemptions_state` varchar(2) DEFAULT NULL,
  `exemptions_city` varchar(2) DEFAULT NULL,
  `timeclock_pw` varchar(100) DEFAULT NULL,
  `tech` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`employee_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_wage_accounts` (
  `payroll_account_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `account_id` int(10) NOT NULL,
  `amount_percent` decimal(4,1) NOT NULL,
  `overtime` int(1) DEFAULT NULL,
  PRIMARY KEY (`payroll_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_wage_accounts__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `payroll_account_id` int(10) DEFAULT NULL,
  `employee_id` int(10) DEFAULT NULL,
  `account_id` int(10) DEFAULT NULL,
  `amount_percent` decimal(4,1) DEFAULT NULL,
  `overtime` int(1) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`payroll_account_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_ledger` (
  `ledger_id` int(11) NOT NULL AUTO_INCREMENT,
  `ledger_date` date NOT NULL,
  `ledger_description` text,
  `post_status` varchar(10) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  PRIMARY KEY (`ledger_id`)
) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_ledger_journal` (
  `journal_id` int(11) NOT NULL AUTO_INCREMENT,
  `ledger_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `account_id` int(11) NOT NULL,
  `debit` decimal(11,2) DEFAULT NULL,
  `credit` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`journal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_ledger_recurring` (
  `recurring_ledger_id` int(11) NOT NULL AUTO_INCREMENT,
  `recurring_ledger_start_date` date NOT NULL,
  `recurring_ledger_end_date` date NOT NULL,
  `recurring_ledger_run_date` varchar(20) NOT NULL,
  `recurring_ledger_description` text,
  PRIMARY KEY (`recurring_ledger_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_ledger_recurring_journal` (
  `recurring_journal_id` int(11) NOT NULL AUTO_INCREMENT,
  `recurring_ledger_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `debit` decimal(11,2) DEFAULT NULL,
  `credit` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`recurring_journal_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `general_ledger_status` (
  `status_id` int(11) NOT NULL,
  `closed_months` date NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) NOT NULL,
  `item_description` text,
  `item_unit` varchar(100) DEFAULT NULL,
  `last_purchase` decimal(11,2) DEFAULT NULL,
  `average_purchase` decimal(11,2) DEFAULT NULL,
  `sale_method` varchar(20) DEFAULT NULL,
  `sale_overide` decimal(11,2) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`inventory_id`)
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `item_description` text,
  `item_unit` varchar(100) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `last_purchase` decimal(11,2) DEFAULT NULL,
  `average_purchase` decimal(11,2) DEFAULT NULL,
  `sale_method` varchar(20) DEFAULT NULL,
  `sale_overide` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`inventory_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_locations` (
  `inventory_location_id` int(10) NOT NULL,
  `inventory_id` int(10) NOT NULL,
  `location_id` varchar(12) NOT NULL,
  `quantity` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_purchase_history` (
  `inventory_purchase_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_id` int(11) NOT NULL,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date NOT NULL,
  `vendor` int(11) NOT NULL,
  `purchase_price` decimal(11,2) NOT NULL,
  `quantity_purchased` decimal(15,4) NOT NULL,
  PRIMARY KEY (`inventory_purchase_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory_purchase_history__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `inventory_purchase_history_id` int(11) DEFAULT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor` int(11) DEFAULT NULL,
  `quantity_purchased` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`inventory_purchase_history_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `location_id` varchar(10) NOT NULL,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `locations_all` (
  `location_id` tinyint NOT NULL,
  `location` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_contributions` (
  `payroll_contribution_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` varchar(200) NOT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `repeat_period` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`payroll_contribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_contributions_type` (
  `type_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `account_number_liability` int(10) NOT NULL,
  `account_number_expense` int(10) NOT NULL,
  `annual_limit` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_deductions` (
  `payroll_deduction_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` varchar(200) NOT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `repeat_period` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`payroll_deduction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_deductions_type` (
  `type_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `account_number` varchar(12) NOT NULL,
  `pre_tax` varchar(3) DEFAULT NULL,
  `annual_limit` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries` (
  `payroll_entry_id` int(10) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(10) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `period_number` int(2) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `check_date` date DEFAULT NULL,
  `check_number` varchar(30) DEFAULT NULL,
  `gross_income` decimal(12,2) DEFAULT NULL,
  `wages` decimal(12,2) DEFAULT NULL,
  `ss_wages` decimal(12,2) DEFAULT NULL,
  `total_deductions` decimal(12,2) DEFAULT NULL,
  `total_contributions` decimal(12,2) DEFAULT NULL,
  `gross_income_ytd` decimal(12,2) DEFAULT NULL,
  `wages_ytd` decimal(12,2) DEFAULT NULL,
  `ss_wages_ytd` decimal(12,2) DEFAULT NULL,
  `total_deductions_ytd` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`payroll_entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_contributions` (
  `payroll_contribution_id` int(10) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(10) NOT NULL,
  `payroll_entry_id` int(10) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `account_number_liability` int(10) NOT NULL,
  `account_number_expense` int(10) NOT NULL,
  `annual_limit` decimal(12,2) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `posted_amount` decimal(12,2) DEFAULT NULL,
  `posted_ytd` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`payroll_contribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_contributions_ytd` (
  `payroll_contribution_ytd_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `ytd_amount` decimal(12,2) NOT NULL,
  `year` date NOT NULL,
  PRIMARY KEY (`payroll_contribution_ytd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_deductions` (
  `payroll_deduction_id` int(10) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(10) NOT NULL,
  `payroll_entry_id` int(10) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `pre_tax` varchar(3) DEFAULT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `account_number` varchar(12) NOT NULL,
  `annual_limit` decimal(12,2) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `posted_amount` decimal(12,2) DEFAULT NULL,
  `posted_ytd` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`payroll_deduction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_deductions_ytd` (
  `payroll_deduction_ytd_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `ytd_amount` decimal(12,2) NOT NULL,
  `year` date NOT NULL,
  PRIMARY KEY (`payroll_deduction_ytd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_income` (
  `payroll_income_id` int(10) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` int(10) NOT NULL,
  `payroll_entry_id` int(10) NOT NULL,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `taxable` varchar(3) DEFAULT NULL,
  `hours` decimal(5,2) DEFAULT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `account_number` varchar(12) NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `posted_amount` decimal(12,2) DEFAULT NULL,
  `posted_ytd` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`payroll_income_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_entries_income_ytd` (
  `payroll_income_ytd_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` int(10) NOT NULL,
  `ytd_amount` decimal(12,2) NOT NULL,
  `year` date NOT NULL,
  PRIMARY KEY (`payroll_income_ytd_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_income` (
  `payroll_income_id` int(10) NOT NULL AUTO_INCREMENT,
  `employee_id` int(10) NOT NULL,
  `type` varchar(200) NOT NULL,
  `amount_base` decimal(13,4) DEFAULT NULL,
  `amount_multiply` decimal(13,4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `repeat_period` varchar(10) NOT NULL,
  PRIMARY KEY (`payroll_income_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_income_type` (
  `type_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `account_number` varchar(12) NOT NULL,
  `taxable` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_period` (
  `payroll_period_id` int(10) NOT NULL AUTO_INCREMENT,
  `period_start` date NOT NULL,
  `period_end` date NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `checks_printed` date DEFAULT NULL,
  `period_gross` decimal(12,2) DEFAULT NULL,
  `period_wages` decimal(12,2) DEFAULT NULL,
  `period_ss_wages` decimal(12,2) DEFAULT NULL,
  `period_deductions` decimal(12,2) DEFAULT NULL,
  `period_contributions` decimal(12,2) DEFAULT NULL,
  `year` int(15) DEFAULT NULL,
  PRIMARY KEY (`payroll_period_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_inventory` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`purchase_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_inventory_items` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) NOT NULL,
  `inventory_id` int(11) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_inventory_items__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `purchase_order_id` int(11) DEFAULT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`list_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_office` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_office_items` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) NOT NULL,
  `item` varchar(200) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_service` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `callslip_id` int(11) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_service__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `callslip_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`purchase_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_service_items` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `quantity_used` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  `sale_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_service_items__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `list_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `quantity` int(10) DEFAULT NULL,
  `quantity_received` int(10) DEFAULT NULL,
  `quantity_used` int(10) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  `sale_price` decimal(11,2) DEFAULT NULL,
  `purchase_order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`list_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=170 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_tool` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_tool__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`purchase_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_tool_items` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_vehicle` (
  `purchase_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `vehicle_id` int(10) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  `old_mileage` decimal(7,0) DEFAULT NULL,
  `new_mileage` decimal(7,0) DEFAULT NULL,
  PRIMARY KEY (`purchase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_vehicle__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `vehicle_id` int(10) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `old_mileage` decimal(7,0) DEFAULT NULL,
  `new_mileage` decimal(7,0) DEFAULT NULL,
  `post_status` varchar(20) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `item_total` decimal(11,2) DEFAULT NULL,
  `tax` decimal(6,5) DEFAULT NULL,
  `shipping` decimal(11,2) DEFAULT NULL,
  `total` decimal(11,2) DEFAULT NULL,
  `assigned_voucher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`purchase_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_vehicle_category` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(200) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_vehicle_category__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `category_id` int(10) DEFAULT NULL,
  `category_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`category_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_order_vehicle_items` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int(11) NOT NULL,
  `vehicle_id` int(10) NOT NULL,
  `description` text NOT NULL,
  `category_id` int(10) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`list_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rates` (
  `rate_id` int(10) NOT NULL AUTO_INCREMENT,
  `rate_label` varchar(30) NOT NULL,
  `tech_rt` decimal(6,2) NOT NULL,
  `tech_ot` decimal(6,2) NOT NULL,
  `tech_tt` decimal(6,2) NOT NULL,
  `help_rt` decimal(6,2) NOT NULL,
  `help_ot` decimal(6,2) NOT NULL,
  `help_tt` decimal(6,2) NOT NULL,
  `supr_rt` decimal(6,2) NOT NULL,
  `supr_ot` decimal(6,2) NOT NULL,
  `supr_tt` decimal(6,2) NOT NULL,
  PRIMARY KEY (`rate_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `time_logs` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `category` varchar(5) NOT NULL,
  `callslip_id` int(11) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `rate_id` int(11) DEFAULT NULL,
  `rate_type` varchar(10) DEFAULT NULL,
  `rate_per_hour` decimal(6,2) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory` (
  `tool_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) NOT NULL,
  `item_description` text,
  `last_purchase` decimal(11,2) DEFAULT NULL,
  `average_purchase` decimal(11,2) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`tool_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) DEFAULT NULL,
  `item_description` text,
  `category` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `last_purchase` decimal(11,2) DEFAULT NULL,
  `average_purchase` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`tool_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory_locations` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory_purchase_history` (
  `tool_purchase_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `tool_id` int(11) NOT NULL,
  `purchase_order_id` varchar(12) NOT NULL,
  `purchase_date` date NOT NULL,
  `vendor` int(11) NOT NULL,
  `purchase_price` decimal(11,2) NOT NULL,
  `quantity_purchased` decimal(15,4) NOT NULL,
  PRIMARY KEY (`tool_purchase_history_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tool_inventory_purchase_history__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `tool_purchase_history_id` int(11) DEFAULT NULL,
  `tool_id` int(11) DEFAULT NULL,
  `purchase_order_id` varchar(12) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `vendor` int(11) DEFAULT NULL,
  `quantity_purchased` decimal(15,4) DEFAULT NULL,
  `purchase_price` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`tool_purchase_history_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_inventory` (
  `entry_id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(10) NOT NULL,
  `inventory_id` int(10) NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `entry_id` int(10) DEFAULT NULL,
  `vehicle_id` int(10) DEFAULT NULL,
  `inventory_id` int(10) DEFAULT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`entry_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_misc_items` (
  `entry_id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(10) NOT NULL,
  `item` varchar(200) NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_tools` (
  `entry_id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle_id` int(10) NOT NULL,
  `tool_id` int(10) NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_tools__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `entry_id` int(10) DEFAULT NULL,
  `vehicle_id` int(10) DEFAULT NULL,
  `tool_id` int(10) DEFAULT NULL,
  `quantity` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`entry_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer` (
  `transfer_id` int(10) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `transfer_from` varchar(10) NOT NULL,
  `transfer_to` varchar(10) NOT NULL,
  PRIMARY KEY (`transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `transfer_id` int(10) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `transfer_from` varchar(10) DEFAULT NULL,
  `transfer_to` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`transfer_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer_inventory` (
  `inventory_transfer_id` int(10) NOT NULL AUTO_INCREMENT,
  `transfer_id` int(10) NOT NULL,
  `transfer_from` varchar(10) NOT NULL,
  `transfer_to` varchar(10) NOT NULL,
  `inventory_id` int(10) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`inventory_transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer_inventory__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `inventory_transfer_id` int(10) DEFAULT NULL,
  `transfer_id` int(10) DEFAULT NULL,
  `transfer_from` varchar(10) DEFAULT NULL,
  `transfer_to` varchar(10) DEFAULT NULL,
  `inventory_id` int(10) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`inventory_transfer_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer_tools` (
  `tool_transfer_id` int(10) NOT NULL AUTO_INCREMENT,
  `transfer_id` int(10) NOT NULL,
  `transfer_from` varchar(10) NOT NULL,
  `transfer_to` varchar(10) NOT NULL,
  `tool_id` int(10) NOT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`tool_transfer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicle_transfer_tools__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `tool_transfer_id` int(10) DEFAULT NULL,
  `transfer_id` int(10) DEFAULT NULL,
  `transfer_from` varchar(10) DEFAULT NULL,
  `transfer_to` varchar(10) DEFAULT NULL,
  `tool_id` int(10) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`tool_transfer_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `vehicle_id` int(10) NOT NULL AUTO_INCREMENT,
  `vehicle_number` varchar(100) NOT NULL,
  `vin_number` varchar(20) NOT NULL,
  `assigned_employee_id` int(10) DEFAULT NULL,
  `license_plate_number` varchar(10) DEFAULT NULL,
  `license_plate_type` varchar(20) DEFAULT NULL,
  `mileage` decimal(7,0) DEFAULT NULL,
  `make` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `year` date DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `body_type` varchar(50) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `engine_size` varchar(50) DEFAULT NULL,
  `engine_cycles` varchar(50) DEFAULT NULL,
  `transmission_type` varchar(50) DEFAULT NULL,
  `tire_size` varchar(50) DEFAULT NULL,
  `battery_type` varchar(50) DEFAULT NULL,
  `alarm_type` varchar(50) DEFAULT NULL,
  `date_purchased` date DEFAULT NULL,
  `date_registration_due` date DEFAULT NULL,
  `date_inspection_due` date DEFAULT NULL,
  `date_taxes_due` date DEFAULT NULL,
  `registration_fee` decimal(10,2) DEFAULT NULL,
  `ownership_status` varchar(10) DEFAULT NULL,
  `lease_number` varchar(50) DEFAULT NULL,
  `purchase_vendor_id` int(10) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_po` int(10) DEFAULT NULL,
  `purchase_price` decimal(12,2) DEFAULT NULL,
  `lease_vendor_id` int(10) DEFAULT NULL,
  `lease_date` date DEFAULT NULL,
  `lease_price` decimal(12,2) DEFAULT NULL,
  `lease_buy_back` decimal(12,2) DEFAULT NULL,
  `lease_deposit` date DEFAULT NULL,
  `lease_payment_frequency` varchar(20) DEFAULT NULL,
  `lease_payment_amount` decimal(12,2) DEFAULT NULL,
  `insurance_vendor_id` int(10) DEFAULT NULL,
  `insurance_issued_to` varchar(100) DEFAULT NULL,
  `insurance_price` decimal(12,2) DEFAULT NULL,
  `insurance_type` varchar(50) DEFAULT NULL,
  `insurance_payment_frequency` varchar(20) DEFAULT NULL,
  `insurance_payment_amount` decimal(12,2) DEFAULT NULL,
  `use_as_location` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `vehicle_id` int(10) DEFAULT NULL,
  `vehicle_number` varchar(100) DEFAULT NULL,
  `assigned_employee_id` int(10) DEFAULT NULL,
  `date_purchased` date DEFAULT NULL,
  `lease_number` varchar(50) DEFAULT NULL,
  `purchase_vendor_id` int(10) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_po` int(10) DEFAULT NULL,
  `purchase_price` decimal(12,2) DEFAULT NULL,
  `lease_vendor_id` int(10) DEFAULT NULL,
  `lease_date` date DEFAULT NULL,
  `lease_price` decimal(12,2) DEFAULT NULL,
  `lease_buy_back` decimal(12,2) DEFAULT NULL,
  `lease_deposit` date DEFAULT NULL,
  `lease_payment_frequency` varchar(20) DEFAULT NULL,
  `lease_payment_amount` decimal(12,2) DEFAULT NULL,
  `insurance_vendor_id` int(10) DEFAULT NULL,
  `insurance_issued_to` varchar(100) DEFAULT NULL,
  `insurance_price` decimal(12,2) DEFAULT NULL,
  `insurance_type` varchar(50) DEFAULT NULL,
  `insurance_payment_frequency` varchar(20) DEFAULT NULL,
  `insurance_payment_amount` decimal(12,2) DEFAULT NULL,
  `use_as_location` varchar(5) DEFAULT NULL,
  `vin_number` varchar(20) DEFAULT NULL,
  `license_plate_number` varchar(10) DEFAULT NULL,
  `license_plate_type` varchar(20) DEFAULT NULL,
  `ownership_status` varchar(10) DEFAULT NULL,
  `mileage` int(7) DEFAULT NULL,
  `make` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `year` date DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `body_type` varchar(50) DEFAULT NULL,
  `weight` decimal(10,2) DEFAULT NULL,
  `engine_size` varchar(50) DEFAULT NULL,
  `engine_cycles` varchar(50) DEFAULT NULL,
  `transmission_type` varchar(50) DEFAULT NULL,
  `tire_size` varchar(50) DEFAULT NULL,
  `battery_type` varchar(50) DEFAULT NULL,
  `alarm_type` varchar(50) DEFAULT NULL,
  `date_registration_due` date DEFAULT NULL,
  `registration_fee` decimal(10,2) DEFAULT NULL,
  `date_inspection_due` date DEFAULT NULL,
  `date_taxes_due` date DEFAULT NULL,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`vehicle_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_contacts` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) NOT NULL,
  `contact_name` varchar(200) NOT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_email` varchar(200) DEFAULT NULL,
  `contact_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor_industry` (
  `vendor_industry_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_industry` varchar(50) NOT NULL,
  PRIMARY KEY (`vendor_industry_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendors` (
  `vendor_id` int(10) NOT NULL AUTO_INCREMENT,
  `vendor` varchar(99) NOT NULL,
  `account_number` varchar(15) DEFAULT NULL,
  `vendor_type` varchar(20) DEFAULT NULL,
  `vendor_industry` varchar(30) DEFAULT NULL,
  `rec_1099` varchar(5) DEFAULT NULL,
  `tax_id` varchar(12) DEFAULT NULL,
  `physical_address` varchar(200) NOT NULL,
  `physical_city` varchar(30) NOT NULL,
  `physical_state` varchar(3) NOT NULL,
  `physical_zip` varchar(10) NOT NULL,
  `remittance_address` varchar(200) DEFAULT NULL,
  `remittance_city` varchar(30) DEFAULT NULL,
  `remittance_state` varchar(3) DEFAULT NULL,
  `remittance_zip` varchar(10) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `web_address` varchar(200) DEFAULT NULL,
  `due_days` int(2) DEFAULT NULL,
  `discount_day` int(2) DEFAULT NULL,
  `discount_percent` int(2) DEFAULT NULL,
  `coi_exp_date_general_liability` date DEFAULT NULL,
  `coi_exp_date_workers_comp` date DEFAULT NULL,
  `coi_exp_date_umbrella` date DEFAULT NULL,
  `coi_exp_date_auto` date DEFAULT NULL,
  `resale_number` varchar(15) DEFAULT NULL,
  `resale_expiration_date` date DEFAULT NULL,
  `default_account` int(11) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`vendor_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendors__history` (
  `history__id` int(11) NOT NULL AUTO_INCREMENT,
  `history__language` varchar(2) DEFAULT NULL,
  `history__comments` text,
  `history__user` varchar(32) DEFAULT NULL,
  `history__state` int(5) DEFAULT '0',
  `history__modified` datetime DEFAULT NULL,
  `vendor_id` int(10) DEFAULT NULL,
  `vendor` varchar(99) DEFAULT NULL,
  `account_number` varchar(15) DEFAULT NULL,
  `vendor_type` varchar(20) DEFAULT NULL,
  `vendor_industry` varchar(30) DEFAULT NULL,
  `rec_1099` varchar(5) DEFAULT NULL,
  `tax_id` varchar(12) DEFAULT NULL,
  `physical_address` varchar(200) DEFAULT NULL,
  `physical_city` varchar(30) DEFAULT NULL,
  `physical_state` varchar(3) DEFAULT NULL,
  `physical_zip` varchar(10) DEFAULT NULL,
  `remittance_address` varchar(200) DEFAULT NULL,
  `remittance_city` varchar(30) DEFAULT NULL,
  `remittance_state` varchar(3) DEFAULT NULL,
  `remittance_zip` varchar(10) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `web_address` varchar(200) DEFAULT NULL,
  `due_days` int(2) DEFAULT NULL,
  `discount_day` int(2) DEFAULT NULL,
  `discount_percent` int(2) DEFAULT NULL,
  `coi_exp_date_general_liability` date DEFAULT NULL,
  `coi_exp_date_workers_comp` date DEFAULT NULL,
  `coi_exp_date_umbrella` date DEFAULT NULL,
  `coi_exp_date_auto` date DEFAULT NULL,
  `resale_number` varchar(15) DEFAULT NULL,
  `resale_expiration_date` date DEFAULT NULL,
  `default_account` int(11) DEFAULT NULL,
  `details` text,
  PRIMARY KEY (`history__id`),
  KEY `prikeys` (`vendor_id`) USING HASH,
  KEY `datekeys` (`history__modified`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP TABLE IF EXISTS `accounts_payable_unassigned_purchase_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `accounts_payable_unassigned_purchase_orders` AS (select `purchase_order_inventory`.`purchase_order_id` AS `purchase_order_id`,`purchase_order_inventory`.`assigned_voucher_id` AS `assigned_voucher_id`,`purchase_order_inventory`.`vendor_id` AS `vendor_id` from `purchase_order_inventory` where isnull(`purchase_order_inventory`.`assigned_voucher_id`)) union (select `purchase_order_service`.`purchase_order_id` AS `purchase_order_id`,`purchase_order_service`.`assigned_voucher_id` AS `assigned_voucher_id`,`purchase_order_service`.`vendor_id` AS `vendor_id` from `purchase_order_service` where isnull(`purchase_order_service`.`assigned_voucher_id`)) union (select `purchase_order_tool`.`purchase_order_id` AS `purchase_order_id`,`purchase_order_tool`.`assigned_voucher_id` AS `assigned_voucher_id`,`purchase_order_tool`.`vendor_id` AS `vendor_id` from `purchase_order_tool` where isnull(`purchase_order_tool`.`assigned_voucher_id`)) union (select `purchase_order_vehicle`.`purchase_order_id` AS `purchase_order_id`,`purchase_order_vehicle`.`assigned_voucher_id` AS `assigned_voucher_id`,`purchase_order_vehicle`.`vendor_id` AS `vendor_id` from `purchase_order_vehicle` where isnull(`purchase_order_vehicle`.`assigned_voucher_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `call_slip_purchase_orders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `call_slip_purchase_orders` AS select `purchase_order_service_items`.`list_id` AS `list_id`,`purchase_order_service_items`.`purchase_order_id` AS `purchase_id`,`purchase_order_service_items`.`item_name` AS `item_name`,`purchase_order_service_items`.`quantity` AS `quantity`,`purchase_order_service_items`.`quantity_used` AS `quantity_used`,`purchase_order_service_items`.`sale_price` AS `sale_price`,`purchase_order_service_items`.`purchase_price` AS `purchase_price`,`purchase_order_service`.`callslip_id` AS `callslip_id`,`purchase_order_service`.`post_status` AS `post_status` from (`purchase_order_service_items` join `purchase_order_service`) where (`purchase_order_service_items`.`purchase_order_id` = `purchase_order_service`.`purchase_id`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `dataface__view_a61fbcecd9051777794f538b7978fbac`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dataface__view_a61fbcecd9051777794f538b7978fbac` AS select `inventory`.`inventory_id` AS `inventory_id`,`inventory`.`item_name` AS `item_name`,`inventory`.`item_description` AS `item_description`,`inventory`.`item_unit` AS `item_unit`,`inventory`.`last_purchase` AS `last_purchase`,`inventory`.`average_purchase` AS `average_purchase`,`inventory`.`sale_method` AS `sale_method`,`inventory`.`sale_overide` AS `sale_overide`,`inventory`.`quantity` AS `quantity`,`inventory`.`category` AS `category`,`inventory`.`quantity` AS `vehicle_quantity`,`inventory`.`quantity` AS `stock_quantity` from `inventory` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `dataface__view_b8f350bcba1ab951a2db277006c85bfd`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `dataface__view_b8f350bcba1ab951a2db277006c85bfd` AS select `call_slips`.`call_id` AS `call_id`,`call_slips`.`customer_id` AS `customer_id`,`call_slips`.`site_id` AS `site_id`,`call_slips`.`status` AS `status`,`call_slips`.`post_status` AS `post_status`,`call_slips`.`quoted_cost` AS `quoted_cost`,`call_slips`.`contract_id` AS `contract_id`,`call_slips`.`type` AS `type`,`call_slips`.`work_order_number` AS `work_order_number`,`call_slips`.`po_number` AS `po_number`,`call_slips`.`customer_po` AS `customer_po`,`call_slips`.`problem` AS `problem`,`call_slips`.`call_instructions` AS `call_instructions`,`call_slips`.`call_datetime` AS `call_datetime`,`call_slips`.`site_instructions` AS `site_instructions`,`call_slips`.`technician` AS `technician`,`call_slips`.`scheduled_datetime` AS `scheduled_datetime`,`call_slips`.`desc_of_work` AS `desc_of_work`,`call_slips`.`completion_date` AS `completion_date`,`call_slips`.`charge_consumables` AS `charge_consumables`,`call_slips`.`charge_fuel` AS `charge_fuel`,`call_slips`.`tax` AS `tax`,`call_slips`.`total_charge` AS `total_charge`,`call_slips`.`credit` AS `credit`,`call_slips`.`ar_billing_id` AS `ar_billing_id`,concat(`call_slips`.`call_id`) AS `search_field` from `call_slips` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP TABLE IF EXISTS `locations_all`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `locations_all` AS select `locations`.`location_id` AS `location_id`,`locations`.`location` AS `location` from `locations` union select `vehicles`.`vehicle_id` AS `location_id`,concat('Vehicle - ',`vehicles`.`vehicle_number`) AS `vehicle_number` from `vehicles` where (`vehicles`.`use_as_location` = 'Y') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

