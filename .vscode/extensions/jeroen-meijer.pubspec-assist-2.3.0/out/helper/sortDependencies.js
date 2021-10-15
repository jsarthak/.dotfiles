"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sortDependencies = void 0;
const YAML = require("yaml");
const types_1 = require("yaml/types");
const dependencyType_1 = require("../model/dependencyType");
function sortDependencies({ pubspecString, useLegacySorting, }) {
    const options = {
        schema: "core",
    };
    const pubspecDoc = YAML.parseDocument(pubspecString, options);
    for (const dependencyType of dependencyType_1.dependencyTypes) {
        const dependencyPath = pubspecDoc.get(dependencyType);
        const dependencyPathIsMap = dependencyPath instanceof types_1.YAMLMap;
        if (dependencyPath === null ||
            dependencyPath === undefined ||
            !dependencyPathIsMap) {
            continue;
        }
        const sortByKey = (a, b) => a.key.value < b.key.value ? -1 : 1;
        const containsKey = (key) => (item) => item.value.type === "MAP" &&
            item.value.items.some((item) => item.key.value === key);
        const baseSortedItems = dependencyPath.items.sort(sortByKey);
        let sortedDependencies = baseSortedItems;
        if (useLegacySorting) {
            const sortedItemsByImportType = {
                sdk: baseSortedItems.filter(containsKey("sdk")),
                path: baseSortedItems.filter(containsKey("path")),
                git: baseSortedItems.filter(containsKey("git")),
                hosted: baseSortedItems.filter(containsKey("hosted")),
            };
            sortedDependencies = [
                ...sortedItemsByImportType.sdk,
                ...sortedItemsByImportType.path,
                ...sortedItemsByImportType.git,
                ...sortedItemsByImportType.hosted,
                ...baseSortedItems,
            ];
        }
        const newDependencyMap = new types_1.YAMLMap();
        for (const item of sortedDependencies) {
            if (!newDependencyMap.has(item.key)) {
                newDependencyMap.add(item);
            }
        }
        pubspecDoc.set(dependencyType, newDependencyMap);
    }
    return pubspecDoc.toString();
}
exports.sortDependencies = sortDependencies;
exports.default = sortDependencies;
//# sourceMappingURL=sortDependencies.js.map