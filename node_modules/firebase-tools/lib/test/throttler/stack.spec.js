"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const stack_1 = require("../../throttler/stack");
const throttler_spec_1 = require("./throttler.spec");
describe("Stack", () => {
    it("should have default name of stack", () => {
        const stack = new stack_1.default({});
        chai_1.expect(stack.name).to.equal("stack");
    });
    it("should be first-in-last-out", () => __awaiter(this, void 0, void 0, function* () {
        const order = [];
        const queue = new stack_1.default({
            handler: throttler_spec_1.createHandler(order),
            concurrency: 1,
        });
        const blocker = yield throttler_spec_1.createTask("blocker", false);
        queue.add(blocker);
        queue.add(yield throttler_spec_1.createTask("1", true));
        queue.add(yield throttler_spec_1.createTask("2", true));
        blocker.resolve();
        queue.close();
        yield queue.wait();
        chai_1.expect(order).to.deep.equal(["blocker", "2", "1"]);
    }));
    it("should not repeat completed tasks", () => __awaiter(this, void 0, void 0, function* () {
        const order = [];
        const queue = new stack_1.default({
            handler: throttler_spec_1.createHandler(order),
            concurrency: 1,
        });
        const t1 = yield throttler_spec_1.createTask("t1", false);
        queue.add(t1);
        const t2 = yield throttler_spec_1.createTask("t2", false);
        queue.add(t2);
        queue.add(yield throttler_spec_1.createTask("added before t1 finished a", true));
        queue.add(yield throttler_spec_1.createTask("added before t1 finished b", true));
        t1.resolve();
        yield t2.startExecutePromise;
        queue.add(yield throttler_spec_1.createTask("added before t2 finished a", true));
        queue.add(yield throttler_spec_1.createTask("added before t2 finished b", true));
        t2.resolve();
        queue.close();
        yield queue.wait();
        chai_1.expect(order).to.deep.equal([
            "t1",
            "added before t1 finished b",
            "added before t1 finished a",
            "t2",
            "added before t2 finished b",
            "added before t2 finished a",
        ]);
    }));
});
//# sourceMappingURL=stack.spec.js.map