# This file has been generated by node2nix 1.11.1. Do not edit!

{nodeEnv, fetchurl, fetchgit, nix-gitignore, stdenv, lib, globalBuildInputs ? []}:

let
  sources = {
    "@astrojs/compiler-1.8.2" = {
      name = "_at_astrojs_slash_compiler";
      packageName = "@astrojs/compiler";
      version = "1.8.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/@astrojs/compiler/-/compiler-1.8.2.tgz";
        sha512 = "o/ObKgtMzl8SlpIdzaxFnt7SATKPxu4oIP/1NL+HDJRzxfJcAkOTAb/ZKMRyULbz4q+1t2/DAebs2Z1QairkZw==";
      };
    };
    "@astrojs/compiler-2.3.2" = {
      name = "_at_astrojs_slash_compiler";
      packageName = "@astrojs/compiler";
      version = "2.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/@astrojs/compiler/-/compiler-2.3.2.tgz";
        sha512 = "jkY7bCVxl27KeZsSxIZ+pqACe+g8VQUdTiSJRj/sXYdIaZlW3ZMq4qF2M17P/oDt3LBq0zLNwQr4Cb7fSpRGxQ==";
      };
    };
    "@emmetio/abbreviation-2.3.3" = {
      name = "_at_emmetio_slash_abbreviation";
      packageName = "@emmetio/abbreviation";
      version = "2.3.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/@emmetio/abbreviation/-/abbreviation-2.3.3.tgz";
        sha512 = "mgv58UrU3rh4YgbE/TzgLQwJ3pFsHHhCLqY20aJq+9comytTXUDNGG/SMtSeMJdkpxgXSXunBGLD8Boka3JyVA==";
      };
    };
    "@emmetio/css-abbreviation-2.1.8" = {
      name = "_at_emmetio_slash_css-abbreviation";
      packageName = "@emmetio/css-abbreviation";
      version = "2.1.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/@emmetio/css-abbreviation/-/css-abbreviation-2.1.8.tgz";
        sha512 = "s9yjhJ6saOO/uk1V74eifykk2CBYi01STTK3WlXWGOepyKa23ymJ053+DNQjpFcy1ingpaO7AxCcwLvHFY9tuw==";
      };
    };
    "@emmetio/scanner-1.0.4" = {
      name = "_at_emmetio_slash_scanner";
      packageName = "@emmetio/scanner";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/@emmetio/scanner/-/scanner-1.0.4.tgz";
        sha512 = "IqRuJtQff7YHHBk4G8YZ45uB9BaAGcwQeVzgj/zj8/UdOhtQpEIupUhSk8dys6spFIWVZVeK20CzGEnqR5SbqA==";
      };
    };
    "@jridgewell/sourcemap-codec-1.4.15" = {
      name = "_at_jridgewell_slash_sourcemap-codec";
      packageName = "@jridgewell/sourcemap-codec";
      version = "1.4.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/@jridgewell/sourcemap-codec/-/sourcemap-codec-1.4.15.tgz";
        sha512 = "eF2rxCRulEKXHTRiDrDy6erMYWqNw4LPdQ8UQA4huuxaQsVeRPFl2oM8oDGxMFhJUWZf9McpLtJasDDZb/Bpeg==";
      };
    };
    "@nodelib/fs.scandir-2.1.5" = {
      name = "_at_nodelib_slash_fs.scandir";
      packageName = "@nodelib/fs.scandir";
      version = "2.1.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.scandir/-/fs.scandir-2.1.5.tgz";
        sha512 = "vq24Bq3ym5HEQm2NKCr3yXDwjc7vTsEThRDnkp2DK9p1uqLR+DHurm/NOTo0KG7HYHU7eppKZj3MyqYuMBf62g==";
      };
    };
    "@nodelib/fs.stat-2.0.5" = {
      name = "_at_nodelib_slash_fs.stat";
      packageName = "@nodelib/fs.stat";
      version = "2.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.stat/-/fs.stat-2.0.5.tgz";
        sha512 = "RkhPPp2zrqDAQA/2jNhnztcPAlv64XdhIp7a7454A5ovI7Bukxgt7MX7udwAu3zg1DcpPU0rz3VV1SeaqvY4+A==";
      };
    };
    "@nodelib/fs.walk-1.2.8" = {
      name = "_at_nodelib_slash_fs.walk";
      packageName = "@nodelib/fs.walk";
      version = "1.2.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/@nodelib/fs.walk/-/fs.walk-1.2.8.tgz";
        sha512 = "oGB+UxlgWcgQkgwo8GcEGwemoTFt3FIO9ababBmaGwXIoBKZ+GTy0pP185beGg7Llih/NSHSV2XAs1lnznocSg==";
      };
    };
    "@volar/kit-1.10.10" = {
      name = "_at_volar_slash_kit";
      packageName = "@volar/kit";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/kit/-/kit-1.10.10.tgz";
        sha512 = "V2SyUPCPUhueqH8j5t48LJ0QsjExGSXzTv/XOdkUHV7hJ/ekyRGFqKxcfBtMq/nK6Tgu2G1ba+6u0d7e6wKcQw==";
      };
    };
    "@volar/language-core-1.10.10" = {
      name = "_at_volar_slash_language-core";
      packageName = "@volar/language-core";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/language-core/-/language-core-1.10.10.tgz";
        sha512 = "nsV1o3AZ5n5jaEAObrS3MWLBWaGwUj/vAsc15FVNIv+DbpizQRISg9wzygsHBr56ELRH8r4K75vkYNMtsSNNWw==";
      };
    };
    "@volar/language-server-1.10.10" = {
      name = "_at_volar_slash_language-server";
      packageName = "@volar/language-server";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/language-server/-/language-server-1.10.10.tgz";
        sha512 = "F2PRBU+CRjT7L9qe8bjof/uz/LbAXVmgwNU2gOSX2y1bUl3E8DHmD0dB6pwIVublvkx+Ivg/0r3Z6oyxfPPruQ==";
      };
    };
    "@volar/language-service-1.10.10" = {
      name = "_at_volar_slash_language-service";
      packageName = "@volar/language-service";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/language-service/-/language-service-1.10.10.tgz";
        sha512 = "P4fiPWDI6fLGO6BghlksCVHs1nr9gvWAMDyma3Bca4aowxXusxjUVTsnJq0EVorIN5uIr1Xel4B/tNdXt/IKyw==";
      };
    };
    "@volar/source-map-1.10.10" = {
      name = "_at_volar_slash_source-map";
      packageName = "@volar/source-map";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/source-map/-/source-map-1.10.10.tgz";
        sha512 = "GVKjLnifV4voJ9F0vhP56p4+F3WGf+gXlRtjFZsv6v3WxBTWU3ZVeaRaEHJmWrcv5LXmoYYpk/SC25BKemPRkg==";
      };
    };
    "@volar/typescript-1.10.10" = {
      name = "_at_volar_slash_typescript";
      packageName = "@volar/typescript";
      version = "1.10.10";
      src = fetchurl {
        url = "https://registry.npmjs.org/@volar/typescript/-/typescript-1.10.10.tgz";
        sha512 = "4a2r5bdUub2m+mYVnLu2wt59fuoYWe7nf0uXtGHU8QQ5LDNfzAR0wK7NgDiQ9rcl2WT3fxT2AA9AylAwFtj50A==";
      };
    };
    "@vscode/emmet-helper-2.9.2" = {
      name = "_at_vscode_slash_emmet-helper";
      packageName = "@vscode/emmet-helper";
      version = "2.9.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/@vscode/emmet-helper/-/emmet-helper-2.9.2.tgz";
        sha512 = "MaGuyW+fa13q3aYsluKqclmh62Hgp0BpKIqS66fCxfOaBcVQ1OnMQxRRgQUYnCkxFISAQlkJ0qWWPyXjro1Qrg==";
      };
    };
    "@vscode/l10n-0.0.16" = {
      name = "_at_vscode_slash_l10n";
      packageName = "@vscode/l10n";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/@vscode/l10n/-/l10n-0.0.16.tgz";
        sha512 = "JT5CvrIYYCrmB+dCana8sUqJEcGB1ZDXNLMQ2+42bW995WmNoenijWMUdZfwmuQUTQcEVVIa2OecZzTYWUW9Cg==";
      };
    };
    "braces-3.0.2" = {
      name = "braces";
      packageName = "braces";
      version = "3.0.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/braces/-/braces-3.0.2.tgz";
        sha512 = "b8um+L1RzM3WDSzvhm6gIz1yfTbBt6YTlcEKAvsmqCZZFw46z626lVj9j1yEPW33H5H+lBQpZMP1k8l+78Ha0A==";
      };
    };
    "emmet-2.4.6" = {
      name = "emmet";
      packageName = "emmet";
      version = "2.4.6";
      src = fetchurl {
        url = "https://registry.npmjs.org/emmet/-/emmet-2.4.6.tgz";
        sha512 = "dJfbdY/hfeTyf/Ef7Y7ubLYzkBvPQ912wPaeVYpAxvFxkEBf/+hJu4H6vhAvFN6HlxqedlfVn2x1S44FfQ97pg==";
      };
    };
    "fast-glob-3.3.2" = {
      name = "fast-glob";
      packageName = "fast-glob";
      version = "3.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/fast-glob/-/fast-glob-3.3.2.tgz";
        sha512 = "oX2ruAFQwf/Orj8m737Y5adxDQO0LAB7/S5MnxCdTNDd4p6BsyIVsv9JQsATbTSq8KHRpLwIHbVlUNatxd+1Ow==";
      };
    };
    "fastq-1.15.0" = {
      name = "fastq";
      packageName = "fastq";
      version = "1.15.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/fastq/-/fastq-1.15.0.tgz";
        sha512 = "wBrocU2LCXXa+lWBt8RoIRD89Fi8OdABODa/kEnyeyjS5aZO5/GNvI5sEINADqP/h8M29UHTHUb53sUu5Ihqdw==";
      };
    };
    "fill-range-7.0.1" = {
      name = "fill-range";
      packageName = "fill-range";
      version = "7.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/fill-range/-/fill-range-7.0.1.tgz";
        sha512 = "qOo9F+dMUmC2Lcb4BbVvnKJxTPjCm+RRpe4gDuGrzkL7mEVl/djYSu2OdQ2Pa302N4oqkSg9ir6jaLWJ2USVpQ==";
      };
    };
    "glob-parent-5.1.2" = {
      name = "glob-parent";
      packageName = "glob-parent";
      version = "5.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/glob-parent/-/glob-parent-5.1.2.tgz";
        sha512 = "AOIgSQCepiJYwP3ARnGx+5VnTu2HBYdzbGP45eLw1vr3zB3vZLeyed1sC9hnbcOc9/SrMyM5RPQrkGz4aS9Zow==";
      };
    };
    "is-extglob-2.1.1" = {
      name = "is-extglob";
      packageName = "is-extglob";
      version = "2.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-extglob/-/is-extglob-2.1.1.tgz";
        sha512 = "SbKbANkN603Vi4jEZv49LeVJMn4yGwsbzZworEoyEiutsN3nJYdbO36zfhGJ6QEDpOZIFkDtnq5JRxmvl3jsoQ==";
      };
    };
    "is-glob-4.0.3" = {
      name = "is-glob";
      packageName = "is-glob";
      version = "4.0.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-glob/-/is-glob-4.0.3.tgz";
        sha512 = "xelSayHH36ZgE7ZWhli7pW34hNbNl8Ojv5KVmkJD4hBdD3th8Tfk9vYasLM+mXWOZhFkgZfxhLSnrwRr4elSSg==";
      };
    };
    "is-number-7.0.0" = {
      name = "is-number";
      packageName = "is-number";
      version = "7.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/is-number/-/is-number-7.0.0.tgz";
        sha512 = "41Cifkg6e8TylSpdtTpeLVMqvSBEVzTttHvERD741+pnZ8ANv0004MRL43QKPDlK9cGvNp6NZWZUBlbGXYxxng==";
      };
    };
    "jsonc-parser-2.3.1" = {
      name = "jsonc-parser";
      packageName = "jsonc-parser";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/jsonc-parser/-/jsonc-parser-2.3.1.tgz";
        sha512 = "H8jvkz1O50L3dMZCsLqiuB2tA7muqbSg1AtGEkN0leAqGjsUzDJir3Zwr02BhqdcITPg3ei3mZ+HjMocAknhhg==";
      };
    };
    "lru-cache-6.0.0" = {
      name = "lru-cache";
      packageName = "lru-cache";
      version = "6.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/lru-cache/-/lru-cache-6.0.0.tgz";
        sha512 = "Jo6dJ04CmSjuznwJSS3pUeWmd/H0ffTlkXXgwZi+eq1UCmqQwCh+eLsYOYCwY991i2Fah4h1BEMCx4qThGbsiA==";
      };
    };
    "merge2-1.4.1" = {
      name = "merge2";
      packageName = "merge2";
      version = "1.4.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/merge2/-/merge2-1.4.1.tgz";
        sha512 = "8q7VEgMJW4J8tcfVPy8g09NcQwZdbwFEqhe/WZkoIzjn/3TGDwtOCYtXGxA3O8tPzpczCCDgv+P2P5y00ZJOOg==";
      };
    };
    "micromatch-4.0.5" = {
      name = "micromatch";
      packageName = "micromatch";
      version = "4.0.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/micromatch/-/micromatch-4.0.5.tgz";
        sha512 = "DMy+ERcEW2q8Z2Po+WNXuw3c5YaUSFjAO5GsJqfEl7UjvtIuFKO6ZrKvcItdy98dwFI2N1tg3zNIdKaQT+aNdA==";
      };
    };
    "muggle-string-0.3.1" = {
      name = "muggle-string";
      packageName = "muggle-string";
      version = "0.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/muggle-string/-/muggle-string-0.3.1.tgz";
        sha512 = "ckmWDJjphvd/FvZawgygcUeQCxzvohjFO5RxTjj4eq8kw359gFF3E1brjfI+viLMxss5JrHTDRHZvu2/tuy0Qg==";
      };
    };
    "path-browserify-1.0.1" = {
      name = "path-browserify";
      packageName = "path-browserify";
      version = "1.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/path-browserify/-/path-browserify-1.0.1.tgz";
        sha512 = "b7uo2UCUOYZcnF/3ID0lulOJi/bafxa1xPe7ZPsammBSpjSWQkjNxlt635YGS2MiR9GjvuXCtz2emr3jbsz98g==";
      };
    };
    "picomatch-2.3.1" = {
      name = "picomatch";
      packageName = "picomatch";
      version = "2.3.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/picomatch/-/picomatch-2.3.1.tgz";
        sha512 = "JU3teHTNjmE2VCGFzuY8EXzCDVwEqB2a8fsIvwaStHhAWJEeVd1o1QD80CU6+ZdEXXSLbSsuLwJjkCBWqRQUVA==";
      };
    };
    "prettier-3.1.0" = {
      name = "prettier";
      packageName = "prettier";
      version = "3.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/prettier/-/prettier-3.1.0.tgz";
        sha512 = "TQLvXjq5IAibjh8EpBIkNKxO749UEWABoiIZehEPiY4GNpVdhaFKqSTu+QrlU6D2dPAfubRmtJTi4K4YkQ5eXw==";
      };
    };
    "prettier-plugin-astro-0.12.2" = {
      name = "prettier-plugin-astro";
      packageName = "prettier-plugin-astro";
      version = "0.12.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/prettier-plugin-astro/-/prettier-plugin-astro-0.12.2.tgz";
        sha512 = "1OXSEht27zrnX7rCa0bEpLdspeumFW4hnj4+JzPuG5bRlSOAhD0rbXBNZfRD9q0Qbr00EcCcnjd6k6M8q+GfTA==";
      };
    };
    "queue-microtask-1.2.3" = {
      name = "queue-microtask";
      packageName = "queue-microtask";
      version = "1.2.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/queue-microtask/-/queue-microtask-1.2.3.tgz";
        sha512 = "NuaNSa6flKT5JaSYQzJok04JzTL1CA6aGhv5rfLW3PgqA+M2ChpZQnAC8h8i4ZFkBS8X5RqkDBHA7r4hej3K9A==";
      };
    };
    "request-light-0.7.0" = {
      name = "request-light";
      packageName = "request-light";
      version = "0.7.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/request-light/-/request-light-0.7.0.tgz";
        sha512 = "lMbBMrDoxgsyO+yB3sDcrDuX85yYt7sS8BfQd11jtbW/z5ZWgLZRcEGLsLoYw7I0WSUGQBs8CC8ScIxkTX1+6Q==";
      };
    };
    "reusify-1.0.4" = {
      name = "reusify";
      packageName = "reusify";
      version = "1.0.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/reusify/-/reusify-1.0.4.tgz";
        sha512 = "U9nH88a3fc/ekCF1l0/UP1IosiuIjyTh7hBvXVMHYgVcfGvt897Xguj2UOLDeI5BG2m7/uwyaLVT6fbtCwTyzw==";
      };
    };
    "run-parallel-1.2.0" = {
      name = "run-parallel";
      packageName = "run-parallel";
      version = "1.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/run-parallel/-/run-parallel-1.2.0.tgz";
        sha512 = "5l4VyZR86LZ/lDxZTR6jqL8AFE2S0IFLMP26AbjsLVADxHdhB/c0GUsH+y39UfCi3dzz8OlQuPmnaJOMoDHQBA==";
      };
    };
    "s.color-0.0.15" = {
      name = "s.color";
      packageName = "s.color";
      version = "0.0.15";
      src = fetchurl {
        url = "https://registry.npmjs.org/s.color/-/s.color-0.0.15.tgz";
        sha512 = "AUNrbEUHeKY8XsYr/DYpl+qk5+aM+DChopnWOPEzn8YKzOhv4l2zH6LzZms3tOZP3wwdOyc0RmTciyi46HLIuA==";
      };
    };
    "sass-formatter-0.7.8" = {
      name = "sass-formatter";
      packageName = "sass-formatter";
      version = "0.7.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/sass-formatter/-/sass-formatter-0.7.8.tgz";
        sha512 = "7fI2a8THglflhhYis7k06eUf92VQuJoXzEs2KRP0r1bluFxKFvLx0Ns7c478oYGM0fPfrr846ZRWVi2MAgHt9Q==";
      };
    };
    "semver-7.5.4" = {
      name = "semver";
      packageName = "semver";
      version = "7.5.4";
      src = fetchurl {
        url = "https://registry.npmjs.org/semver/-/semver-7.5.4.tgz";
        sha512 = "1bCSESV6Pv+i21Hvpxp3Dx+pSD8lIPt8uVjRrxAUt/nbswYc+tK6Y2btiULjd4+fnq15PX+nqQDC7Oft7WkwcA==";
      };
    };
    "suf-log-2.5.3" = {
      name = "suf-log";
      packageName = "suf-log";
      version = "2.5.3";
      src = fetchurl {
        url = "https://registry.npmjs.org/suf-log/-/suf-log-2.5.3.tgz";
        sha512 = "KvC8OPjzdNOe+xQ4XWJV2whQA0aM1kGVczMQ8+dStAO6KfEB140JEVQ9dE76ONZ0/Ylf67ni4tILPJB41U0eow==";
      };
    };
    "to-regex-range-5.0.1" = {
      name = "to-regex-range";
      packageName = "to-regex-range";
      version = "5.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/to-regex-range/-/to-regex-range-5.0.1.tgz";
        sha512 = "65P7iz6X5yEr1cwcgvQxbbIw7Uk3gOy5dIdtZ4rDveLqhrdJP+Li/Hx6tyK0NEb+2GCyneCMJiGqrADCSNk8sQ==";
      };
    };
    "typesafe-path-0.2.2" = {
      name = "typesafe-path";
      packageName = "typesafe-path";
      version = "0.2.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/typesafe-path/-/typesafe-path-0.2.2.tgz";
        sha512 = "OJabfkAg1WLZSqJAJ0Z6Sdt3utnbzr/jh+NAHoyWHJe8CMSy79Gm085094M9nvTPy22KzTVn5Zq5mbapCI/hPA==";
      };
    };
    "typescript-5.3.2" = {
      name = "typescript";
      packageName = "typescript";
      version = "5.3.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/typescript/-/typescript-5.3.2.tgz";
        sha512 = "6l+RyNy7oAHDfxC4FzSJcz9vnjTKxrLpDG5M2Vu4SHRVNg6xzqZp6LYSR9zjqQTu8DU/f5xwxUdADOkbrIX2gQ==";
      };
    };
    "typescript-auto-import-cache-0.3.0" = {
      name = "typescript-auto-import-cache";
      packageName = "typescript-auto-import-cache";
      version = "0.3.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/typescript-auto-import-cache/-/typescript-auto-import-cache-0.3.0.tgz";
        sha512 = "Rq6/q4O9iyqUdjvOoyas7x/Qf9nWUMeqpP3YeTaLA+uECgfy5wOhfOS+SW/+fZ/uI/ZcKaf+2/ZhFzXh8xfofQ==";
      };
    };
    "volar-service-css-0.0.16" = {
      name = "volar-service-css";
      packageName = "volar-service-css";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-css/-/volar-service-css-0.0.16.tgz";
        sha512 = "gK/XD35t/P3SQrUuS8LMlCnE2ItIk+kXI6gPvBYl1NZ7O+tLH8rUWXA32YgpwNoITxYrm/G1seaq08zs4aiPvg==";
      };
    };
    "volar-service-emmet-0.0.16" = {
      name = "volar-service-emmet";
      packageName = "volar-service-emmet";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-emmet/-/volar-service-emmet-0.0.16.tgz";
        sha512 = "8sWWywzVJOD+PWDArOXDWbiRlM7+peydFhXJT71i4X1WPW32RyPxn6FypvciO+amqpfZP2rXfB9eibIJ+EofSQ==";
      };
    };
    "volar-service-html-0.0.16" = {
      name = "volar-service-html";
      packageName = "volar-service-html";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-html/-/volar-service-html-0.0.16.tgz";
        sha512 = "/oEXXgry++1CnTXQBUNf9B8MZfTlYZuJfZA7Zx9MN7WS4ZPxk3BFOdal/cXH6RNR2ruNEYr5QTW9rsqtoUscag==";
      };
    };
    "volar-service-prettier-0.0.16" = {
      name = "volar-service-prettier";
      packageName = "volar-service-prettier";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-prettier/-/volar-service-prettier-0.0.16.tgz";
        sha512 = "Kj2ZdwJGEvfYbsHW8Sjrew/7EB4PgRoas4f8yAJzUUVxIC/kvhUwLDxQc8+N2IibomN76asJGWe+i6VZZvgIkw==";
      };
    };
    "volar-service-typescript-0.0.16" = {
      name = "volar-service-typescript";
      packageName = "volar-service-typescript";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-typescript/-/volar-service-typescript-0.0.16.tgz";
        sha512 = "k/qFKM2oxs/3fhbr/vcBSHnCLZ1HN3Aeh+bGvV9Lc9qIhrNyCVsDFOUJN1Qp4dI72+Y+eFSIDCLHmFEZdsP2EA==";
      };
    };
    "volar-service-typescript-twoslash-queries-0.0.16" = {
      name = "volar-service-typescript-twoslash-queries";
      packageName = "volar-service-typescript-twoslash-queries";
      version = "0.0.16";
      src = fetchurl {
        url = "https://registry.npmjs.org/volar-service-typescript-twoslash-queries/-/volar-service-typescript-twoslash-queries-0.0.16.tgz";
        sha512 = "0gPrkDTD2bMj2AnSNykOKhfmPnBFE2LS1lF3LWA7qu1ChRnJF0sodwCCbbeNYJ9+yth956ApoU1BVQ8UrMg+yw==";
      };
    };
    "vscode-css-languageservice-6.2.11" = {
      name = "vscode-css-languageservice";
      packageName = "vscode-css-languageservice";
      version = "6.2.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-css-languageservice/-/vscode-css-languageservice-6.2.11.tgz";
        sha512 = "qn49Wa6K94LnizpVxmlYrcPf1Cb36gq1nNueW0COhi4shylXBzET5wuDbH8ZWQlJD0HM5Mmnn7WE9vQVVs+ULA==";
      };
    };
    "vscode-html-languageservice-5.1.1" = {
      name = "vscode-html-languageservice";
      packageName = "vscode-html-languageservice";
      version = "5.1.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-html-languageservice/-/vscode-html-languageservice-5.1.1.tgz";
        sha512 = "JenrspIIG/Q+93R6G3L6HdK96itSisMynE0glURqHpQbL3dKAKzdm8L40lAHNkwJeBg+BBPpAshZKv/38onrTQ==";
      };
    };
    "vscode-jsonrpc-8.2.0" = {
      name = "vscode-jsonrpc";
      packageName = "vscode-jsonrpc";
      version = "8.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-jsonrpc/-/vscode-jsonrpc-8.2.0.tgz";
        sha512 = "C+r0eKJUIfiDIfwJhria30+TYWPtuHJXHtI7J0YlOmKAo7ogxP20T0zxB7HZQIFhIyvoBPwWskjxrvAtfjyZfA==";
      };
    };
    "vscode-languageserver-9.0.1" = {
      name = "vscode-languageserver";
      packageName = "vscode-languageserver";
      version = "9.0.1";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver/-/vscode-languageserver-9.0.1.tgz";
        sha512 = "woByF3PDpkHFUreUa7Hos7+pUWdeWMXRd26+ZX2A8cFx6v/JPTtd4/uN0/jB6XQHYaOlHbio03NTHCqrgG5n7g==";
      };
    };
    "vscode-languageserver-protocol-3.17.5" = {
      name = "vscode-languageserver-protocol";
      packageName = "vscode-languageserver-protocol";
      version = "3.17.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-protocol/-/vscode-languageserver-protocol-3.17.5.tgz";
        sha512 = "mb1bvRJN8SVznADSGWM9u/b07H7Ecg0I3OgXDuLdn307rl/J3A9YD6/eYOssqhecL27hK1IPZAsaqh00i/Jljg==";
      };
    };
    "vscode-languageserver-textdocument-1.0.11" = {
      name = "vscode-languageserver-textdocument";
      packageName = "vscode-languageserver-textdocument";
      version = "1.0.11";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-textdocument/-/vscode-languageserver-textdocument-1.0.11.tgz";
        sha512 = "X+8T3GoiwTVlJbicx/sIAF+yuJAqz8VvwJyoMVhwEMoEKE/fkDmrqUgDMyBECcM2A2frVZIUj5HI/ErRXCfOeA==";
      };
    };
    "vscode-languageserver-types-3.17.5" = {
      name = "vscode-languageserver-types";
      packageName = "vscode-languageserver-types";
      version = "3.17.5";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-languageserver-types/-/vscode-languageserver-types-3.17.5.tgz";
        sha512 = "Ld1VelNuX9pdF39h2Hgaeb5hEZM2Z3jUrrMgWQAu82jMtZp7p3vJT3BzToKtZI7NgQssZje5o0zryOrhQvzQAg==";
      };
    };
    "vscode-nls-5.2.0" = {
      name = "vscode-nls";
      packageName = "vscode-nls";
      version = "5.2.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-nls/-/vscode-nls-5.2.0.tgz";
        sha512 = "RAaHx7B14ZU04EU31pT+rKz2/zSl7xMsfIZuo8pd+KZO6PXtQmpevpq3vxvWNcrGbdmhM/rr5Uw5Mz+NBfhVng==";
      };
    };
    "vscode-uri-2.1.2" = {
      name = "vscode-uri";
      packageName = "vscode-uri";
      version = "2.1.2";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-uri/-/vscode-uri-2.1.2.tgz";
        sha512 = "8TEXQxlldWAuIODdukIb+TR5s+9Ds40eSJrw+1iDDA9IFORPjMELarNQE3myz5XIkWWpdprmJjm1/SxMlWOC8A==";
      };
    };
    "vscode-uri-3.0.8" = {
      name = "vscode-uri";
      packageName = "vscode-uri";
      version = "3.0.8";
      src = fetchurl {
        url = "https://registry.npmjs.org/vscode-uri/-/vscode-uri-3.0.8.tgz";
        sha512 = "AyFQ0EVmsOZOlAnxoFOGOq1SQDWAB7C6aqMGS23svWAllfOaxbuFvcT8D1i8z3Gyn8fraVeZNNmN6e9bxxXkKw==";
      };
    };
    "yallist-4.0.0" = {
      name = "yallist";
      packageName = "yallist";
      version = "4.0.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz";
        sha512 = "3wdGidZyq5PB084XLES5TpOSRA3wjXAlIWMhum2kRcv/41Sn2emQ0dycQW4uZXLejwKvg6EsvbdlVL+FYEct7A==";
      };
    };
  };
in
{
  "@astrojs/language-server" = nodeEnv.buildNodePackage {
    name = "_at_astrojs_slash_language-server";
    packageName = "@astrojs/language-server";
    version = "2.5.2";
    src = fetchurl {
      url = "https://registry.npmjs.org/@astrojs/language-server/-/language-server-2.5.2.tgz";
      sha512 = "O5SMzoQ65wSxA1KygreI9UJYmHpgt15bSYBxceHwqX7OCDM4Ek8mr6mZn45LGDtwM3dp1uup7kp8exfRPwIFbA==";
    };
    dependencies = [
      sources."@astrojs/compiler-2.3.2"
      sources."@emmetio/abbreviation-2.3.3"
      sources."@emmetio/css-abbreviation-2.1.8"
      sources."@emmetio/scanner-1.0.4"
      sources."@jridgewell/sourcemap-codec-1.4.15"
      sources."@nodelib/fs.scandir-2.1.5"
      sources."@nodelib/fs.stat-2.0.5"
      sources."@nodelib/fs.walk-1.2.8"
      sources."@volar/kit-1.10.10"
      sources."@volar/language-core-1.10.10"
      sources."@volar/language-server-1.10.10"
      sources."@volar/language-service-1.10.10"
      sources."@volar/source-map-1.10.10"
      sources."@volar/typescript-1.10.10"
      (sources."@vscode/emmet-helper-2.9.2" // {
        dependencies = [
          sources."vscode-uri-2.1.2"
        ];
      })
      sources."@vscode/l10n-0.0.16"
      sources."braces-3.0.2"
      sources."emmet-2.4.6"
      sources."fast-glob-3.3.2"
      sources."fastq-1.15.0"
      sources."fill-range-7.0.1"
      sources."glob-parent-5.1.2"
      sources."is-extglob-2.1.1"
      sources."is-glob-4.0.3"
      sources."is-number-7.0.0"
      sources."jsonc-parser-2.3.1"
      sources."lru-cache-6.0.0"
      sources."merge2-1.4.1"
      sources."micromatch-4.0.5"
      sources."muggle-string-0.3.1"
      sources."path-browserify-1.0.1"
      sources."picomatch-2.3.1"
      sources."prettier-3.1.0"
      (sources."prettier-plugin-astro-0.12.2" // {
        dependencies = [
          sources."@astrojs/compiler-1.8.2"
        ];
      })
      sources."queue-microtask-1.2.3"
      sources."request-light-0.7.0"
      sources."reusify-1.0.4"
      sources."run-parallel-1.2.0"
      sources."s.color-0.0.15"
      sources."sass-formatter-0.7.8"
      sources."semver-7.5.4"
      sources."suf-log-2.5.3"
      sources."to-regex-range-5.0.1"
      sources."typesafe-path-0.2.2"
      sources."typescript-5.3.2"
      sources."typescript-auto-import-cache-0.3.0"
      sources."volar-service-css-0.0.16"
      sources."volar-service-emmet-0.0.16"
      sources."volar-service-html-0.0.16"
      sources."volar-service-prettier-0.0.16"
      sources."volar-service-typescript-0.0.16"
      sources."volar-service-typescript-twoslash-queries-0.0.16"
      sources."vscode-css-languageservice-6.2.11"
      sources."vscode-html-languageservice-5.1.1"
      sources."vscode-jsonrpc-8.2.0"
      sources."vscode-languageserver-9.0.1"
      sources."vscode-languageserver-protocol-3.17.5"
      sources."vscode-languageserver-textdocument-1.0.11"
      sources."vscode-languageserver-types-3.17.5"
      sources."vscode-nls-5.2.0"
      sources."vscode-uri-3.0.8"
      sources."yallist-4.0.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "The Astro language server, implement the [language server protocol](https://microsoft.github.io/language-server-protocol/)";
      homepage = "https://github.com/withastro/language-tools#readme";
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
}
