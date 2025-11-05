public class DutchHouseNumber {
    
    /**
     * Splits a street number string into its components (number, addition, letter)
     * @param streetNumberString The street number string to split
     * @return Map<String, String> Map containing 'number', 'addition', and 'letter' keys
     */
    public static Map<String, String> splitNumberString(String streetNumberString) {
        Map<String, String> fields = new Map<String, String>{
            'number' => '',
            'addition' => '',
            'letter' => ''
        };
        
        if (String.isBlank(streetNumberString)) {
            return fields;
        }
        
        // Explode number
        List<String> exploded = explodeNumber(streetNumberString);
        
        // If just one number, it is the number
        if (exploded.size() == 1) {
            fields.put('number', exploded[0]);
            fields.put('addition', null);
            fields.put('letter', null);
            return fields;
        }
        
        // ELSE if more than one part, the first part is the number
        fields.put('number', exploded[0]);
        
        // Iterate through other parts
        for (Integer i = 1; i < exploded.size(); i++) {
            String part = exploded[i];
            
            // If part is a single letter, it is the house letter
            if (part.length() == 1 && Pattern.matches('[a-zA-Z]', part)) {
                fields.put('letter', part.trim());
                continue;
            }
            
            // If part is numeric chars only, it is the addition
            if (Pattern.matches('\\d+', part)) {
                String currentAddition = fields.get('addition') != null ? fields.get('addition') : '';
                fields.put('addition', currentAddition + part.trim());
                continue;
            }
            
            // If it is multiple non-numeric chars, it is the addition
            if (Pattern.matches('[a-zA-Z]+', part)) {
                String currentAddition = fields.get('addition') != null ? fields.get('addition') : '';
                fields.put('addition', currentAddition + part.trim());
                continue;
            }
        }
        
        // if fields is '', set to null
        if (String.isBlank(fields.get('addition'))) {
            fields.put('addition', null);
        }
        if (String.isBlank(fields.get('letter'))) {
            fields.put('letter', null);
        }
        if (String.isBlank(fields.get('number'))) {
            fields.put('number', null);
        }
        
        return fields;
    }
    
    /**
     * Explodes a number string into its constituent parts by splitting on various delimiters
     * @param inputString The string to explode into parts
     * @return List<String> List of string parts after splitting and processing
     */
    public static List<String> explodeNumber(String inputString) {
        if (String.isBlank(inputString)) {
            return new List<String>();
        }
        
        String processedString = inputString.toUpperCase().trim();
        // Trim - and / from start and end
        processedString = processedString.replaceAll('^[-/]+|[-/]+$', '');
        
        List<String> additionLetterArray = new List<String>();
        
        // Split on space, dash, or forward slash
        List<String> parts = processedString.split('[ \\-/]');
        
        for (String part : parts) {
            if (String.isNotBlank(part)) {
                // Split on transitions between letters and digits
                List<String> subParts = splitOnLetterDigitTransition(part);
                additionLetterArray.addAll(subParts);
            }
        }
        
        return additionLetterArray;
    }
    
    /**
     * Helper method to split a string on transitions between letters and digits
     * @param input The string to split
     * @return List<String> List of parts split on letter-digit transitions
     */
    private static List<String> splitOnLetterDigitTransition(String input) {
        List<String> result = new List<String>();
        if (String.isBlank(input)) {
            return result;
        }
        
        String currentPart = '';
        Boolean wasDigit = null;
        
        for (Integer i = 0; i < input.length(); i++) {
            String currentChar = input.substring(i, i + 1);
            Boolean isDigit = Pattern.matches('\\d', currentChar);
            
            if (wasDigit != null && wasDigit != isDigit) {
                // Transition detected, save current part and start new one
                if (String.isNotBlank(currentPart)) {
                    result.add(currentPart);
                }
                currentPart = currentChar;
            } else {
                currentPart += currentChar;
            }
            
            wasDigit = isDigit;
        }
        
        if (String.isNotBlank(currentPart)) {
            result.add(currentPart);
        }
        
        return result;
    }
    
    /**
     * Converts street number to normalised string format
     * @param streetNumber Can be either a Map<String, String> or a string to be parsed
     * @return String The normalised string representation
     */
    public static String toNormalisedString(Object streetNumber) {
        Map<String, String> fields;
        
        // If string, split it into parts
        if (streetNumber instanceof String) {
            fields = splitNumberString((String) streetNumber);
        } else if (streetNumber instanceof Map<String, String>) {
            fields = (Map<String, String>) streetNumber;
        } else {
            System.debug('Incorrect type given in toNormalisedString. Must be string or Map<String, String>.');
            return null;
        }
        
        // Validate that we have at least a number
        if (String.isBlank(fields.get('number'))) {
            System.debug('Map must have at least a number property.');
            return null;
        }
        
        // Generate normalised string
        String normalised = fields.get('number');
        if (String.isNotBlank(fields.get('letter'))) {
            normalised += fields.get('letter');
        }
        if (String.isNotBlank(fields.get('addition'))) {
            normalised += '-' + fields.get('addition');
        }
        
        return normalised;
    }
}
