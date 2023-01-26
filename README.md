[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![CI](https://github.com/Aquatic-Symbiosis-Genomics-Project/grit-rename/actions/workflows/ci.yml/badge.svg)](https://github.com/Aquatic-Symbiosis-Genomics-Project/grit-rename/actions?query=workflow%3ACI)
[![Latest Release](https://img.shields.io/github/v/release/Aquatic-Symbiosis-Genomics-Project/grit-rename.svg)](https://github.com/Aquatic-Symbiosis-Genomics-Project/grit-rename/releases)
# grit-rename

Tool to rename TPF/AGP/FASTA files based on a mapping

## Usage

Usage: grit-rename --map MAPPINGs --fasta FASTAFILE --outdir OUTDIR --tpf TPFFILE
    -m MAPPINGs, --map=MAPPINGS      mappings TSV file FROM<tab>TO
    -f FASTAFILE, --fasta=FASTAFILE  FASTA FILE to rename
    -t TPFFILE, --tpf=TPFFILE        TPF FILE to RENAME
    -o OUTDIR, --outdir=OUTDIR       directory for the renamed files
    -h, --help                       Show this help

## Contributing

1. Fork it (<https://github.com/your-github-user/grit-rename/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [epaule](https://github.com/your-github-user) - creator and maintainer
