"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const fsutils = require("../fsutils");
describe("fsutils", () => {
    describe("fileExistsSync", () => {
        it("should return true if the file exists", () => {
            chai_1.expect(fsutils.fileExistsSync(__filename)).to.be.true;
        });
        it("should return false if the file does not exist", () => {
            chai_1.expect(fsutils.fileExistsSync(`${__filename}/nope.never`)).to.be.false;
        });
        it("should return false if the path is a directory", () => {
            chai_1.expect(fsutils.fileExistsSync(__dirname)).to.be.false;
        });
    });
    describe("dirExistsSync", () => {
        it("should return true if the directory exists", () => {
            chai_1.expect(fsutils.dirExistsSync(__dirname)).to.be.true;
        });
        it("should return false if the directory does not exist", () => {
            chai_1.expect(fsutils.dirExistsSync(`${__dirname}/nope/never`)).to.be.false;
        });
        it("should return false if the path is a file", () => {
            chai_1.expect(fsutils.dirExistsSync(__filename)).to.be.false;
        });
    });
});
//# sourceMappingURL=fsutils.spec.js.map