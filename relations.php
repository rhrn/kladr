<?php

  $host = 'localhost';
  $base = 'kladr';
  $user = 'kladr';
  $pass = 'kladr';

  $limit = 9999999999999;

  $mysqli = new MySQLi($host, $user, $pass, $base);
  $mysqli->query("SET NAMES 'utf8'");

  $sql = 'SELECT * FROM `kladr` ORDER BY `kladr`.`code` ASC LIMIT ' . $limit . ' OFFSET 1';
  $kladrs = $mysqli->query($sql, MYSQLI_USE_RESULT);

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
  $streets = $mysqli->query($sql, MYSQLI_USE_RESULT);

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

  $mysqli->close();
