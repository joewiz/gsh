xquery version "3.0";

import module namespace xmldb="http://exist-db.org/xquery/xmldb";
import module namespace file="http://exist-db.org/xquery/file";

(: The following external variables are set by the repo:deploy function :)

(: file path pointing to the exist installation directory :)
declare variable $home external;
(: path to the directory containing the unpacked .xar package :)
declare variable $dir external;
(: the target collection into which the app is deployed :)
declare variable $target external;

declare function local:mkcol-recursive($collection, $components) {
    if (exists($components)) then
        let $newColl := concat($collection, "/", $components[1])
        return (
            xmldb:create-collection($collection, $components[1]),
            local:mkcol-recursive($newColl, subsequence($components, 2))
        )
    else
        ()
};

(: Helper function to recursively create a collection hierarchy. :)
declare function local:mkcol($collection, $path) {
    local:mkcol-recursive($collection, tokenize($path, "/"))
};


local:mkcol("/db/system/config", $target),

(: store the replication configuration :)
xmldb:store-files-from-pattern("/db/system/config" || $target,  $dir, "replication.xconf"),

(: store the collection configuration :)
let $dir := concat($dir, "/data")
for $xconf in file:directory-list($dir, "*.xconf")/file:file/@name
let $data-dir := concat("data/", substring-before($xconf, ".xconf"))
return (
    local:mkcol-recursive(concat("/db/system/config/", $target), $data-dir),
    xmldb:store-files-from-pattern(
      concat("/db/system/config", $target, "/", $data-dir),
      $dir,
      $xconf
      )
)
