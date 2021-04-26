/**
 * Created by eddy spreeuwers 14-02-18.
 */

import {
    char, expression, option, group, range, regexpPattern2typeAlias, series, specials, variants,
    buildVariants
} from "../src/regexp2aliasType";


const zero_99 = '0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99';


describe("regexpPattern2typeAlias", () => {
       fit ("returns as type alias for regexps" , () => {
            let alias = '';
            // alias = regexpPattern2typeAlias('', 'string');
            // expect(alias).toBe('string');
            // alias = regexpPattern2typeAlias('A', 'string');
            // expect(alias).toBe('"A"');
            // alias = regexpPattern2typeAlias('A|B|C', 'string');
            // expect(alias).toBe('"A"|"B"|"C"');
            // alias = regexpPattern2typeAlias('[ABC]', 'string');
            // expect(alias).toBe('"A"|"B"|"C"');
            // alias = regexpPattern2typeAlias('A[12]', 'string');
            // expect(alias).toBe('"A1"|"A2"');
            // alias = regexpPattern2typeAlias('A[12]|B|C[34]', 'string');
            // expect(alias).toBe('"A1"|"A2"|"B"|"C3"|"C4"');
            // alias = regexpPattern2typeAlias('A[\\d]|B', 'string');
            // expect(alias).toBe('"A0"|"A1"|"A2"|"A3"|"A4"|"A5"|"A6"|"A7"|"A8"|"A9"|"B"');
            // //
            alias = regexpPattern2typeAlias('pre|[b-dC-E4-7]|mid|[A]|post', 'string');
            expect(alias).toBe('"pre"|"4"|"5"|"6"|"7"|"C"|"D"|"E"|"b"|"c"|"d"|"mid"|"A"|"post"');
            alias = regexpPattern2typeAlias('a[b-c1-3]', 'string');
            expect(alias).toBe('"a1"|"a2"|"a3"|"ab"|"ac"');
            alias = regexpPattern2typeAlias("[P\\-][B\\-][A\\-]", 'string');
            expect(alias).toBe('"---"|"--A"|"-B-"|"-BA"|"P--"|"P-A"|"PB-"|"PBA"');
            alias = regexpPattern2typeAlias("[\\d]+", 'number', {maxLength: 1});
            expect(alias).toBe('0|1|2|3|4|5|6|7|8|9');
            alias = regexpPattern2typeAlias("\\d+", 'number', {maxLength: 2});
            expect(alias).toBe(zero_99);
            alias = regexpPattern2typeAlias("[\\d]+", 'number', {maxLength: 2});
            expect(alias).toEqual(zero_99);
            alias = regexpPattern2typeAlias("\\d*", 'number', {maxLength: 2});
            expect(alias).toEqual(zero_99);
            alias = regexpPattern2typeAlias("\\d+", 'number', {maxLength: 1});
            expect(alias).toBe('0|1|2|3|4|5|6|7|8|9');
            // let options = buildVariants(['A'], ['','B','BB', 'BBB'], 3);
            // console.log(options);
            // expect(options.join('|')).toEqual('A|AB|ABB');
            // alias = regexpPattern2typeAlias("AB*", 'string', {maxLength: 3});
            // expect(alias).toEqual('"A"|"AB"|"ABB"');
            // alias = regexpPattern2typeAlias("AB+", 'string', {maxLength: 5});
            // expect(alias).toEqual('"AB"|"ABB"|"ABBB"|"ABBBB"');

        });

    it ("returns a charset   for special chars" , () => {
        let v = null;
        let i = 0;
        //
        [v, i] = specials(0, '\\d');
        expect(v).toBe('0123456789');
        [v, i] = specials(0, 'a');
        expect(v).toBe('');

        [v, i] = specials(0, '\\\\');
        expect(v).toBe('\\\\');
    });

    it ("returns a charset for series" , () => {
        let v = null;
        let i = 0;
        [v, i] = char(0, 'a');
        expect(v).toBe('a');

        [v, i] = range(0, '[');
        expect(v).toBe('');

        [v, i] = range(0, 'a-z');
        expect(v).toBe('abcdefghijklmnopqrstuvwxyz');

        [v, i] = range(0, 'a');
        expect(v).toBe('');

        [v, i] = series(0, '[\\d]');
        expect(v).toBe('0123456789');
        expect(i).toBe(4);

        [v, i] = series(0, '[\\w]');
        expect(v).toBe('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');

        [v, i] = series(0, '[.]');
        expect(v).toBe('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~§±!@#$%^&*()-_=+[]{}|;:.,');
        //
        [v, i] = series(0, '[A\\d]');
        expect(v).toBe('A0123456789');

        [v, i] = series(0, '[A-Z]');
        expect(v).toBe('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
        [v, i] = series(0, '[a-Z]');
        expect(v).toBe('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
        [v, i] = series(0, '[5-g]');
        expect(v).toBe('56789abcdefg');
    });

   it("returns options for variants []", () => {
        let v = null;
        let i = 0;

        [v, i] = variants('5g');
        expect(v.join('|')).toBe('5g');

        [v, i] = variants('\\d');
        expect(v.join('|')).toBe('0|1|2|3|4|5|6|7|8|9');

        [v, i] = variants('A\\d');
        expect(v.join('|')).toBe('A0|A1|A2|A3|A4|A5|A6|A7|A8|A9');

        [v, i] = variants('A\\d+', 0, 2);
        expect(v.join('|')).toBe('A0|A1|A2|A3|A4|A5|A6|A7|A8|A9');

       [v, i] = variants('A\\d+', 0, 1);
       expect(v.join('|')).toBe('A');

        [v, i] = variants('AB+', 0, 2);
        expect(v.join('|')).toBe('AB');

       [v, i] = variants('\\d+', 0, 1);
       expect(v.join('|')).toBe( '0|1|2|3|4|5|6|7|8|9');

       // [v, i] = variants('AB*', 0, 2);
       // expect(v.join('|')).toBe('A|AB');
       //
       // [v, i] = variants('A\\d*', 0, 2);
       // expect(v.join('|')).toBe('A|A0|A1|A2|A3|A4|A5|A6|A7|A8|A9');
        //
        //
        //
        // [v, i] = variants('(A|B)C', 5, 2);
        // expect(v.join('|')).toBe('C');
        //
        // [v, i] = option('A|B', 0, 2);
        // expect(v).toEqual([ 'A', 'B' ]);
        //
        // [v, i] = group('(A|B)', 0, 2);
        // expect(v).toEqual([ 'A', 'B' ]);
        // //
        // [v, i] = expression('(A|B)C', 0, 2);
        // expect(v.join('|')).toBe('AC|BC');




    });


    it("returns options for option", () => {
        let v = null;
        let i = 0;

        [v, i] = option('A|B', 0, 2);
        expect(v).toEqual([ 'A', 'B' ]);
        [v, i] = option('A|\\d', 0, 2);
        expect(v.join('|')).toBe('A|0|1|2|3|4|5|6|7|8|9');
        [v, i] = option('A|\\d|B', 0, 2);
        expect(v.join('|')).toBe('A|0|1|2|3|4|5|6|7|8|9|B');
        [v, i] = option('A|123|B', 0, 2);
        expect(v.join('|')).toBe('A|123|B');

        [v, i] = option('(A|B)C', 5, 2);
        expect(v.join('|')).toBe('C');




    });

    it("returns options for group", () => {
        let v = null;
        let i = 0;


        [v, i] = group('(A|B)', 0, 2);
        expect(v.join('|')).toBe('A|B');

        [v, i] = group('(A|B|\\d)', 0, 2);
        expect(v.join('|')).toBe('A|B|0|1|2|3|4|5|6|7|8|9');

        [v, i] = group('(A|B)C', 5, 2);
        expect(v).toBe(null);

        [v, i] = group('(A|BC', 0, 2);
        expect(v).toBe(null);



    });

    it("returns options for expression", () => {
        let v = null;
        let i = 0;
        [v, i] = expression('A|B', 0, 2);
        expect(v.join('|')).toBe('A|B');

        [v, i] = expression('(A|B|\\d)', 0, 2);
        expect(v.join('|')).toBe('A|B|0|1|2|3|4|5|6|7|8|9');

        [v, i] = expression('(A|B)', 0, 2);
        expect(v.join('|')).toBe('A|B');

        [v, i] = expression('(A|B)C', 0, 2);
        expect(v.join('|')).toBe('AC|BC');
        //
        [v, i] = expression('A(B|C)D', 0);
        expect(v.join('|')).toBe('ABD|ACD');

        [v, i] = expression('A(B|C)|D|E', 0);
        expect(v.join('|')).toBe('AB|AC|D|E');

        [v, i] = expression('(A|B)(D|E)', 0);
        expect(v.join('|')).toBe('AD|AE|BD|BE');

        [v, i] = expression('(A|B)(D|E)(F|G)', 0);
        expect(v.join('|')).toBe('ADF|ADG|AEF|AEG|BDF|BDG|BEF|BEG');

        [v, i] = expression('(A|B)|(D|E)|(F|G)', 0);
        expect(v.join('|')).toBe('A|B|D|E|F|G');

        [v,i] = expression('A[12]|B|C[34]');
        expect(v.join('|')).toBe('A1|A2|B|C3|C4');
    });
});
