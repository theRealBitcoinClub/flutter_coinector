"use strict";
const _ = require("lodash");
function _filterOnly(configs, onlyString) {
    if (!onlyString) {
        return configs;
    }
    var onlyTargets = onlyString.split(",");
    if (_.includes(onlyTargets, "hosting")) {
        return configs;
    }
    onlyTargets = onlyTargets
        .filter(function (anOnly) {
        return anOnly.indexOf("hosting:") === 0;
    })
        .map(function (anOnly) {
        return anOnly.replace("hosting:", "");
    });
    return configs.filter(function (config) {
        return _.includes(onlyTargets, config.target || config.site);
    });
}
module.exports = function (options) {
    let configs = options.config.get("hosting");
    if (!configs) {
        return [];
    }
    else if (!_.isArray(configs)) {
        if (!configs.target && !configs.site) {
            configs.site = options.instance;
        }
        configs = [configs];
    }
    return _filterOnly(configs, options.only);
};
//# sourceMappingURL=normalizedHostingConfigs.js.map