import { splitNumberString, toNormalisedString } from './DutchHouseNumber.js';

const testStrings = {
  '2': { number: '2', addition: null, letter: null, normalisedString: '2' },
  '2a': { number: '2', addition: null, letter: 'A', normalisedString: '2A' },
  '2-2': { number: '2', addition: '2', letter: null, normalisedString: '2-2' },
  '2-2a': { number: '2', addition: '2', letter: 'A', normalisedString: '2A-2' },
  '2-Bis A': { number: '2', addition: 'BIS', letter: 'A', normalisedString: '2A-BIS' },
  '32-a-bis': { number: '32', addition: 'BIS', letter: 'A', normalisedString: '32A-BIS' },
  '9-BX04': { number: '9', addition: 'BX04', letter: null, normalisedString: '9-BX04' },
  '9B-BX04': { number: '9', addition: 'BX04', letter: 'B', normalisedString: '9B-BX04' },
  '2-A-23': { number: '2', addition: '23', letter: 'A', normalisedString: '2A-23' },
};

for (const [string, expected] of Object.entries(testStrings)) {
  const result = splitNumberString(string);
  const normalised = toNormalisedString(result);
  
  let passed = true;
  let failedFields = [];
  
  // Check each field individually
  if (result.number !== expected.number) {
    passed = false;
    failedFields.push(`number: expected "${expected.number}" (${typeof expected.number}), got "${result.number}" (${typeof result.number})`);
  }
  
  if (result.addition !== expected.addition) {
    passed = false;
    failedFields.push(`addition: expected "${expected.addition}" (${typeof expected.addition}), got "${result.addition}" (${typeof result.addition})`);
  }
  
  if (result.letter !== expected.letter) {
    passed = false;
    failedFields.push(`letter: expected "${expected.letter}" (${typeof expected.letter}), got "${result.letter}" (${typeof result.letter})`);
  }
  
  // Check normalised string
  if (normalised !== expected.normalisedString) {
    passed = false;
    failedFields.push(`normalisedString: expected "${expected.normalisedString}" (${typeof expected.normalisedString}), got "${normalised}" (${typeof normalised})`);
  }
  
  if (passed) {
    console.log(`%c${string}: PASS`, 'color: green');
  } else {
    console.log(`%c${string}: FAIL`, 'color: red', failedFields.join(', '));
  }
}
