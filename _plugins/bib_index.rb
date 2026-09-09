# Parses _bibliography/papers.bib once per build and makes the entries
# available to Liquid, then attaches each paper to its project.
#
# After this runs:
#   site.data.papers   -> every paper, newest first
#   page.papers        -> on a project page, that project's papers
#
# A paper joins a project via `project = {filename}` in the bib entry,
# where filename is the name of the file in _projects/ without .md

require "bibtex"

module HiiLab
  class BibIndex < Jekyll::Generator
    safe true
    priority :high

    BIB_PATH = "_bibliography/papers.bib".freeze

    def generate(site)
      path = File.join(site.source, BIB_PATH)
      unless File.exist?(path)
        Jekyll.logger.warn "BibIndex:", "no bibliography at #{BIB_PATH}, skipping"
        return
      end

      bib = BibTeX.open(path)
      papers = bib.select { |e| e.respond_to?(:entry?) && e.entry? }.map { |e| to_hash(e) }
      papers.sort_by! { |p| [-p["year"].to_i, p["title"].to_s] }
      site.data["papers"] = papers

      collection = site.collections["projects"]
      return if collection.nil?

      by_project = papers.group_by { |p| p["project"] }

      ids = []
      collection.docs.each do |doc|
        id = File.basename(doc.relative_path, File.extname(doc.relative_path))
        ids << id
        doc.data["papers"] = by_project[id] || []
      end

      by_project.each_key do |key|
        next if key.nil? || key.empty? || ids.include?(key)
        Jekyll.logger.warn "BibIndex:", "bib entry has project = {#{key}} but no _projects/#{key}.md exists"
      end

      Jekyll.logger.info "BibIndex:", "indexed #{papers.length} papers across #{ids.length} projects"
    end

    private

    def to_hash(entry)
      {
        "key" => entry.key.to_s,
        "title" => clean(entry["title"]),
        "authors" => authors(entry),
        "year" => clean(entry["year"]),
        "venue" => clean(entry["booktitle"] || entry["journal"] || entry["publisher"]),
        "abbr" => clean(entry["abbr"]),
        "pubtype" => clean(entry["pubtype"]),
        "topics" => list(entry["topics"]),
        "project" => clean(entry["project"]),
        "selected" => clean(entry["selected"]).downcase == "true",
        "doi" => clean(entry["doi"]),
        "pdf" => clean(entry["pdf"]),
        "url" => clean(entry["url"]),
        "abstract" => clean(entry["abstract"]),
      }
    end

    def clean(value)
      return "" if value.nil?
      value.to_s.gsub(/[{}]/, "").gsub(/\s+/, " ").strip
    end

    def list(value)
      clean(value).split(",").map(&:strip).reject(&:empty?)
    end

    def authors(entry)
      raw = clean(entry["author"])
      return [] if raw.empty?
      raw.split(/\s+and\s+/).map do |name|
        if name.include?(",")
          last, first = name.split(",", 2)
          "#{first.strip} #{last.strip}".strip
        else
          name.strip
        end
      end
    end
  end
end