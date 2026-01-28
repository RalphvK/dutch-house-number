<?php

require_once 'DutchHouseNumber.php';

class Color {
    const GREEN = "\033[32m";
    const RED = "\033[31m";
    const RESET = "\033[0m";
}

$test_strings = [
    '2' => [
        'number' => '2',
        'addition' => null,
        'letter' => null,
        'normalised_string' => '2'
    ],
    '2a' => [
        'number' => '2',
        'addition' => null,
        'letter' => 'A',
        'normalised_string' => '2A'
    ],
    '2-2' => [
        'number' => '2',
        'addition' => '2',
        'letter' => null,
        'normalised_string' => '2-2'
    ],
    '47K-304' => [
        'number' => '47',
        'addition' => '304',
        'letter' => 'K',
        'normalised_string' => '47K-304'
    ],
    '2-Bis A' => [
        'number' => '2',
        'addition' => 'BIS',
        'letter' => 'A',
        'normalised_string' => '2A-BIS'
    ],
    '32-a-bis' => [
        'number' => '32',
        'addition' => 'BIS',
        'letter' => 'A',
        'normalised_string' => '32A-BIS'
    ],
    '9-BX04' => [
        'number' => '9',
        'addition' => 'BX04',
        'letter' => null,
        'normalised_string' => '9-BX04'
    ],
    '9-B04' => [
        'number' => '9',
        'addition' => '04',
        'letter' => 'B',
        'normalised_string' => '9B-04'
    ],
    '9B-BX04' => [
        'number' => '9',
        'addition' => 'BX04',
        'letter' => 'B',
        'normalised_string' => '9B-BX04'
    ],
    '2-A-23' => [
        'number' => '2',
        'addition' => '23',
        'letter' => 'A',
        'normalised_string' => '2A-23'
    ],
];

foreach ($test_strings as $string => $expected) {
    $result = DutchHouseNumber::split_number_string($string);
    $normalised = DutchHouseNumber::to_normalised_string($string);
    
    $number_match = $result['number'] === $expected['number'];
    $addition_match = $result['addition'] === $expected['addition'];
    $letter_match = $result['letter'] === $expected['letter'];
    $normalised_match = $normalised === $expected['normalised_string'];
    
    $all_match = $number_match && $addition_match && $letter_match && $normalised_match;
    
    $color = $all_match ? Color::GREEN : Color::RED;
    
    echo $color . "$string: " . Color::RESET . "\n";
    echo "  Number: " . ($number_match ? Color::GREEN : Color::RED) . $result['number'] . Color::RESET . " (expected: {$expected['number']})\n";
    echo "  Addition: " . ($addition_match ? Color::GREEN : Color::RED) . ($result['addition'] ?? 'null') . Color::RESET . " (expected: " . ($expected['addition'] ?? 'null') . ")\n";
    echo "  Letter: " . ($letter_match ? Color::GREEN : Color::RED) . ($result['letter'] ?? 'null') . Color::RESET . " (expected: " . ($expected['letter'] ?? 'null') . ")\n";
    echo "  Normalised: " . ($normalised_match ? Color::GREEN : Color::RED) . $normalised . Color::RESET . " (expected: {$expected['normalised_string']})\n";
    echo "\n";
}
