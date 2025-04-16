# DutchHouseNumber (JavaScript)

The `DutchHouseNumber` module provides utility functions to parse and split Dutch-style house numbers into their components, such as the main number, letter, and addition.

## Functions

### `splitNumberString(streetNumberString = null)`

Splits a Dutch-style house number string into its components.

#### Parameters:
- **`streetNumberString`** *(string|null)*: The house number string to split. Defaults to `null`.

#### Returns:
An object containing the following fields:
- `number`: The main house number.
- `addition`: Any additional numeric or alphabetic part.
- `letter`: A single letter associated with the house number.

#### Example:
```javascript
import { splitNumberString } from './DutchHouseNumber.js';

const result = splitNumberString('123A-4');
// Output: { number: '123', addition: '4', letter: 'A' }
```

---

### `explodeNumber(string = null)`

Splits a house number string into its components based on delimiters and patterns.

#### Parameters:
- **`string`** *(string|null)*: The house number string to process. Defaults to `null`.

#### Returns:
An array of components split from the input string.

#### Example:
```javascript
import { explodeNumber } from './DutchHouseNumber.js';

const result = explodeNumber('123A-4');
// Output: ['123', 'A', '4']
```

---

### `returnTypeHandler(typeString = 'array', fieldsObject = {})`

Formats the parsed house number components into the specified return type.

#### Parameters:
- **`typeString`** *(string)*: The desired return type. Supported types:
  - `'array'`
  - `'stdObject'`
  - `'json'`
  - `'string'`
- **`fieldsObject`** *(object)*: The parsed house number components.

#### Returns:
The formatted data in the specified type.

---

## Usage

Include the `DutchHouseNumber` module in your project and use its functions to parse Dutch-style house numbers.

#### Example:
```javascript
import { splitNumberString } from './DutchHouseNumber.js';

const parsed = splitNumberString('123B-56');
console.log(parsed); // { number: '123', addition: '56', letter: 'B' }
```

---

## Running Tests

To validate the functionality of the `DutchHouseNumber` module, you can run the provided test script.

### Command:
```bash
cd js
node test.js
```

The script will output the test results, showing whether the expected output matches the actual output for various test cases.
