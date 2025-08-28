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

    // IF just one number, it is the number
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

  public static function to_normalised_string($street_number = null)
  {
    // if string, check if it's JSON first, then semicolon-separated, then treat as regular string
    if (is_string($street_number)) {
      // if JSON string, decode it
      if (json_decode($street_number) !== null) {
        $street_number = json_decode($street_number, true);
      }
      // if semicolon-separated string, convert to array
      else if (strpos($street_number, ';') !== false) {
        $parts = explode(';', $street_number);
        $street_number = [
          'number' => $parts[0] ?? null,
          'addition' => $parts[1] ?? null,
          'letter' => $parts[2] ?? null
        ];
      }
      // otherwise, split the string into parts
      else {
        $street_number = self::split_number_string($street_number, 'array');
      }
    }
    // if stdObject, convert to array
    else if (is_object($street_number)) {
      $street_number = (array) $street_number;
    }
    // if integer, convert to array format
    else if (is_int($street_number)) {
      $street_number = [
        'number' => $street_number,
        'addition' => null,
        'letter' => null
      ];
    }

    // generate normalised string - ensure it's always a string
    $normalised = (string) $street_number['number'];
    if (!empty($street_number['letter'])) {
      $normalised .= $street_number['letter'];
    }
    if (!empty($street_number['addition'])) {
      $normalised .= '-' . $street_number['addition'];
    }

    return $normalised;
  }

}