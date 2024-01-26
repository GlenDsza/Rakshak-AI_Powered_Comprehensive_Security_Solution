export const countLabels = (labels: string[]): [string, number][] => {
  if (!labels) return [];
  return Array.from(
    labels.reduce((labelCountMap, name) => {
      const count = labelCountMap.get(name) || 0;
      labelCountMap.set(name, count + 1);
      return labelCountMap;
    }, new Map<string, number>())
  ).map(([label, count]) => [label, count]);
};
