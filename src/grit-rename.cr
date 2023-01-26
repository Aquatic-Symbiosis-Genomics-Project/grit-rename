#!/usr/bin/env crystal
# grit-rename -m TSV -f XYZ.fa -a XYZ.agp  -t XYZ.tpf

# then there is the decision between standardout and an output file

class Mapper
  def initialize(file : String, outdir : String)
    @mapping = Hash(String, String).new
    @map_file = file
    @outdir = outdir
   end


  # parse the mapping
  # mapping between scaffold_ids -> new_ids
  def parse_mapping(file)
    File.each_line(file) do |line|
      key, val = line.split(/\s+/)
      @mapping[key] = val
    end
  end

  # add id mappings from the TPF
  def munge_ids(file)
    File.each_line(file) do |line|
      c = line.split(/\s+/)

      # might need a bit to deal with the id:from-to

      @mapping[c[2]] = @mapping[c[1]] if @mapping.has_key?(c[1])
    end
  end

  # edit the files

  # # fasta
  def fasta(file)
    Dir.mkdir_p(@outdir)
    o_file = File.new("#{@outdir}/#{File.basename(file)}.fa", "w")

    File.each_line(file) do |line|
      if />(\w+)(_unloc\d+)*/.match(line)
        line = line.sub($1, @mapping[$1]) if @mapping.has_key?($1)
      end
      o_file.puts line
    end
  end

  # # tpf
  def tpf(file)
    Dir.mkdir_p(@outdir)
    o_file = File.new("#{@outdir}/#{File.basename(file)}.tpf", "w")
    File.each_line(file) do |line|
      c = line.split("\t")
      if /(\w+)(_unloc\d+)*/.match(c[2])
        c[2] = c[2].sub($1, @mapping[$1]) if @mapping.has_key?($1)
        line = c.join("\t")
      end
      o_file.puts line
    end
  end

  # # agp
  # split by tab then take the first column
  # column[0](_unloc)*

  # # int
  # ???
end

require "option_parser"

mapping_file = "" # mapper
fasta_file = ""
tpf_file = ""
# agp_file=""
out_dir = ""
OptionParser.parse do |parser|
  parser.banner = "Usage: grit-rename --map MAPPINGs --fasta FASTAFILE --outdir OUTDIR --tpf TPFFILE"
  parser.on("-m MAPPINGs", "--map=MAPPINGS", "mappings TSV file FROM<tab>TO") { |m| mapping_file = m }
  parser.on("-f FASTAFILE", "--fasta=FASTAFILE", "FASTA FILE to rename") { |f| fasta_file = f }
  parser.on("-t TPFFILE", "--tpf=TPFFILE", "TPF FILE to RENAME") { |t| tpf_file = t }
  parser.on("-o OUTDIR", "--outdir=OUTDIR", "directory for the renamed files") { |o| out_dir = o }
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end

  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

mapper = Mapper.new(mapping_file,out_dir)
mapper.fasta(fasta_file) if fasta_file
# m.munge_ids(ARGV[1])    #munging ?
mapper.tpf(tpf_file) if tpf_file
