<?php

  $db = false;

  if($argc >= 2) {

    $table      = 'table';
    $iconvFrom  = '866';
    $iconvTo    = 'UTF-8';
    $delimetr   = ',';

    $file = end($argv);
    $opt = getopt("t:l:c"); #print_r ($opt);

    $table = (empty($opt['t']))? $table : $opt['t'];

    $db = dbase_open($file, 0);
  }

  if ($db) {

    $info         = dbase_get_header_info($db); #print_r($info); 
    $fields       = dbase_numfields($db);
    $records      = dbase_numrecords($db);

    if (isset($opt['c'])) {

      $sql = array();

      $sql[] = 'CREATE TABLE `' . $table . '` (';

      $columns = array();

      foreach ($info as $i) {

          if ($i['type'] == 'character') {
            $type = 'VARCHAR('. $i['length'] . ')';
          } elseif ($i['type'] == 'number') {
            $type = 'INT(10)';
          } elseif ($i['type'] == 'date') {
            $type = 'DATETIME';
          } elseif ($i['type'] == 'memo') {
            $type = 'VARCHAR(500)';
          }

          $columns[] = '  `' . strtolower($i['name']) . '` ' . $type;
      }

      $sql[] = implode(',' . PHP_EOL, $columns);

      $sql[] = ');' . PHP_EOL;

      echo implode(PHP_EOL, $sql);

    }
  
    $records = (empty($opt['l']))? $records : $opt['l'];

    $sql = array();

    $sql[] = 'INSERT INTO `' . $table . '`';

    $columns = array();
    foreach ($info as $i) {
      $columns[] = '`'.strtolower($i['name']) . '`';
    }

    $sql[] = '(' . implode(', ', $columns). ') VALUES';

    $values = array();
    for ($i = 1; $i <= $records; $i++) {
      $row  = dbase_get_record_with_names($db, $i); #print_r($row);
      $line = array();
      foreach ($info as $j) {
        $line[] = "'" . addcslashes(iconv($iconvFrom, $iconvTo, trim($row[$j['name']])), "'") . "'";
      }
      $values[] = '(' . implode($delimetr, $line) . ')';
    }

    $sql[] = implode(', ' . PHP_EOL, $values) . ';';

    echo implode(PHP_EOL, $sql);

    dbase_close($db);
  }
