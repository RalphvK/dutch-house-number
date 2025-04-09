export function splitNumberString(streetNumberString = null, returnType = 'array') {
  const fields = {
    number: null,
    addition: null,
    letter: null,
  };

  if (!streetNumberString || streetNumberString === '') {
    return returnTypeHandler(returnType, fields);
  }

  // Explode number
  const exploded = explodeNumber(streetNumberString);

  // If just one number, it is the number
  if (exploded.length === 1) {
    fields.number = exploded[0];
    return returnTypeHandler(returnType, fields);
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
      fields.addition = part;
      continue;
    }

    // If it is multiple non-numeric chars, it is the addition
    if (/^[a-zA-Z]+$/.test(part)) {
      fields.addition = part;
      continue;
    }
  }

  return returnTypeHandler(returnType, fields);
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

export function returnTypeHandler(typeString = 'array', fieldsObject = {}) {
  switch (typeString) {
    case 'array':
      return fieldsObject;
    case 'stdObject':
      return { ...fieldsObject };
    case 'json':
      return JSON.stringify(fieldsObject);
    case 'string':
      return Object.values(fieldsObject).join(';');
    default:
      return fieldsObject;
  }
}
