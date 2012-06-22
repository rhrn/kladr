-- doma
CREATE OR REPLACE VIEW `doma_index_search` AS
SELECT
  -- *
  doma.id AS id
  , doma.index AS doma_index
  , GROUP_CONCAT(DISTINCT doma.doma SEPARATOR ' ') AS `doma_doma`
  -- , CONCAT_WS(' ', street.socr, street.name) AS street_name
  , street.name AS street_name
  , street.socr AS street_socr
  , LOWER(street_socrbase.socrname) AS street_socrname
  , street_socrbase.level AS street_level
  , street.index AS street_index
  -- , CONCAT_WS(' ', kladr.socr, kladr.name) AS kladr_name
  , kladr.name AS kladr_name
  , kladr.socr AS kladr_socr
  , LOWER(kladr_socrbase.socrname) AS kladr_socrname
  , kladr_socrbase.level AS kladr_level
  , kladr.index AS kladr_index
  , pindx.index AS pindx_index
  , LOWER(pindx.opsname) AS pindx_opsname
  , LOWER(pindx.region) AS pindx_region
  , LOWER(pindx.autonom) AS pindx_autonom
  , LOWER(pindx.area) AS pindx_area
  , LOWER(pindx.city) AS pindx_city
FROM `doma`
LEFT JOIN `street` ON `street`.`id` = `doma`.`street_id`
LEFT JOIN `kladr` ON `kladr`.`id` = `street`.`kladr_id`
LEFT JOIN `pindx` ON `pindx`.`index` = `kladr`.`index`
LEFT JOIN `socrbase` AS `street_socrbase` ON `street_socrbase`.`scname` = `street`.`socr`
LEFT JOIN `socrbase` AS `kladr_socrbase` ON `kladr_socrbase`.`scname` = `kladr`.`socr`
GROUP BY `doma`.`street_id`, `doma`.`index`;


-- kladr
CREATE OR REPLACE VIEW `kladr_search` AS
SELECT
  -- *
  kladr.id AS id
  , kladr.index AS kladr_index
  -- , CONCAT_WS(' ', kladr.socr, kladr.name) AS kladr_name
  , kladr.name AS kladr_name
  , kladr.socr AS kladr_socr
  , LOWER(kladr_socrbase.socrname) AS kladr_socrname
  , kladr_socrbase.level AS kladr_level
  , pindx.index AS pindx_index
  , LOWER(pindx.opsname) AS pindx_opsname
  , LOWER(pindx.region) AS pindx_region
  , LOWER(pindx.autonom) AS pindx_autonom
  , LOWER(pindx.area) AS pindx_area
  , LOWER(pindx.city) AS pindx_city
FROM `kladr`
LEFT JOIN `pindx` ON `pindx`.`index` = `kladr`.`index`
LEFT JOIN `socrbase` AS `kladr_socrbase` ON `kladr_socrbase`.`scname` = `kladr`.`socr`
GROUP BY `kladr`.`id`;
