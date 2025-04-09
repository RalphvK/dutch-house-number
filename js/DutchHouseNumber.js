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
    return fields;
  }

  // ELSE if more than one part, the first part is the number
  fields.number = exploded[0];

  // Iterate through other parts
  for (let i = 1; i < exploded.length; i++) {
    const part = exploded[i];

    // If part is a single letter, it is the house letter
    if (part.length === 1 && /^[a-zA-Z]$/.test(part)) {
      fields.letter = part;
      continue;
    }

    // If part is numeric chars only, it is the addition
    if (/^\d+$/.test(part)) {
      fields.addition += part;
      continue;
    }

    // If it is multiple non-numeric chars, it is the addition
    if (/^[a-zA-Z]+$/.test(part)) {
      fields.addition += part;
      continue;
    }
  }

  // if fields is '', set to null
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
