# gsh

[![exist-db CI](https://github.com/joewiz/gsh/actions/workflows/build.yml/badge.svg)](https://github.com/joewiz/gsh/actions/workflows/build.yml)

Draft work on historical country names database, aka, geospatial history (gsh) project.

## Scope

This effort aims to capture major changes in the names and statuses of countries during the span existence of the United States, that is, the period 1776-present. The purpose is to create a database that allows us to refer to countries past and present using historically accurate, temporally specific names. This database will unlock the ability to associate countries on today's map with earlier incarnations (e.g., Vietnam and Indochina) and track changes in names and sovereignty, among other kinds of changes.

Even though we call this database "historical country names," the database actually uses a somewhat broader term than countries to refer to its basic unit: "territories." This concept encompasses independent states, dependencies, and areas of special sovereignty. We borrow these distinctions from the Bureau of Intelligence and Research (INR), which publishes tables of "Independent States in the World" and "Dependencies and Areas of Special Sovereignty." (See these respective lists at http://www.state.gov/s/inr/rls/4250.htm and http://www.state.gov/s/inr/rls/10543.htm.) 

This database takes INR's lists, which capture today's map, and introduces a historical component: we track when each territory began and its immediate "predecessor," or previous incarnation. For each predecessor, we track its dates of validity, and its own immediate predecessors and successors. Thus, for each "territory" in this database, we track the following items:

1. Name: We borrow INR's distinction between a territory's "short-form name" and "long-form name." For example, in the case of Afghanistan, "Afghanistan" is the short-form name, and "Islamic Republic of Afghanistan" is the long-form name. For today's map, we follow INR. For historical entries, When either of a territory's names change, we create a new record to reflect the change. For example, when the Czech Republic officially declared Czechia to be its short-form name in 2016, we create a new territory entry, citing the earlier entry as Czechia's predecessor. Not all territories have long-form names different from the short-form name (e.g., Canada), which we indicate by supplying "-" for the long-form name.

2. Type of territory: We borrow INR's distinction between "independent states" and "dependencies and areas of special sovereignty." The distinction is rooted in the Westphalian model of state foundation. "Independent states" have an independent, sovereign government and a stable territory, well-defined borders, and population. "Dependencies" are colonies or territorial possessions of independent states. "Areas of special sovereignty" indicate areas whose sovereignty is disputed, indeterminate, or where the U.S. does not recognize claims; these disputes are summarized in the footnotes of INR's lists, and we can capture this information in the Notes field of each dependency. Whereas INR tracks the state with sovereignty over a dependency, our database does not systematically track this at present; but if we know information about sovereignty, we can use the Notes field to indicate this. When a territory's type changes, we create a new entry to reflect the change. For example, we have two records for Korea in the period 1910-48. In the first record, Korea is a dependency (of the Japanese Empire) from 1910-45, and in the second record, Korea is an independent state (1945-48).

3. Years of validity: The year that a territory, as named and typed above, starts and ends. If we know more precisely when a transition occurred (i.e., the month, or month and day), use the Notes field to indicate this.

4. Predecessors and successors: The terms "predecessor and successor" are meant to be general and free of judgement; they indicate that some significant event happened, such as a change of name or type, as described in the discussion of these items above. To supplement this information, we would like to characterize each change as one of the following:

- Independence (Country declares independence from a colonial power; example: Ghana)
- Secession (Country secedes from another country; example: South Sudan)
- Split (Country splits into two or more countries; example: Czechoslovakia becomes Czech Republic and Slovak Republic)
- Merger (Two or more countries merge to form one country; example: Egypt and Syria join to become the United Arab Republic)
- Rename (Country changes name; example: Cape Verde becomes Cabo Verde)

There may be additional reasons for changes; if you find one that does not fit into one of the above five categories, please describe it as best you can in your notes.

## Build

To get started, clone the repository to your desktop

To run the app (assumes ant and eXist)
- Build the `xar` file(s) with command:    
    1. Single `xar` file: The `collection.xconf` will only contain the index, not any triggers!
        ```shell
        ant
        ```

        1. Since Releases have been automated when building locally you might want to supply your own version number (e.g. `X.X.X`) like this:

    ```shell
    ant -Dapp.version=X.X.X
    ```

## Install

- Open eXist Dashboard > Package Manager
- Click on the `+` icon and drag the `build/gsh-*.xar` file onto the window 
- Close the Package Manager
- Select the app icon from the Dashboard's menu of apps
- Go to the `territories` section

To upload new versions of the app
- In the Package Manager, delete the existing version of the app
- Run ant and upload again

To edit the data (assumes oXygen)
- Open `gsh.xar` in oXygen
- Open files from the `data/territories` folder
- As you make edits, oXygen should flag schema issues
- Also, in the app, cells with likely problems are flagged by `*` and have a yellow background
- Commit fixes as pull requests

## Release

Releases for this data package are automated. Any commit to the `master` branch will trigger the release automation.

All commit message must conform to [Conventional Commit Messages](https://www.conventionalcommits.org/en/v1.0.0/) to determine semantic versioning of releases, please adhere to these conventions, like so:

| Commit message  | Release type |
|-----------------|--------------|
| `fix(pencil): stop graphite breaking when too much pressure applied` | Patch Release |
| `feat(pencil): add 'graphiteWidth' option` | ~~Minor~~ Feature Release |
| `perf(pencil): remove graphiteWidth option`<br/><br/>`BREAKING CHANGE: The graphiteWidth option has been removed.`<br/>`The default graphite width of 10mm is always used for performance reasons.` | ~~Major~~ Breaking Release |

When opening PRs commit messages are checked using commitlint.
