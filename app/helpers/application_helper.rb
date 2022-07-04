class MarkdownRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    super extensions.merge(link_attributes: {rel: "nofollow noopener"})
  end
end

module ApplicationHelper
  def active_tab_class(path)
    active = false
    active ||= current_page?(path)
    active ? "border-b-2 border-indigo-500" : ""
  end

  def render_markdown_html(input_markdown)
    markdown = Redcarpet::Markdown.new(::MarkdownRenderer, {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      lax_spacing: true,
      strikethrough: true,
      superscript: false,
      tables: true,
      footnotes: true
    })
    markdown.render(input_markdown)
  end

  def render_markdown_text(input_markdown)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)
    markdown.render(input_markdown)
  end
end
