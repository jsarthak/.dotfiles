"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const child = require("child_process");
const BaseLinter_1 = require("./BaseLinter");
const Logger_1 = require("../Logger");
var isWindows = process.platform === "win32";
class VerilatorLinter extends BaseLinter_1.default {
    constructor(diagnostic_collection, logger) {
        super("verilator", diagnostic_collection, logger);
        vscode_1.workspace.onDidChangeConfiguration(() => {
            this.getConfig();
        });
        this.getConfig();
    }
    getConfig() {
        this.verilatorArgs = vscode_1.workspace.getConfiguration().get('verilog.linting.verilator.arguments', '');
        this.runAtFileLocation = vscode_1.workspace.getConfiguration().get('verilog.linting.verilator.runAtFileLocation');
        this.useWSL = vscode_1.workspace.getConfiguration().get('verilog.linting.verilator.useWSL');
    }
    splitTerms(line) {
        let terms = line.split(':');
        for (var i = 0; i < terms.length; i++) {
            if (terms[i] == ' ') {
                terms.splice(i, 1);
                i--;
            }
            else {
                terms[i] = terms[i].trim();
            }
        }
        return terms;
    }
    getSeverity(severityString) {
        let result = vscode_1.DiagnosticSeverity.Information;
        if (severityString.startsWith('Error')) {
            result = vscode_1.DiagnosticSeverity.Error;
        }
        else if (severityString.startsWith('Warning')) {
            result = vscode_1.DiagnosticSeverity.Warning;
        }
        return result;
    }
    lint(doc) {
        this.logger.log('verilator lint requested');
        let docUri = doc.uri.fsPath; //path of current doc
        let lastIndex = (isWindows == true) ? docUri.lastIndexOf("\\") : docUri.lastIndexOf("/");
        let docFolder = docUri.substr(0, lastIndex); //folder of current doc
        let runLocation = (this.runAtFileLocation == true) ? docFolder : vscode_1.workspace.rootPath; //choose correct location to run
        let svArgs = (doc.languageId == "systemverilog") ? "-sv" : ""; //Systemverilog args
        let verilator = "verilator";
        if (isWindows) {
            if (this.useWSL == true) {
                verilator = `wsl ${verilator}`;
                let docUri_cmd = `wsl wslpath '${docUri}'`;
                docUri = child.execSync(docUri_cmd, {}).toString().replace(/\r?\n/g, "");
                this.logger.log(`Rewrote docUri to ${docUri} for WSL`, Logger_1.Log_Severity.Info);
                let docFolder_cmd = `wsl wslpath '${docFolder}'`;
                docFolder = child.execSync(docFolder_cmd, {}).toString().replace(/\r?\n/g, "");
                this.logger.log(`Rewrote docFolder to ${docFolder} for WSL`, Logger_1.Log_Severity.Info);
            }
            else {
                verilator = verilator + "_bin.exe";
                docUri = docUri.replace(/\\/g, "/");
                docFolder = docFolder.replace(/\\/g, "/");
            }
        }
        let command = verilator + ' ' + svArgs + ' --lint-only -I' + docFolder + ' ' + this.verilatorArgs + ' \"' + docUri + '\"'; //command to execute
        this.logger.log(command, Logger_1.Log_Severity.Command);
        var foo = child.exec(command, { cwd: runLocation }, (error, stdout, stderr) => {
            let diagnostics = [];
            let lines = stderr.split(/\r?\n/g);
            // Parse output lines
            lines.forEach((line, i) => {
                // Error for our file
                if (line.startsWith('%') && line.indexOf(docUri) > 0) {
                    let rex = line.match(/%(\w+)(-[A-Z0-9_]+)?:\s*(\w+:)?(?:[^:]+):\s*(\d+):(?:\s*(\d+):)?\s*(\s*.+)/);
                    if (rex && rex[0].length > 0) {
                        let severity = this.getSeverity(rex[1]);
                        let lineNum = Number(rex[4]) - 1;
                        let colNum = Number(rex[5]) - 1;
                        let message = rex[6];
                        // Type of warning is in rex[2]
                        colNum = isNaN(colNum) ? 0 : colNum; // for older Verilator versions (< 4.030 ~ish)
                        if (!isNaN(lineNum)) {
                            console.log(severity + ': [' + lineNum + '] ' + message);
                            diagnostics.push({
                                severity: severity,
                                range: new vscode_1.Range(lineNum, colNum, lineNum, Number.MAX_VALUE),
                                message: message,
                                code: 'verilator',
                                source: 'verilator'
                            });
                        }
                    }
                    else {
                        this.logger.log('failed to parse error: ' + line, Logger_1.Log_Severity.Warn);
                    }
                }
            });
            this.logger.log(diagnostics.length + ' errors/warnings returned');
            this.diagnostic_collection.set(doc.uri, diagnostics);
        });
    }
}
exports.default = VerilatorLinter;
//# sourceMappingURL=VerilatorLinter.js.map