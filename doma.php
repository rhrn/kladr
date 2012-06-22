<?php

  $db = include("db.php");

  $db->query("SET NAMES 'utf8'");

  $sql = "SELECT * FROM `doma`";

  $doma = $db->query($sql, MYSQLI_USE_RESULT);

  $replace = array(
    ',' => ' ',
    '_' => ' ',
    'литер' => ' ',
    'БЛОК' => ' ',
    'ЗОНА' => ' '
  );

  function doma_verbose($pattern, $name, $increment) {

    $t = '';

    preg_match_all($pattern, $name, $matches);

    $count1 = sizeof($matches[1]);
    $count2 = sizeof($matches[2]);

    $t = '';
    if ($count1 === $count2) {

        for($i = 0; $i < $count1; $i++) {

            $from = $matches[1][$i];
            $to = $matches[2][$i];

            $t .= ' ';
            for($d = $from; $d < $to; $d = $d + $increment) {
              $t .= $d . ' ';
            }
            $t .= $to;
        }

    }

    return $t;
  }

  while($dom = $doma->fetch_object()) {

    $name = str_replace(array_keys($replace), array_values($replace), $dom->name);

    $name .= doma_verbose('/\((\d+)\-(\d+)\)/', $name, 2);
    $name = preg_replace('/(Н|Ч)\(.+\)/', '', $name);

    $name .= doma_verbose('/(\d+)\-(\d+)/', $name, 1);
    $name = preg_replace('/(\d+)\-(\d+)/', '', $name);

    echo 'UPDATE `doma` SET `doma` = "' . $name . '" WHERE id = ' . $dom->id . ';' . PHP_EOL;

  }

  $doma->close();
  $db->close();

