# Dutch house number parser

## About Dutch house numbers

Dutch house numbers are not just simple numbers. All house numbers start with a number, but letters and suffixes (numberical and alphabetical) may be appended. A Dutch house number can therefore consist of three individual parts:

| Part | Dutch term | Example | Description |
|------|---------|---------|---------|
| House Number | Huisnummer | 42 | The main number of the house. Always required |
| House Letter | Huisletter | A | An optional letter that may be appended to the house number. It is part of the "top-level" house number toghether with the number. Often used for houses built between two existing buildings with contiguous (even or odd) numbers. |
| Suffix  | Huisnummertoevoeging | 1 | An optional appendix, most commenly used not for entire buildings but subdivisions such as apartments. |
| | | Bis, BX08 | It can have rather fancy values. |

## The formatting problem

One of the issues faced in developing applications that deal with Dutch addresses is inconsistent formatting of house numbers. For example, a house number may be represented as "123A4", "123 A 4", "123-A-4", or "123A-4". Even in data from municipalities I have encountered such inconsistencies. This inconsistency makes it difficult to simply split the string into its components.

## What this code does

This code takes any of the arbitrary formats of a Dutch house number and splits it into its components and returns an object (or associative array) with the following keys:
- `number`: The main house number.
- `letter`: A single letter associated with the house number.
- `addition`: Any additional numeric or alphabetic part.

## Usage

For specific usage instructions, please refer to the documentation in the respective language folders (e.g., `js`, `php`, etc.):

- **JavaScript**: [JavaScript readme](js/readme.md)
- **PHP**: [PHP readme](php/readme.md)

## Preferred output format

In general, I believe the correct formatting for a Dutch house number string to be: `number` `letter` `-` `addition`.

Examples:

`42` = `{number: 42}`

`42A` = `{number: 42, letter: A}`

`42A-4` = `{number: 42, letter: A, addition: 4}`

`2-2` = `{number: 2, addition: 2}`

`2-2A` = `{number: 2, letter: A, addition: 2}`

`2A-B4` = `{number: 2, letter: A, addition: B4}`