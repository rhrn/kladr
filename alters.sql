ALTER TABLE  `pindx` CHANGE  `index`  `index` INT( 6 ) UNSIGNED ZEROFILL NOT NULL;
ALTER TABLE  `pindx` ADD UNIQUE ( `index` );
ALTER TABLE  `pindx` ADD INDEX (  `opsname` );
ALTER TABLE  `pindx` ADD INDEX (  `opssubm` );

ALTER TABLE  `kladr` CHANGE  `index`  `index` INT( 6 ) UNSIGNED ZEROFILL NULL DEFAULT NULL;
ALTER TABLE  `kladr` ADD INDEX (  `index` );
ALTER TABLE  `kladr` ADD INDEX (  `name` );
ALTER TABLE  `kladr` ADD INDEX (  `socr` );
ALTER TABLE  `kladr` ADD UNIQUE (  `code` );

ALTER TABLE  `street` CHANGE  `index`  `index` INT( 6 ) UNSIGNED ZEROFILL NULL DEFAULT NULL;
ALTER TABLE  `street` ADD INDEX (  `index` );
ALTER TABLE  `street` ADD UNIQUE ( `code` );
ALTER TABLE  `street` ADD INDEX (  `name` );
ALTER TABLE  `street` ADD INDEX (  `socr` );

ALTER TABLE  `doma` CHANGE  `index`  `index` INT( 6 ) UNSIGNED ZEROFILL NULL DEFAULT NULL;
ALTER TABLE  `doma` ADD INDEX (  `index` );
ALTER TABLE  `doma` ADD UNIQUE ( `code` );
ALTER TABLE  `doma` ADD INDEX (  `name` );
ALTER TABLE  `doma` ADD INDEX (  `socr` );

ALTER TABLE  `socrbase` ADD INDEX (  `scname` );

ALTER TABLE  `kladr` ADD  `id` INT( 6 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE  `street` ADD  `id` INT( 7 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE  `doma` ADD  `id` INT( 8 ) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

ALTER TABLE  `street` ADD  `kladr_id` INT( 6 ) UNSIGNED NULL AFTER  `id` , ADD INDEX (  `kladr_id` );
ALTER TABLE  `doma` ADD  `street_id` INT( 7 ) UNSIGNED NULL AFTER  `id`;
ALTER TABLE  `doma` ADD  `doma` TEXT NOT NULL DEFAULT  '' AFTER  `name`;
