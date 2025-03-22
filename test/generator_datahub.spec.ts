/**
 * Created by eddy spreeuwers on 14-02-18.
 */
import * as fs from "fs";
import * as ts from "typescript";
import {useNormalLogModus, useVerboseLogModus} from "../src/xml-utils";

import {generateTemplateClassesFromXSD} from "../src/index";

function xsdPath(name: string){
  return   `./test/xsd/${name}.xsd`;
}

useVerboseLogModus();

describe("generator", () => {

        // it("creates a schema with F17_PartyInfoRequest.ts", () => {
        // //    expect(generateTemplateClassesFromXSD("./test/xsd/query/F17_PartyInfoRequest.xsd"));
        // //    printFile("./src/generated/F17_PartyInfoRequest.ts");
        //    compile("./src/generated/F17_PartyInfoRequest.ts");
        // });

        // it("creates a schema with F17_PartyInfoRequest_ElementTypes.ts", () => {
        //     //    expect(generateTemplateClassesFromXSD("./test/xsd/query/elements/F17_PartyInfoRequest_ElementTypes.xsd"));
        //     //    printFile("./src/generated/F17_PartyInfoRequest_ElementTypes.ts");
        //        compile("./src/generated/F17_PartyInfoRequest.ts");
        // });

        // it("creates a schema with PEC_ProcessEnergyContext_ElementTypes.ts", () => {
        //     // expect(generateTemplateClassesFromXSD("./test/xsd/common/elements/PEC_ProcessEnergyContext_ElementTypes.xsd"));
        //     // printFile("./src/generated/HDR_Header_ElementTypes.ts");
        //     compile("./src/generated/PEC_ProcessEnergyContext_ElementTypes.ts");
        // });

        // it("creates a schema with HDR_Header_ElementTypes.ts", () => {
        //     // expect(generateTemplateClassesFromXSD("./test/xsd/common/elements/HDR_Header_ElementTypes.xsd"));
        //     // printFile("./src/generated/HDR_Header_ElementTypes.ts");
        //     compile("./src/generated/HDR_Header_ElementTypes.ts");
        //  });

        // it("creates a schema with DataTypes.ts", () => {
        //     expect(generateTemplateClassesFromXSD("./test/xsd/common/DataTypes.xsd"));
        //     printFile("./src/generated/DataTypes.ts");
        //     compile("./src/generated/DataTypes.ts");
        //  });
});

function printFile(fname:string) {
    const s = fs.readFileSync(fname).toString();
    console.log(s);
}



function compile(tsFile: string): void {
    expect( compileAll([tsFile]) ).toBe(true);
}

function compileAll(tsFiles: string[]): boolean {

    return _compile(tsFiles, {
        module: ts.ModuleKind.CommonJS,
        noEmitOnError: true,
        noImplicitAny: false,
        target: ts.ScriptTarget.ES5,
    });
}



function _compile(fileNames: string[], options: ts.CompilerOptions): boolean {


    let program = ts.createProgram(fileNames, options);
    let emitResult = program.emit();

    let allDiagnostics = ts
        .getPreEmitDiagnostics(program)
        .concat(emitResult.diagnostics);

    allDiagnostics.forEach( (diagnostic) => {
        if (diagnostic.file) {
            let { line, character } = diagnostic.file.getLineAndCharacterOfPosition(diagnostic.start!);
            let message = ts.flattenDiagnosticMessageText(diagnostic.messageText, "\n");
            console.log(`${diagnostic.file.fileName} (${line + 1},${character + 1}): ${message}`);
        } else {
            console.log(ts.flattenDiagnosticMessageText(diagnostic.messageText, "\n"));
        }
    });

    let exitCode = emitResult.emitSkipped ? 1 : 0;
    console.log(`Compiling process exiting with code '${exitCode}'.`);
    return !emitResult.emitSkipped;
}


