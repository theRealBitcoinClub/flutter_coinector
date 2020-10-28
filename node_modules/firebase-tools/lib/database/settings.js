"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const defaultWriteSizeLimit = {
    path: "defaultWriteSizeLimit",
    description: `
      Set a limit for the size of each write request: small, medium, large or unlimited.
      If you choose 'unlimited', any and all write requests will be allowed, potentially
      blocking subsequent write requests while the database processes any large write
      requests. For example, deleting data at the database's root
      can't be reverted and the database will be unavailable until the delete is finished.
      To avoid blocking large write requests without running the risk of hanging your
      database, you can set this limit to small (target=10s), medium (target=30s), large (target=60s).
      Realtime Database estimates the size of each write request and aborts
      requests that will take longer than the target time.
  `,
    parseInput: (input) => {
        switch (input) {
            case "small":
            case "medium":
            case "large":
            case "unlimited":
                return input;
            default:
                return undefined;
        }
    },
    parseInputErrorMessge: "defaultWriteSizeLimit must be either small, medium, large or unlimited. (tiny is not allowed)",
};
exports.DATABASE_SETTINGS = new Map();
exports.DATABASE_SETTINGS.set(defaultWriteSizeLimit.path, defaultWriteSizeLimit);
exports.HELP_TEXT = "\nAvailable Settings:\n" +
    Array.from(exports.DATABASE_SETTINGS.values())
        .map((setting) => `  ${setting.path}:${setting.description}`)
        .join("");
exports.INVALID_PATH_ERROR = `Path must be one of ${Array.from(exports.DATABASE_SETTINGS.keys()).join(", ")}.`;
//# sourceMappingURL=settings.js.map