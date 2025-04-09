# DutchHouseNumber

The `DutchHouseNumber` class provides utility methods to parse and split Dutch-style house numbers into their components, such as the main number, letter, and addition.

## Methods

### `split_number_string($street_number_string = null, $return_type = 'array')`

Splits a Dutch-style house number string into its components.

#### Parameters:
- **`$street_number_string`** *(string|null)*: The house number string to split. Defaults to `null`.
- **`$return_type`** *(string)*: The format of the returned data. Supported types:
  - `'array'` (default): Returns an associative array.
  - `'stdObject'`: Returns a `stdClass` object.
  - `'dataObject'`: Returns a `dataObject` instance.
  - `'json'`: Returns a JSON string.
  - `'string'`: Returns a semicolon-separated string.

#### Returns:
An array, object, or string containing the following fields:
- `number`: The main house number.
- `addition`: Any additional numeric or alphabetic part.
- `letter`: A single letter associated with the house number.

#### Example:
```php
$result = DutchHouseNumber::split_number_string('123A-4', 'array');
// Output: ['number' => '123', 'addition' => '4', 'letter' => 'A']
```

---

### `explode_number($string = null)`

Splits a house number string into its components based on delimiters and patterns.

#### Parameters:
- **`$string`** *(string|null)*: The house number string to process. Defaults to `null`.

#### Returns:
An array of components split from the input string.

#### Example:
```php
$result = DutchHouseNumber::explode_number('123A-4');
// Output: ['123', 'A', '4']
```

---

### `return_type($type_string = 'array', $fields_array = [])`

Formats the parsed house number components into the specified return type.

#### Parameters:
- **`$type_string`** *(string)*: The desired return type. Supported types:
  - `'array'`
  - `'stdObject'`
  - `'dataObject'`
  - `'json'`
  - `'string'`
- **`$fields_array`** *(array)*: The parsed house number components.

#### Returns:
The formatted data in the specified type.

---

## Usage

Include the `DutchHouseNumber` class in your project and use its static methods to parse Dutch-style house numbers.

#### Example:
```php
require_once 'DutchHouseNumber.php';

$parsed = DutchHouseNumber::split_number_string('123B-56', 'json');
echo $parsed; // {"number":"123","addition":"56","letter":"B"}
```

---

## Running Tests

To validate the functionality of the `DutchHouseNumber` class, you can run the provided test script. 

### Command:
```bash
cd php
php test.php
```

The script will output the test results, showing whether the expected output matches the actual output for various test cases.

---

## License

This project is licensed under the MIT License.
