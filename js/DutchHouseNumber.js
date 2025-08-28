export function splitNumberString(streetNumberString = null) {
  const fields = {
    number: '',
    addition: '',
    letter: '',
  };

  if (!streetNumberString || streetNumberString === '') {
    return fields;
  }

  // Explode number
  const exploded = explodeNumber(streetNumberString);

  // If just one number, it is the number
  if (exploded.length === 1) {
    fields.number = exploded[0];
    fields.addition = null;
    fields.letter = null;
    return fields;
  }

  // ELSE if more than one part, the first part is the number
  fields.number = exploded[0];

  // Iterate through other parts
  for (let i = 1; i < exploded.length; i++) {
    const part = exploded[i];

    // If part is a single letter, it is the house letter
    if (part.length === 1 && /^[a-zA-Z]$/.test(part)) {
      fields.letter = part.trim();
      continue;
    }

    // If part is numeric chars only, it is the addition
    if (/^\d+$/.test(part)) {
      fields.addition += part.trim();
      continue;
    }

    // If it is multiple non-numeric chars, it is the addition
    if (/^[a-zA-Z]+$/.test(part)) {
      fields.addition += part.trim();
      continue;
    }
  }

  // if fields is '', set to null
  // check if empty
  if (fields.addition === '') {
    fields.addition = null;
  }
  if (fields.letter === '') {
    fields.letter = null;
  }
  if (fields.number === '') {
    fields.number = null;
  }

  return fields;
}

export function explodeNumber(string = null) {
  string = (string || '').toUpperCase().trim();
  string = string.replace(/^[-\/]+|[-\/]+$/g, ''); // Trim - and / from start and end

  const additionLetterArray = [];
  for (const part of string.split(/[ -\/]/)) {
    additionLetterArray.push(
      ...part.split(/(?<=[a-zA-Z])(?=\d)|(?<=\d)(?=[a-zA-Z])/)
    );
  }

  return additionLetterArray;
}

/**
 * toNormalisedString
 * @param {string, object} streetNumber - can be both the output object from splitNumberString or any string, which will first be run through splitNumberString
 * @returns {string} - the normalised string
 */
export function toNormalisedString(streetNumber = null)
{
  // if string, split it into parts
  if (typeof streetNumber === 'string') {
    streetNumber = splitNumberString(streetNumber);
  // else assert it is an Object
  } else if (typeof streetNumber !== 'object' || !streetNumber.number) {
    console.error('Incorrect type given in toNormalisedString. Must be string or object. The object must have at least a number property.');
    return null;
  }

  // generate normalised string
  let normalised = streetNumber.number;
  if (streetNumber.letter) {
    normalised += `${streetNumber.letter}`;
  }
  if (streetNumber.addition) {
    normalised += `-${streetNumber.addition}`;
  }

  return normalised;
}
