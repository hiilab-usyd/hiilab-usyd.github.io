# Parses _bibliography/papers.bib once per build and makes the entries
# available to Liquid, then attaches each paper to its project and gives
# every paper its own page.
#
# After this runs:
#   site.data.papers      -> every paper, newest first
#   page.papers           -> on a project page, that project's papers
#   /publications/<key>/  -> a page per bib entry, using _layouts/paper.liquid
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
      seen = {}
      papers.each do |paper|
        url_slug = paper["key"]
        if url_slug.empty?
          Jekyll.logger.abort_with "BibIndex:",
            "bib key '#{paper["bibkey"]}' has no usable characters for a URL. Use letters and numbers."
        end
        if seen.key?(url_slug)
          Jekyll.logger.abort_with "BibIndex:",
            "bib keys '#{seen[url_slug]}' and '#{paper["bibkey"]}' both produce /publications/#{url_slug}/. " \
            "Keys must stay unique after lowercasing and stripping punctuation. Rename one."
        end
        seen[url_slug] = paper["bibkey"]
      end
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
        "key" => slug(entry.key.to_s),
        "bibkey" => entry.key.to_s,
        "title" => clean(entry["title"]),
        "authors" => authors(entry),
        "year" => clean(entry["year"]),
        "venue" => clean(entry["booktitle"] || entry["journal"] || entry["publisher"]),
        "abbr" => clean(entry["abbr"]),
        "pubtype" => clean(entry["pubtype"]),
        "topics" => list(entry["topics"]),
        "project" => clean(entry["project"]),
        "selected" => clean(entry["selected"]).downcase == "true",
        "award" => clean(entry["award"]),
        "preview" => clean(entry["preview"]),
        "abstract" => clean(entry["abstract"]),
        "doi" => clean(entry["doi"]),
        "arxiv" => clean(entry["arxiv"]),
        "pdf" => clean(entry["pdf"]),
        "code" => clean(entry["code"]),
        "video" => clean(entry["video"]),
        "slides" => clean(entry["slides"]),
        "poster" => clean(entry["poster"]),
        "website" => clean(entry["website"]),
        "url" => clean(entry["url"]),
        "bibtex" => entry.to_s.strip,
      }
    end

    def clean(value)
      return "" if value.nil?
      value.to_s.gsub(/[{}]/, "").gsub(/\s+/, " ").strip
    end

    def slug(value)
      value.downcase.gsub(/[^a-z0-9]+/, "-").gsub(/\A-|-\z/, "")
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

  # Creates /publications/<key>/ for every entry in the bibliography.
  # Runs after BibIndex, which populates site.data["papers"].
  class PaperPages < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      papers = site.data["papers"]
      return if papers.nil? || papers.empty?

      papers.each do |paper|
        key = paper["key"]
        next if key.nil? || key.empty?

        page = Jekyll::PageWithoutAFile.new(site, site.source, File.join("publications", key), "index.html")
        page.data.merge!(
          "layout" => "paper",
          "title" => paper["title"],
          "description" => paper["abstract"],
          "paper" => paper
        )
        page.content = ""
        site.pages << page
      end

      Jekyll.logger.info "BibIndex:", "generated #{papers.length} paper pages"
    end
  end
end