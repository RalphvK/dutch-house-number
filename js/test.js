import { splitNumberString } from './DutchHouseNumber.js';

const testStrings = {
  '2': { number: '2', addition: null, letter: null },
  '2a': { number: '2', addition: null, letter: 'A' },
  '2-2': { number: '2', addition: '2', letter: null },
  '2-2a': { number: '2', addition: '2', letter: 'A' },
  '2-Bis A': { number: '2', addition: 'BIS', letter: 'A' },
  '32-a-bis': { number: '32', addition: 'BIS', letter: 'A' },
  '9-BX04': { number: '9', addition: 'BX04', letter: null },
  '9B-BX04': { number: '9', addition: 'BX04', letter: 'B' }
};

for (const [string, expected] of Object.entries(testStrings)) {
  const result = splitNumberString(string);
  if (JSON.stringify(result) === JSON.stringify(expected)) {
    console.log(`%c${string}: PASS`, 'color: green', `Expected = ${JSON.stringify(expected)} | Result = ${JSON.stringify(result)}`);
  } else {
    console.log(`%c${string}: FAIL`, 'color: red', `Expected = ${JSON.stringify(expected)} | Result = ${JSON.stringify(result)}`);
  }
}
