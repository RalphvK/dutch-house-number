<?php

require_once 'DutchHouseNumber.php';

class Color {
    const GREEN = "\033[32m";
    const RED = "\033[31m";
    const RESET = "\033[0m";
}

$test_strings = [
    '2' => ['number' => '2', 'addition' => null, 'letter' => null],
    '2a' => ['number' => '2', 'addition' => null, 'letter' => 'A'],
    '2-2' => ['number' => '2', 'addition' => '2', 'letter' => null],
    '2-2a' => ['number' => '2', 'addition' => '2', 'letter' => 'A'],
    '2-Bis A' => ['number' => '2', 'addition' => 'BIS', 'letter' => 'A'],
    '32-a-bis' => ['number' => '32', 'addition' => 'BIS', 'letter' => 'A']
];

foreach ($test_strings as $string => $expected) {
    $result = DutchHouseNumber::split_number_string($string);
    if ($result == $expected) {
        echo Color::GREEN . "$string: " . Color::RESET . "Expected = " . json_encode($expected) . " | Result = " . json_encode($result) . "\n";
    } else {
        echo Color::RED . "$string: " . Color::RESET . "Expected = " . json_encode($expected) . " | Result = " . json_encode($result) . "\n";
    }
}
