<?php

  $db = include("db.php");

  $db->query("SET NAMES 'utf8'");

  $limit = 9999999999999;

  $sql = 'SELECT * FROM `kladr` ORDER BY `kladr`.`code` ASC LIMIT ' . $limit . ' OFFSET 1';
  $kladrs = $db->query($sql, MYSQLI_USE_RESULT);

  $id = 1; 
  $code_start = '01000000000000000';
  while($kladr = $kladrs->fetch_object()) {

    $code_end = $kladr->code . '0000';

    $update = 'UPDATE `street` SET `kladr_id` = ' . $id .' WHERE `code` >= "'.$code_start.'" AND `code` < "'.$code_end.'";';

    echo $update . PHP_EOL;

    $id = $kladr->id;
    $code_start = $code_end;
  }

  $kladrs->close();

  $sql = 'SELECT * FROM `street` ORDER BY `street`.`code` ASC LIMIT ' . $limit . ' OFFSET 1';
  $streets = $db->query($sql, MYSQLI_USE_RESULT);

  $id = 1;
  $code_start = '0100000100000010000';
  while($street = $streets->fetch_object()) {
    
    $code_end = $street->code . '00';

    $update = 'UPDATE `doma` SET `street_id` = ' . $id .' WHERE `code` >= "'.$code_start.'" AND `code` < "'.$code_end.'";';

    echo $update . PHP_EOL;

    $id = $street->id;
    $code_start = $code_end;
  }

  $streets->close();

  $db->close();
