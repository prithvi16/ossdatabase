class GithubReadmeFixerService
  def initialize(html, base_url)
    @html = html
    @base_url = base_url
  end

  def perform
    return if @html.blank?
    sanitized = Sanitize.fragment(@html, Sanitize::Config::RELAXED)

    links_fixed = fix_links sanitized, base_url: @base_url
    Sanitize.fragment(links_fixed, Sanitize::Config::BASIC)
  end

  def fix_links(sanitized, base_url:)
    doc = Nokogiri::HTML.fragment sanitized

    doc.css("a[href]").each do |a|
      adjust_link a, base_url: base_url
    end

    doc.to_s
  end

  def adjust_link(link, base_url:)
    href = link["href"]

    # Scrub links to named anchors
    if href.start_with?("#")
      link.replace link.inner_html
    # Relative links get aligned to base_url, depending on whether
    # it's an absolute or relative path
    elsif base_url && href.exclude?("://")
      link["href"] = if href.start_with?("/")
        URI.join base_url, href
      else
        File.join base_url, href
      end
    end
  end
end
