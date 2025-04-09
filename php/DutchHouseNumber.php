<?php

class DutchHouseNumber {

  public static function split_number_string($street_number_string = null, $return_type = 'array')
  {
    $fields = [
      'number' => null,
      'addition' => null,
      'letter' => null
    ];
    if (!$street_number_string || $street_number_string == '') {
      return self::return_type($return_type, $fields);
    }
    // explode number
    $exploded = self::explode_number($street_number_string);
    // if just one number, it is the number
    if (count($exploded) == 1) {
      $fields['number'] = $exploded[0];
      return self::return_type($return_type, $fields);
    }

    // ELSE if more than one part, the first part is the number
    $fields['number'] = $exploded[0];
    // iterate through other parts
    for ($i = 1; $i < count($exploded); $i++) {
      $part = $exploded[$i];
      // if part is a single letter, it is the house letter
      if (strlen($part) == 1 && preg_match('/^[a-zA-Z]$/', $part)) {
        $fields['letter'] = $part;
        continue;
      }
      // if part is numeric chars only, it is the addition
      if (preg_match('/^\d+$/', $part)) {
        $fields['addition'] .= $part;
        continue;
      }
      // if it is multiple non-numeric chars, it is the addition
      if (preg_match('/^[a-zA-Z]+$/', $part)) {
        $fields['addition'] .= $part;
        continue;
      }
    }
    return self::return_type($return_type, $fields);
  }

  public static function explode_number($string = null) {
    $string = strtoupper($string);
    // trim whitespace
    $string = trim($string);
    // trim - and / from start and end
    $string = trim($string, '-/');
    // explode on - or /, then split on groups of letters and numbers
    $addition_letter_array = [];
    foreach (preg_split('/[ -\/]/', $string) as $key => $string) {
      array_push($addition_letter_array, ...preg_split('/(?<=[a-zA-Z])(?=\d)|(?<=\d)(?=[a-zA-Z])/', $string));
    }
    return $addition_letter_array;
  }

  public static function return_type($type_string = 'array', $fields_array = []) {
    if ($type_string == 'array') {
      return $fields_array;
    }
    if ($type_string == 'stdObject') {
      return (object) $fields_array;
    }
    if ($type_string == 'dataObject') {
      return new dataObject($fields_array);
    }
    if ($type_string == 'json') {
      return json_encode($fields_array);
    }
    if ($type_string == 'string') {
      return implode(';', $fields_array);
    }
    return $fields_array;
  }

}