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
const queue_1 = require("../../throttler/queue");
const throttler_spec_1 = require("./throttler.spec");
describe("Queue", () => {
    it("should have default name of queue", () => {
        const queue = new queue_1.default({});
        chai_1.expect(queue.name).to.equal("queue");
    });
    it("should be first-in-first-out", () => __awaiter(this, void 0, void 0, function* () {
        const order = [];
        const queue = new queue_1.default({
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
        chai_1.expect(order).to.deep.equal(["blocker", "1", "2"]);
    }));
});
//# sourceMappingURL=queue.spec.js.map