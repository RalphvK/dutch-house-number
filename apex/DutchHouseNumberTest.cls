@isTest
public class DutchHouseNumberTest {
    
    @isTest
    static void testSplitNumberString_SimpleNumber() {
        // Test simple number
        Map<String, String> result = DutchHouseNumber.splitNumberString('123');
        
        System.assertEquals('123', result.get('number'));
        System.assertEquals(null, result.get('addition'));
        System.assertEquals(null, result.get('letter'));
    }
    
    @isTest
    static void testSplitNumberString_NumberWithLetter() {
        // Test number with letter
        Map<String, String> result = DutchHouseNumber.splitNumberString('123a');
        
        System.assertEquals('123', result.get('number'));
        System.assertEquals(null, result.get('addition'));
        System.assertEquals('A', result.get('letter'));
    }
    
    @isTest
    static void testSplitNumberString_NumberWithAddition() {
        // Test number with addition
        Map<String, String> result = DutchHouseNumber.splitNumberString('123-45');
        
        System.assertEquals('123', result.get('number'));
        System.assertEquals('45', result.get('addition'));
        System.assertEquals(null, result.get('letter'));
    }
    
    @isTest
    static void testSplitNumberString_NumberWithLetterAndAddition() {
        // Test number with letter and addition
        Map<String, String> result = DutchHouseNumber.splitNumberString('123a-45');
        
        System.assertEquals('123', result.get('number'));
        System.assertEquals('45', result.get('addition'));
        System.assertEquals('A', result.get('letter'));
    }
    
    @isTest
    static void testSplitNumberString_ComplexFormats() {
        // Test various complex formats
        Map<String, String> result1 = DutchHouseNumber.splitNumberString('123 bis');
        System.assertEquals('123', result1.get('number'));
        System.assertEquals('BIS', result1.get('addition'));
        System.assertEquals(null, result1.get('letter'));
        
        Map<String, String> result2 = DutchHouseNumber.splitNumberString('123/45');
        System.assertEquals('123', result2.get('number'));
        System.assertEquals('45', result2.get('addition'));
        System.assertEquals(null, result2.get('letter'));
        
        Map<String, String> result3 = DutchHouseNumber.splitNumberString('123b bis');
        System.assertEquals('123', result3.get('number'));
        System.assertEquals('BIS', result3.get('addition'));
        System.assertEquals('B', result3.get('letter'));
    }
    
    @isTest
    static void testSplitNumberString_EdgeCases() {
        // Test null and empty string
        Map<String, String> result1 = DutchHouseNumber.splitNumberString(null);
        System.assertEquals('', result1.get('number'));
        System.assertEquals('', result1.get('addition'));
        System.assertEquals('', result1.get('letter'));
        
        Map<String, String> result2 = DutchHouseNumber.splitNumberString('');
        System.assertEquals('', result2.get('number'));
        System.assertEquals('', result2.get('addition'));
        System.assertEquals('', result2.get('letter'));
        
        // Test whitespace
        Map<String, String> result3 = DutchHouseNumber.splitNumberString('   ');
        System.assertEquals('', result3.get('number'));
        System.assertEquals('', result3.get('addition'));
        System.assertEquals('', result3.get('letter'));
    }
    
    @isTest
    static void testExplodeNumber_BasicSplitting() {
        // Test basic splitting functionality
        List<String> result1 = DutchHouseNumber.explodeNumber('123a');
        System.assertEquals(2, result1.size());
        System.assertEquals('123', result1[0]);
        System.assertEquals('A', result1[1]);
        
        List<String> result2 = DutchHouseNumber.explodeNumber('123-45');
        System.assertEquals(2, result2.size());
        System.assertEquals('123', result2[0]);
        System.assertEquals('45', result2[1]);
        
        List<String> result3 = DutchHouseNumber.explodeNumber('123 bis');
        System.assertEquals(2, result3.size());
        System.assertEquals('123', result3[0]);
        System.assertEquals('BIS', result3[1]);
    }
    
    @isTest
    static void testExplodeNumber_ComplexSplitting() {
        // Test complex splitting with multiple delimiters
        List<String> result1 = DutchHouseNumber.explodeNumber('123/45a');
        System.assertEquals(3, result1.size());
        System.assertEquals('123', result1[0]);
        System.assertEquals('45', result1[1]);
        System.assertEquals('A', result1[2]);
        
        List<String> result2 = DutchHouseNumber.explodeNumber('123-a45');
        System.assertEquals(3, result2.size());
        System.assertEquals('123', result2[0]);
        System.assertEquals('A', result2[1]);
        System.assertEquals('45', result2[2]);
    }
    
    @isTest
    static void testExplodeNumber_EdgeCases() {
        // Test null and empty
        List<String> result1 = DutchHouseNumber.explodeNumber(null);
        System.assertEquals(0, result1.size());
        
        List<String> result2 = DutchHouseNumber.explodeNumber('');
        System.assertEquals(0, result2.size());
        
        // Test with leading/trailing delimiters
        List<String> result3 = DutchHouseNumber.explodeNumber('-123-');
        System.assertEquals(1, result3.size());
        System.assertEquals('123', result3[0]);
        
        List<String> result4 = DutchHouseNumber.explodeNumber('/123/');
        System.assertEquals(1, result4.size());
        System.assertEquals('123', result4[0]);
    }
    
    @isTest
    static void testToNormalisedString_WithStringInput() {
        // Test with string input
        String result1 = DutchHouseNumber.toNormalisedString('123');
        System.assertEquals('123', result1);
        
        String result2 = DutchHouseNumber.toNormalisedString('123a');
        System.assertEquals('123A', result2);
        
        String result3 = DutchHouseNumber.toNormalisedString('123-45');
        System.assertEquals('123-45', result3);
        
        String result4 = DutchHouseNumber.toNormalisedString('123a-45');
        System.assertEquals('123A-45', result4);
    }
    
    @isTest
    static void testToNormalisedString_WithObjectInput() {
        // Test with Map<String, String> input
        Map<String, String> fields1 = new Map<String, String>{'number' => '123'};
        String result1 = DutchHouseNumber.toNormalisedString(fields1);
        System.assertEquals('123', result1);
        
        Map<String, String> fields2 = new Map<String, String>{'number' => '123', 'letter' => 'A'};
        String result2 = DutchHouseNumber.toNormalisedString(fields2);
        System.assertEquals('123A', result2);
        
        Map<String, String> fields3 = new Map<String, String>{'number' => '123', 'addition' => '45'};
        String result3 = DutchHouseNumber.toNormalisedString(fields3);
        System.assertEquals('123-45', result3);
        
        Map<String, String> fields4 = new Map<String, String>{'number' => '123', 'letter' => 'A', 'addition' => '45'};
        String result4 = DutchHouseNumber.toNormalisedString(fields4);
        System.assertEquals('123A-45', result4);
    }
    
    @isTest
    static void testToNormalisedString_InvalidInput() {
        // Test with invalid input types
        String result1 = DutchHouseNumber.toNormalisedString(123);
        System.assertEquals(null, result1);
        
        String result2 = DutchHouseNumber.toNormalisedString(null);
        System.assertEquals(null, result2);
        
        // Test with map without number
        Map<String, String> fields = new Map<String, String>{'letter' => 'A'};
        String result3 = DutchHouseNumber.toNormalisedString(fields);
        System.assertEquals(null, result3);
    }
    
    @isTest
    static void testRealWorldExamples() {
        // Test real-world Dutch house number examples
        List<String> testCases = new List<String>{
            '123',
            '123a',
            '123A',
            '123-1',
            '123a-1',
            '123 bis',
            '123/1',
            '123-45bis',
            '123a45',
            '12 rood'
        };
        
        List<String> expectedResults = new List<String>{
            '123',
            '123A',
            '123A', 
            '123-1',
            '123A-1',
            '123-BIS',
            '123-1',
            '123-45BIS',
            '123A-45',
            '12-ROOD'
        };
        
        for (Integer i = 0; i < testCases.size(); i++) {
            String result = DutchHouseNumber.toNormalisedString(testCases[i]);
            System.assertEquals(expectedResults[i], result, 'Failed for input: ' + testCases[i]);
        }
    }
    
    @isTest
    static void testStreetNumberFields_Constructor() {
        // Test Map<String, String> creation
        Map<String, String> fields = new Map<String, String>{'number' => '', 'addition' => '', 'letter' => ''};
        
        System.assertEquals('', fields.get('number'));
        System.assertEquals('', fields.get('addition'));
        System.assertEquals('', fields.get('letter'));
    }
}
