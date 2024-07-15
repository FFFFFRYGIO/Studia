MATCH (n) DETACH DELETE n;
CALL apoc.schema.assert({}, {});
