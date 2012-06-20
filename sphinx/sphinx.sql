CREATE OR REPLACE VIEW `doma_index_search` AS
SELECT
  -- *
  doma.id AS id
  , doma.index AS doma_index
  , GROUP_CONCAT(doma.doma SEPARATOR ' ') AS `doma_name`
  -- , CONCAT_WS(' ', street.socr, street.name) AS street_name
  , street.name AS street_name
  , street.socr AS street_socr
  -- , street_full_socr.socrname AS street_full_socr
  , street.index AS street_index
  -- , CONCAT_WS(' ', kladr.socr, kladr.name) AS kladr_name
  , kladr.name AS kladr_name
  , kladr.socr AS kladr_socr
  -- , kladr_full_socr.socrname AS kladr_full_socr
  , kladr.index AS kladr_index
  , pindx.index AS pindx_index
  , pindx.opsname AS pindx_opsname
  , pindx.region AS pindx_region
  , pindx.area AS pindx_area
  , pindx.city AS city_name
FROM `doma`
LEFT JOIN `street` ON `street`.`id` = `doma`.`street_id`
LEFT JOIN `kladr` ON `kladr`.`id` = `street`.`kladr_id`
LEFT JOIN `pindx` ON `pindx`.`index` = `kladr`.`index`
-- LEFT JOIN `socrbase` AS `kladr_full_socr` ON `kladr_full_socr`.`scname` = `kladr`.`socr`
-- LEFT JOIN `socrbase` AS `street_full_socr` ON `street_full_socr`.`scname` = `street`.`socr`
GROUP BY `doma`.`street_id`, doma_index;
