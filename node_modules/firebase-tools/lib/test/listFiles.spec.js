"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const path_1 = require("path");
const listFiles_1 = require("../listFiles");
describe("listFiles", () => {
    it("should ignore firebase-debug.log, specified ignores, and nothing else", () => {
        const fileNames = listFiles_1.listFiles(path_1.resolve(__dirname, "./fixtures/ignores"), [
            "**/.*",
            "firebase.json",
            "ignored.txt",
            "ignored/**/*.txt",
        ]);
        chai_1.expect(fileNames).to.deep.equal(["index.html", "ignored/index.html", "present/index.html"]);
    });
    it("should allow us to not specify additional ignores", () => {
        const fileNames = listFiles_1.listFiles(path_1.resolve(__dirname, "./fixtures/ignores"));
        chai_1.expect(fileNames.sort()).to.have.members([
            ".hiddenfile",
            "firebase.json",
            "ignored.txt",
            "ignored/deeper/index.txt",
            "ignored/ignore.txt",
            "ignored/index.html",
            "index.html",
            "present/index.html",
        ]);
    });
});
//# sourceMappingURL=listFiles.spec.js.map